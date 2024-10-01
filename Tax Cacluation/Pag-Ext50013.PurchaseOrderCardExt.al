namespace ALProject.ALProject;

using Microsoft.Purchases.Document;

pageextension 50013 "Purchase Order Card Ext" extends "Purchase Order"
{
    layout
    {
        addafter("Include GST in TDS Base")
        {
            field(Message; Rec.Message)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Message field.', Comment = '%';
            }
        }
    }
}
