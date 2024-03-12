page 60017 "Custom page Line"
{
    ApplicationArea = All;
    Caption = 'Custom page Line';
    PageType = ListPart;
    SourceTable = "Custom API Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Contact No."; Rec."Contact No.")
                {
                    ToolTip = 'Specifies the value of the Contact No. field.';
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
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Copy Records")
            {
                ApplicationArea = All;
                Image = Copy;
                trigger OnAction()
                var
                    dt: DataTransfer;
                    src: Record "Custom API Table";
                    dest: Record "Custom API Line";
                begin
                    dt.SetTables(Database::"Custom API Table", Database::"Custom API Line");
                    dt.AddFieldValue(src.FieldNo("No."), dest.FieldNo("Document No."));
                    dt.AddFieldValue(src.FieldNo(Name), dest.FieldNo(Name));
                    dt.AddConstantValue('X', dest.FieldNo("Address 2"));
                    dt.AddFieldValue(src.FieldNo(Address), dest.FieldNo(Address));
                    // dt.AddSourceFilter(src.FieldNo("S2"), '=%1', 'A');
                    dt.CopyRows();
                end;
            }
        }
    }
}
