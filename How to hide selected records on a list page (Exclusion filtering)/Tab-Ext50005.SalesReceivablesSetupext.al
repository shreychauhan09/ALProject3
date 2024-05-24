tableextension 50005 "Sales & Receivables Setup ext" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50200; "Hidden Posted Sales Invoices"; Text[2048])
        {
            Caption = 'Hidden Posted Sales Invoices';
            DataClassification = CustomerContent;
        }
    }
}
