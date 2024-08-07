namespace ALProject.ALProject;
using Microsoft.Sales.Document;

page 50004 "Sales Order Work Description"
{
    Caption = 'Work Description';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "Sales Header";

    layout
    {
        area(content)
        {
            field(WorkDescription; WorkDescription)
            {
                ApplicationArea = All;
                Importance = Additional;
                MultiLine = true;
                ShowCaption = false;
            }
        }
    }

    var
        WorkDescription: Text;

    trigger OnAfterGetRecord()
    begin
        WorkDescription := '';
        if Rec."Work Description".HasValue then
            WorkDescription := Rec.GetWorkDescription();
    end;
}