/// <summary>
/// Page API Card (ID 60016).
/// </summary>
page 60016 "API Card"
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
        }
    }
    trigger OnNextRecord(Steps: Integer): Integer
    begin
        Error('You Can''t go to Next/Previous Record');
    end;
}
