pageextension 50004 "Customer Card Exts" extends "Customer Card"
{
    layout
    {
        addafter(Name)
        {
            field("Multiple Location Codes"; Rec."Multiple Location Codes")
            {
                ApplicationArea = All;
                trigger OnLookup(var Text: Text): Boolean
                var
                    LocationList: Page "Location List";
                    RecRef: RecordRef;
                    SelectionFilter: Codeunit SelectionFilterManagement;
                    LoctionRec: Record Location;
                begin
                    Clear(LocationList);
                    // RecRef.GetTable(LoctionRec);
                    LocationList.LookupMode := true;
                    if LocationList.RunModal() = Action::LookupOK then begin
                        // LocationList.SetSelectionFilter(LoctionRec);
                        Text += LocationList.GetSelectionFilter();
                        exit(true);
                    end else
                        exit(false);
                end;
            }
        }
    }
}
