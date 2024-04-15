codeunit 50001 "Update Location Dimensions"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnAfterCreateItemJnlLine, '', false, false)]
    local procedure "TransferOrder-Post Shipment_OnAfterCreateItemJnlLine"(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferShipmentHeader: Record "Transfer Shipment Header"; TransferShipmentLine: Record "Transfer Shipment Line")
    var
        Location: Record Location;
        DefaultDim: Record "Default Dimension";
        GLSetup: Record "General Ledger Setup";
    begin
        Location.GET(ItemJournalLine."Location Code");
        ItemJournalLine.Validate("Location Code", Location.Code);

        Location.GET(ItemJournalLine."New Location Code");
        ItemJournalLine.Validate("New Location Code", Location.Code);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", OnBeforePostItemJournalLine, '', false, false)]
    local procedure "TransferOrder-Post Receipt_OnBeforePostItemJournalLine"(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferReceiptHeader: Record "Transfer Receipt Header"; TransferReceiptLine: Record "Transfer Receipt Line"; CommitIsSuppressed: Boolean; TransLine: Record "Transfer Line"; PostedWhseRcptHeader: Record "Posted Whse. Receipt Header")
    var
        Location: Record Location;
    begin
        Location.Get(ItemJournalLine."Location Code");
        ItemJournalLine.Validate("Location Code", Location.Code);

        Location.Get(ItemJournalLine."New Location Code");
        ItemJournalLine.Validate("New Location Code", Location.Code);
    end;
}
