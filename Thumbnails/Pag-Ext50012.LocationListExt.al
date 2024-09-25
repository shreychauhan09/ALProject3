pageextension 50012 "Location List Ext" extends "Location List"
{
    procedure GetSelectionFilter(): Text
    var
        RecLocation: Record Location;
        SelectionFilterManagment: Codeunit GetSelectionFilter;
    begin
        CurrPage.SetSelectionFilter(RecLocation);
        exit(SelectionFilterManagment.GetSelectionFilterForLocation(RecLocation));
    end;
}
