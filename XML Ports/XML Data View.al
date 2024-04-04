page 50145 "XML Data View"
{

    ApplicationArea = All;
    Caption = 'XML Data View';
    PageType = List;
    SourceTable = "XML Data";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(AreaCode; Rec.AreaCode)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field(Company; Rec.Company)
                {
                    ApplicationArea = All;
                }
                field(FirstName; Rec.FirstName)
                {
                    ApplicationArea = All;
                }
                field(LastName; Rec.LastName)
                {
                    ApplicationArea = All;
                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = All;
                }
                field(RowID; Rec.RowID)
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field(StreetName; Rec.StreetName)
                {
                    ApplicationArea = All;
                }
                field(StreetNumber; Rec.StreetNumber)
                {
                    ApplicationArea = All;
                }
                field(Suffix; Rec.Suffix)
                {
                    ApplicationArea = All;
                }
                field(Zip; Rec.Zip)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Clear)
            {
                Caption = 'Clear Data';
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    Rec.DeleteAll();
                end;
            }
            action(Import)
            {
                Caption = 'Import';
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    Import: Codeunit "XML Data";
                begin
                    Import.Import();
                end;
            }
            action(Export)
            {
                Caption = 'Export';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    Xmlport.Run(50103, true, false);
                end;

            }
        }
    }
}
