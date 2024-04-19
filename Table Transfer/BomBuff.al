tableextension 70200 BomBuffer extends "BOM Buffer"
{
    fields
    {
        field(50000; "Inventory Posting Group"; Code[20])
        {
            Caption = 'Inventory Posting Group';
            DataClassification = ToBeClassified;
        }
    }

    trigger OnAfterInsert()
    var
        BomCostShareRec: Record "Bom Cost Share Table";
        BomCodeUnit: Codeunit "Bom Cost Share";
    begin
        BomCodeUnit.InitBomCostShare(Rec);
    end;
}