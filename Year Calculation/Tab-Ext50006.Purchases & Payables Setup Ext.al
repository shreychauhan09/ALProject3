tableextension 50006 "Purchases & Payables Setup Ext" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50000; Year; DateFormula)
        {
            Caption = 'Year';
            DataClassification = ToBeClassified;
        }
    }
}
