codeunit 50021 "Bom Cost Share"
{
    Permissions = tabledata "Bom Cost Share Table" = RMID;
    procedure InitBomCostShare(var BomBuffer: Record "BOM Buffer")
    var
        BomCostShareRec: Record "Bom Cost Share Table";
    begin
        BomCostShareRec.Init();
        BomCostShareRec.TransferFields(BomBuffer);
        BomCostShareRec.Insert();
    end;

    procedure DelBomCostShare(): Boolean
    var
        BomCostShareRec: Record "Bom Cost Share Table";
    begin
        if BomCostShareRec.FindSet() then
            BomCostShareRec.DeleteAll();
    end;
}
