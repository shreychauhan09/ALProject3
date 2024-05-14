/// <summary>
/// PageExtension Customer List Ext (ID 50000) extends Record Customer List.
/// </summary>
pageextension 50000 "Customer List Ext" extends "Customer List"
{
    layout
    {
        addafter(Name)
        {
            field(Thumbnails; Rec.Thumbnails)
            {
                ApplicationArea = All;
            }
            field(Facebook; Rec.Facebook)
            {
                Caption = 'Facebook';
                ApplicationArea = SocialMedia;
            }

        }
    }
    actions
    {
        addafter(ApplyTemplate)
        {
            action("Update Picture Thumbnails")
            {
                Promoted = true;
                PromotedCategory = Process;
                Image = UpdateDescription;
                ApplicationArea = All;
                trigger OnAction()
                var
                    TenantMedia: Record "Tenant Media";
                begin
                    if Rec.FindSet() then
                        repeat
                            if TenantMedia.Get(Rec.Image.MediaId) then begin
                                TenantMedia.CalcFields(Content);
                                Rec.Thumbnails := TenantMedia.Content;
                                Rec.Modify(true);
                            end else begin
                                if Rec.Thumbnails.HasValue then begin
                                    Rec.CalcFields(Thumbnails);
                                    Clear(Rec.Thumbnails);
                                    Rec.Modify(true);
                                end;
                            end;
                        until Rec.Next() = 0;
                    Rec.FindFirst();
                end;
            }
        }
        addafter(ApplyTemplate)
        {
            action("Fiscal Year")
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    AccPeriod: Record "Accounting Period";
                    Year: Integer;
                    YearTxt: Text;
                    Month: Integer;
                    FiscalYearStart: Text;
                    FiscalYearEnd: Text;
                    FiscalYearTxt: Text;
                    Number: Integer;
                    IsSuccess: Boolean;
                    FiscalYearEndNumber: Integer;
                begin
                    // AccPeriod.Reset();
                    // AccPeriod.SetRange(Closed, false);
                    // AccPeriod.SetFilter("Starting Date", '<=%1', Rec."Last Date Modified");
                    // if AccPeriod.FindFirst() then
                    //     YearTxt := Format(Date2DMY(AccPeriod."Starting Date", 3));
                    // Evaluate(Year, CopyStr(YearTxt, StrLen(YearTxt) - 1, 2));
                    // Month := Month(AccPeriod."Starting Date");
                    // if Month in [01, 02, 03] then
                    //     Year := Year - 1;
                    // Message('Accounting period: %1-%2', Year mod 100, (Year + 1) mod 100);
                    // AccPeriod.Reset();
                    // AccPeriod.SetRange(Closed, false);
                    // AccPeriod.SetFilter("Starting Date", '<=%1', Rec."Last Date Modified");
                    // if AccPeriod.FindLast() then begin
                    //     YearTxt := Format(Date2DMY(AccPeriod."Starting Date", 3)); // Extract the full year

                    //     // Extract the month to decide on the fiscal year treatment
                    //     Month := Date2DMY(AccPeriod."Starting Date", 2);
                    //     if (Month = 1) or (Month = 2) or (Month = 3) then begin
                    //         // If month is Jan, Feb, or Mar, subtract one from the year for the fiscal year start
                    //         FiscalYearStart := Format(Date2DMY(AccPeriod."Starting Date" - 365, 3));
                    //         FiscalYearEnd := CopyStr(YearTxt, 3, 2); // Last two digits of the actual year
                    //     end else begin
                    //         // Otherwise, use the current year as the start of the fiscal period
                    //         FiscalYearStart := CopyStr(YearTxt, 3, 2);
                    //         FiscalYearEnd := Format(Evaluate(Number, CopyStr(YearTxt, 3, 2)) + 1);
                    //          // Increment the last two digits
                    //     end;

                    //     // Format the fiscal year display as "YY-YY"
                    //     FiscalYearTxt := FiscalYearStart + '-' + FiscalYearEnd;
                    // end else
                    //     Error('No accounting period found for the given posting date.');
                    AccPeriod.Reset();
                    // AccPeriod.SetRange(Closed, false);
                    AccPeriod.SetFilter("Starting Date", '<=%1', Rec."Last Date Modified");
                    if AccPeriod.FindFirst() then begin
                        YearTxt := Format(Date2DMY(AccPeriod."Starting Date", 3)); // Extract the full year

                        // Extract the month to decide on the fiscal year treatment
                        Month := Date2DMY(AccPeriod."Starting Date", 2);
                        if (Month = 1) or (Month = 2) or (Month = 3) then begin
                            // If month is Jan, Feb, or Mar, subtract one from the year for the fiscal year start
                            FiscalYearStart := Format(Date2DMY(AccPeriod."Starting Date" - 365, 3));
                            FiscalYearEnd := CopyStr(YearTxt, 3, 2); // Last two digits of the actual year
                        end else begin
                            // Otherwise, use the current year as the start of the fiscal period
                            FiscalYearStart := CopyStr(YearTxt, 3, 2);
                            Evaluate(FiscalYearEndNumber, CopyStr(YearTxt, 3, 2));
                            FiscalYearEndNumber := FiscalYearEndNumber + 1;
                            FiscalYearEnd := Format(FiscalYearEndNumber);// Increment the last two digits
                        end;

                        // Format the fiscal year display as "YY-YY"
                        FiscalYearTxt := FiscalYearStart + '-' + FiscalYearEnd;
                        Message('%1', FiscalYearTxt);
                    end else
                        Error('No accounting period found for the given posting date.');

                end;
            }
            action("Item list - Test01")
            {
                ApplicationArea = All;
                Caption = 'Item list - Test01';
                Image = Open;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    OpenSpecifiedView('aa49406f-6f68-4565-b857-496faa0e77aa_Test0112223', Page::"Item List");
                end;
            }
            action("Item list - Test02")
            {
                ApplicationArea = All;
                Caption = 'Item list - Test02';
                Image = Open;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    OpenSpecifiedView('aa49406f-6f68-4565-b857-496faa0e77aa_Test0221625', Page::"Item List");
                end;
            }
            action("Item list - ZYTest")
            {
                ApplicationArea = All;
                Caption = 'Item list - ZYTest';
                Image = Open;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    OpenSpecifiedView('aa49406f-6f68-4565-b857-496faa0e77aa_ZYTest00045', Page::"Item List");
                end;
            }
            action("Customer Ledger Entries - Invoice")
            {
                ApplicationArea = All;
                Caption = 'Customer Ledger Entries - Invoice';
                Image = Open;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    OpenSpecifiedView('aa49406f-6f68-4565-b857-496faa0e77aa_Invoice07400', Page::"Customer Ledger Entries");
                end;
            }
        }
        addafter(ApprovalEntries)
        {
            action("Open Social Media")
            {
                ApplicationArea = All;
                Caption = 'Open Social Media';
                Image = Information;
                trigger OnAction();
                begin
                    // Call your codeunit here
                    // Codeunit.Run(Codeunit::"Open Social Media");
                end;
            }
        }
    }

    local procedure OpenSpecifiedView(ViewID: Text; PageID: Integer)
    var
        DefaultView: Text;
        URL: Text;
    begin
        DefaultView := '&view=' + ViewID;
        URL := GetUrl(CurrentClientType, CompanyName, ObjectType::Page, PageID) + DefaultView;
        Hyperlink(URL);
    end;

    trigger OnOpenPage()
    var
        EnableSocialExtension: Codeunit "Enable Social Media Extension";
    begin
        if EnableSocialExtension.IsSocialApplicationAreaEnabled() then
            Message('App published: Social Extension');
    end;
}