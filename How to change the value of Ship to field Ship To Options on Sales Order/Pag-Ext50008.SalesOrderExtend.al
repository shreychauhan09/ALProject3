pageextension 50008 "Sales Order Extend" extends "Sales Order"
{
    layout
    {
        modify("Posting Date")
        {
            trigger OnAfterValidate()
            begin
                GetWeekPeriodFromGivenDate(Rec."Posting Date");
                GetMonthPeriodFromGivenDate(Rec."Posting Date");
                GetQuarterPeriodFromGivenDate(Rec."Posting Date");
                GetYearPeriodFromGivenDate(Rec."Posting Date");
            end;
        }
        addlast(General)
        {
            field(LargeText; LargeText)
            {
                Caption = 'Large Text';
                ApplicationArea = All;
                MultiLine = true;
                ShowCaption = false;
                trigger OnValidate()
                begin
                    SetLargeText(LargeText);
                end;
            }
            field("QR Code"; Rec."QR Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the QR Code field.', Comment = '%';
            }

        }
    }
    actions
    {
        addafter("P&osting")
        {
            action(SetShipToOptions)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = SetPriorities;
                Caption = 'Set Ship To Options';

                trigger OnAction()
                var
                    Selected: Integer;
                begin
                    Selected := 0;
                    Selected := StrMenu('Default (Sell-to Address),Alternate Shipping Address,Custom Address', 0, 'Select Ship To Options');
                    case Selected of
                        1:
                            Rec.Validate("Ship-to Code", '');

                        2:
                            Rec.Validate("Ship-to Code", 'FLEET');
                        3:
                            begin
                                Rec.Validate("Ship-to Code", '');
                                Rec.Validate("Ship-to Name", 'Custom Ship To Name');
                            end;
                    end;
                end;
            }
        }
        addbefore(Post)
        {
            action(CopyWorkDescriptionToAttachments)
            {
                ApplicationArea = All;
                Caption = 'Copy Work Description to Attachments';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    InStr: InStream;
                    FileName: Text;
                    DocAttach: Record "Document Attachment";
                    WorkDescriptionLine: Text;
                    TxtBuilder: TextBuilder;
                    TempBlob: Codeunit "Temp Blob";
                    OutStr: OutStream;
                begin
                    WorkDescriptionLine := '';
                    WorkDescriptionLine := Rec.GetWorkDescription();
                    if WorkDescriptionLine <> '' then begin
                        FileName := Format(CurrentDateTime, 0, '<Year><Month,2><Day,2> <Hours24,2>:<Minutes,2>');
                        TxtBuilder.AppendLine(WorkDescriptionLine);
                        TempBlob.CreateOutStream(OutStr);
                        OutStr.WriteText(TxtBuilder.ToText());
                        TempBlob.CreateInStream(InStr);
                        DocAttach.Init();
                        DocAttach.Validate("Table ID", Database::"Sales Header");
                        DocAttach.Validate("Document Type", Enum::"Sales Document Type"::Order);
                        DocAttach.Validate("No.", Rec."No.");
                        DocAttach.Validate("File Name", FileName);
                        DocAttach.Validate("File Extension", 'txt');
                        DocAttach."Document Reference ID".ImportStream(InStr, FileName);
                        DocAttach.Insert(true);
                    end
                end;
            }
        }
        addafter(Post)
        {
            action(SaveReportAsEncodedText)
            {
                Caption = 'Save Sales Report As Encoded Text';
                Image = Transactions;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Base64Convert: Codeunit "Base64 Convert";
                    InStr: InStream;
                    OutStr: OutStream;
                    SalesHeader: Record "Sales Header";
                    RecRef: RecordRef;
                    FldRef: FieldRef;
                    TempBlob: Codeunit "Temp Blob";
                begin
                    if SalesHeader.Get(Rec."Document Type", Rec."No.") then begin
                        RecRef.GetTable(SalesHeader);
                        FldRef := RecRef.Field(SalesHeader.FieldNo("No."));
                        FldRef.SetRange(SalesHeader."No.");
                        TempBlob.CreateOutStream(OutStr);
                        Report.SaveAs(Report::"Standard Sales - Order Conf.", '', ReportFormat::Pdf, OutStr, RecRef);
                        TempBlob.CreateInStream(InStr);
                        LargeText := Base64Convert.ToBase64(InStr, false);
                        SetLargeText(LargeText);
                    end;
                end;
            }
        }
    }
    var
        WeekMsg: Label 'This week: %1 ~ %2\Last week: %3 ~ %4\Next week: %5 ~ %6';
        MonthMsg: Label 'This month: %1 ~ %2\Last month: %3 ~ %4\Next month: %5 ~ %6';
        QuarterMsg: Label 'This quarter: %1 ~ %2\Last quarter: %3 ~ %4\Next quarter: %5 ~ %6';
        YearMsg: Label 'This year: %1 ~ %2\Last year: %3 ~ %4\Next year: %5 ~ %6';
        LargeText: Text;

    trigger OnAfterGetRecord()
    begin
        LargeText := GetLargeText();
    end;

    procedure SetLargeText(NewLargeText: Text)
    var
        OutStream: OutStream;
        SalesHeader: Record "Sales Header";
        QRCodeProvider: Codeunit "QR Generator";
        TempBlob: Codeunit "Temp Blob";
    begin
        SalesHeader.Get(Rec."Document Type", Rec."No.");
        SalesHeader."Large Text".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(LargeText);
        QRCodeProvider.GenerateQRCodeImage(LargeText, TempBlob);
        SalesHeader.Modify();
    end;

    procedure GetLargeText() NewLargeText: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        Rec.CalcFields("Large Text");
        Rec."Large Text".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), Rec.FieldName("Large Text")));
    end;

    local procedure GetWeekPeriodFromGivenDate(GivenDate: Date)
    var
        ThisWeekStartDate: Date;
        ThisWeekEndDate: Date;
        LastWeekStartDate: Date;
        LastWeekEndDate: Date;
        NextWeekStartDate: Date;
        NextWeekEndDate: Date;
    begin
        //This Week
        ThisWeekStartDate := CalcDate('<-CW>', GivenDate);
        ThisWeekEndDate := CalcDate('<CW>', GivenDate);

        //Last Week
        LastWeekStartDate := CalcDate('<-CW-1W>', GivenDate);
        LastWeekEndDate := CalcDate('<CW-1W>', GivenDate);

        //Next Week
        NextWeekStartDate := CalcDate('<-CW+1W>', GivenDate);
        NextWeekEndDate := CalcDate('<CW+1W>', GivenDate);

        Message(WeekMsg, ThisWeekStartDate, ThisWeekEndDate, LastWeekStartDate, LastWeekEndDate, NextWeekStartDate, NextWeekEndDate);
    end;

    local procedure GetMonthPeriodFromGivenDate(GivenDate: Date)
    var
        ThisMonthStartDate: Date;
        ThisMonthEndDate: Date;
        LastMonthStartDate: Date;
        LastMonthEndDate: Date;
        NextMonthStartDate: Date;
        NextMonthEndDate: Date;
    begin
        //This Month
        ThisMonthStartDate := CalcDate('<-CM>', GivenDate);
        ThisMonthEndDate := CalcDate('<CM>', GivenDate);

        //Last Month
        LastMonthStartDate := CalcDate('<-CM-1M>', GivenDate);
        LastMonthEndDate := CalcDate('<CM>', LastMonthStartDate);

        //Next Month
        NextMonthStartDate := CalcDate('<-CM+1M>', GivenDate);
        NextMonthEndDate := CalcDate('<CM>', NextMonthStartDate);

        Message(MonthMsg, ThisMonthStartDate, ThisMonthEndDate, LastMonthStartDate, LastMonthEndDate, NextMonthStartDate, NextMonthEndDate);
    end;

    local procedure GetQuarterPeriodFromGivenDate(GivenDate: Date)
    var
        ThisQuarterStartDate: Date;
        ThisQuarterEndDate: Date;
        LastQuarterStartDate: Date;
        LastQuarterEndDate: Date;
        NextQuarterStartDate: Date;
        NextQuarterEndDate: Date;
    begin
        //This Quarter
        ThisQuarterStartDate := CalcDate('<-CQ>', GivenDate);
        ThisQuarterEndDate := CalcDate('<CQ>', GivenDate);

        //Last Quarter
        LastQuarterStartDate := CalcDate('<-CQ-1Q>', GivenDate);
        LastQuarterEndDate := CalcDate('<CQ>', LastQuarterStartDate);

        //Next Quarter
        NextQuarterStartDate := CalcDate('<-CQ+1Q>', GivenDate);
        NextQuarterEndDate := CalcDate('<CQ>', NextQuarterStartDate);

        Message(QuarterMsg, ThisQuarterStartDate, ThisQuarterEndDate, LastQuarterStartDate, LastQuarterEndDate, NextQuarterStartDate, NextQuarterEndDate);
    end;

    local procedure GetYearPeriodFromGivenDate(GivenDate: Date)
    var
        ThisYearStartDate: Date;
        ThisYearEndDate: Date;
        LastYearStartDate: Date;
        LastYearEndDate: Date;
        NextYearStartDate: Date;
        NextYearEndDate: Date;
    begin
        //This Year
        ThisYearStartDate := CalcDate('<-CY>', GivenDate);
        ThisYearEndDate := CalcDate('<CY>', GivenDate);

        //Last Year
        LastYearStartDate := CalcDate('<-CY-1Y>', GivenDate);
        LastYearEndDate := CalcDate('<CY-1Y>', GivenDate);

        //Next Year
        NextYearStartDate := CalcDate('<-CY+1Y>', GivenDate);
        NextYearEndDate := CalcDate('<CY+1Y>', GivenDate);

        Message(YearMsg, ThisYearStartDate, ThisYearEndDate, LastYearStartDate, LastYearEndDate, NextYearStartDate, NextYearEndDate);
    end;
}
