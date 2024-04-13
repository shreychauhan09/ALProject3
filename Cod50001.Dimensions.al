codeunit 50001 Dimensions
{
    Permissions = tabledata "Item Ledger Entry" = RM,
    tabledata "Value Entry" = RM,
    tabledata "G/L Entry" = RM;
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
        if Location."Use As In-Transit" = true then begin
            ItemJournalLine.Validate("New Location Code", Location.Code);
        end;
    end;

    /*[EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", OnBeforePostItemJournalLine, '', false, false)]
    local procedure "TransferOrder-Post Receipt_OnBeforePostItemJournalLine"(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferReceiptHeader: Record "Transfer Receipt Header"; TransferReceiptLine: Record "Transfer Receipt Line"; CommitIsSuppressed: Boolean; TransLine: Record "Transfer Line"; PostedWhseRcptHeader: Record "Posted Whse. Receipt Header")
    var
        Location: Record Location;
    begin
        Location.Get(ItemJournalLine."Location Code");
        if Location."Use As In-Transit" = true then begin
            ItemJournalLine.Validate("Location Code", Location.Code);
        end;

        Location.Get(ItemJournalLine."New Location Code");
        ItemJournalLine.Validate("New Location Code", Location.Code);
    end;*/

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", OnAfterPostItemJnlLine, '', false, false)]
    local procedure "TransferOrder-Post Receipt_OnAfterPostItemJnlLine"(ItemJnlLine: Record "Item Journal Line"; var TransLine3: Record "Transfer Line"; var TransRcptHeader2: Record "Transfer Receipt Header"; var TransRcptLine2: Record "Transfer Receipt Line"; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line")
    var
        Location: Record Location;
    begin
        Location.Get(ItemJnlLine."Location Code");
        if Location."Use As In-Transit" = true then begin
            ItemJnlLine.Validate("Location Code", Location.Code);
        end;

        Location.Get(ItemJnlLine."New Location Code");
        ItemJnlLine.Validate("New Location Code", Location.Code);
    end;
}
