codeunit 50009 "GL Ven Diff"
{

    Permissions = tabledata "GL Vendor Difference" = RMID;
    procedure InitBomCostShare(var GL: Record "G/L Entry")
    var
        BomCostShareRec: Record "GL Vendor Difference";
    begin
        BomCostShareRec.Init();
        BomCostShareRec.TransferFields(GL);
        BomCostShareRec.Insert();
    end;

    procedure DelBomCostShare(): Boolean
    var
        BomCostShareRec: Record "GL Vendor Difference";
    begin
        if BomCostShareRec.FindSet() then
            BomCostShareRec.DeleteAll();
    end;
}