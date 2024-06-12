namespace ALProject.ALProject;

using Microsoft.Finance.GeneralLedger.Budget;

tableextension 50007 "G/L Budget Name" extends "G/L Budget Name"
{
    fields
    {
        field(50000; "Dimension Budgeting"; Boolean)
        {
            Caption = 'Dimension Budgeting';
            DataClassification = CustomerContent;
        }
    }
}
