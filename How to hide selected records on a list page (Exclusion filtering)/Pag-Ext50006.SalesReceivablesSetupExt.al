pageextension 50006 "Sales & Receivables Setup Ext" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Credit Warnings")
        {
            field("Hidden Posted Sales Invoices"; Rec."Hidden Posted Sales Invoices")
            {
                ApplicationArea = All;
            }
        }
    }
}
