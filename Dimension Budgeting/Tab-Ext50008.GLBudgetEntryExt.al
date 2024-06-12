namespace ALProject.ALProject;

using Microsoft.Finance.GeneralLedger.Budget;

tableextension 50008 "G/L Budget Entry Ext" extends "G/L Budget Entry"
{
    fields
    {
        field(50000; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }
        field(50001; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
    }
}
