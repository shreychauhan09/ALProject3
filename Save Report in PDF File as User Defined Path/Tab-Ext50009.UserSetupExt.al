namespace ALProject.ALProject;

using System.Security.User;

tableextension 50009 "User Setup Ext" extends "User Setup"
{
    fields
    {
        field(50000; "Path to Save Report"; Text[250])
        {
            Caption = 'Path to Save Report';
            DataClassification = CustomerContent;
        }
    }
}
