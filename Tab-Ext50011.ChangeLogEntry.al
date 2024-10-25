namespace ALProject.ALProject;

using System.Diagnostics;

tableextension 50011 "Change Log Entry" extends "Change Log Entry"
{
    fields
    {
        field(50000; "Field Caption Customized"; Text[80])
        {
            Caption = 'Field Caption Customized';
            DataClassification = CustomerContent;
        }
    }
}
