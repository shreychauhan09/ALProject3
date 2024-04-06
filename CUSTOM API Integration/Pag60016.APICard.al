/// <summary>
/// Page API Card (ID 60016).
/// </summary>
#pragma warning disable AL0789
using Microsoft.Foundation.attachment;
using Microsoft.Sales.Document;
#pragma warning restore AL0789
#pragma warning disable AL0679
page 60016 "API Card"
#pragma warning restore AL0679
{
    ApplicationArea = All;
    Caption = 'API Card';
    PageType = Card;
    SourceTable = "Custom API Table";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                    // InstructionalText = 'Please Enter the Customer Name.';
                    // InstructionalTextML = 'Please Enter the Customer Name.';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Specifies the value of the Address 2 field.';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field.';
                }
                field(State; Rec.State)
                {
                    ToolTip = 'Specifies the value of the State field.';
                }
                field("Contact No."; Rec."Contact No.")
                {
                    ToolTip = 'Specifies the value of the Contact No. field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
            }
            part(custom; "Custom page Line")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
                UpdatePropagation = Both;
            }
        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Custom API Table"), "No." = field(Code);
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Shortcut Keys")
            {
                Image = ShortcutToDesktop;
                ShortcutKey = 'Ctrl+F6';
                ApplicationArea = ALL;
                trigger OnAction()
                begin
                    Rec.Validate(Name, 'Mohnish');
                    Rec.Validate(Address, 'Navi Mumbai');
                    Rec.Modify(true);
                end;
            }
            action("Export Json File")
            {
                Image = Export;
                ApplicationArea = All;
                trigger OnAction()
                var
                    Exportjsonfile: Codeunit "Export Json File";
                    customapi: Record "Custom API Table";
                begin

                    customapi.Reset();
                    customapi.SetRange("No.", Rec."No.");
                    if customapi.FindFirst() then begin
                        // Exportjsonfile.RunCustomerApi();
                        Exportjsonfile.SetCustomApi(customapi);
                        Exportjsonfile.Run();
                    end;
                end;
            }
            action("Copy Records")
            {
                ApplicationArea = All;
                Image = Copy;
                // trigger OnAction()
                // var
                //     dt: DataTransfer;
                //     src: Record "Custom API Table";
                //     dest: Record "Custom API Line";
                // begin
                //     dt.SetTables(Database::"Custom API Table", Database::"Custom API Line");
                //     dt.AddFieldValue(src.FieldNo(Name), dest.FieldNo(Name));
                //     dt.AddConstantValue('X', dest.FieldNo("Address 2"));
                //     dt.AddFieldValue(src.FieldNo(Address), dest.FieldNo(Address));
                //     // dt.AddSourceFilter(src.FieldNo("S2"), '=%1', 'A');
                //     dt.CopyFields();
                // end;
                // trigger OnAction()
                // var
                //     src: Record "Custom API Table";
                //     dest: Record "Custom API Line";
                // begin
                //     src.SetRange("No.", Rec."No.");
                //     if src.FindFirst() then begin
                //         dest.Init();
                //         dest.Name := src.Name;
                //         dest.Address := src.Address;
                //         dest."Address 2" := 'X';
                //         dest.Insert();
                //         dest.Modify();
                //     end;
                // end;
                trigger OnAction()
                var
                    src: Record "Custom API Table";
                    dest: Record "Custom API Line";
                begin
                    if src.FindSet() then
                        repeat
                            if not dest.Get(src."No.") then begin
                                dest.Init();
                                dest."Document No." := src."No.";
                                dest.Name := src.Name;
                                dest.Address := src.Address;
                                dest."Address 2" := 'X';
                                dest.Insert();
                            end else begin
                                // Record already exists, update it
                                dest.Name := src.Name;
                                dest.Address := src.Address;
                                dest."Address 2" := 'X';
                                dest.Modify();
                            end;
                        until src.Next() = 0;
                end;
                // trigger OnAction()
                // var
                //     src: Record "Custom API Table";
                //     dest: Record "Custom API Line";
                // begin
                //     dest.SetRange("Document No.", Rec."No.");
                //     if dest.Find('-') then begin
                //         dest.INIT;
                //         dest.Name := src.Name;
                //         dest.Address := src.Address;
                //         dest."Address 2" := 'X';
                //         dest.INSERT;
                //     end;
                // end;
            }
            action(AttachAsPDF)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Attach as PDF';
                Ellipsis = true;
                Image = PrintAttachment;
                ToolTip = 'Create a PDF file and attach it to the document.';

                trigger OnAction()
                var
                    ReportSelections: Record "Report Selections";
                    Usage: Enum "Report Selection Usage";
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader := SalesHeader;
                    SalesHeader.SetRecFilter();
                    ReportSelections.SaveAsDocumentAttachment(
                                Usage::"S.Order".AsInteger(), SalesHeader, SalesHeader."No.", SalesHeader.GetBillToNo(), false);
                end;
            }
        }
    }
    trigger OnNextRecord(Steps: Integer): Integer
    begin
        Error('You Can''t go to Next/Previous Record');
    end;
}
