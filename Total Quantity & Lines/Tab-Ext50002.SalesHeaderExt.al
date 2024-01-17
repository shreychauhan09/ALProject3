/// <summary>
/// TableExtension Sales Header Ext (ID 50002) extends Record Sales Header.
/// </summary>
tableextension 50002 "Sales Header Ext" extends "Sales Header"
{
    fields
    {
        field(50000; "Total Quantity"; Decimal)
        {
            Caption = 'Total Quantity';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Sales Line".Quantity where("Document Type" = field("Document Type"), "Document No." = field("No.")));
        }
        field(50001; "Total Lines"; Integer)
        {
            Caption = 'Total Lines';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count("Sales Line" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
        }
    }
}
