#pragma warning disable AL0679
codeunit 50001 "Update Location Dimensions"
#pragma warning restore AL0679
{
    var
        SingleInstance: Codeunit "Single Insatnce";

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnAfterCreateItemJnlLine, '', false, false)]
    local procedure "TransferOrder-Post Shipment_OnAfterCreateItemJnlLine"(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferShipmentHeader: Record "Transfer Shipment Header"; TransferShipmentLine: Record "Transfer Shipment Line")
    var
        Location: Record Location;
        DefaultDim: Record "Default Dimension";
        GLSetup: Record "General Ledger Setup";
        DimMgt: Codeunit DimensionManagement;
        Dim_SetID: Integer;
    begin
        // SingleInstance.GetGetReceiptLinesBatch();
        // if not TransferLine."Direct Transfer" then begin
        Location.GET(ItemJournalLine."Location Code");
        ItemJournalLine.Validate("Location Code", Location.Code);
        //     Message('Test 1');
        // end;
        // TransferLine.Validate("Transfer-from Code");

        // TransferLine.Validate("Transfer-to Code");
        // if not TransferLine."Direct Transfer" then begin

        // ItemJournalLine.Validate("New Location Code", 'TRANSIT');
        // Dim_SetID := ItemJournalLine."New Dimension Set ID";
        Location.GET(ItemJournalLine."New Location Code");
        ItemJournalLine.Validate("New Location Code", Location.Code);

        //     Message('Test 2');
        //     // TransferLine.Validate("Transfer-to Code");
        // end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", OnBeforePostItemJournalLine, '', false, false)]
    local procedure "TransferOrder-Post Receipt_OnBeforePostItemJournalLine"(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferReceiptHeader: Record "Transfer Receipt Header"; TransferReceiptLine: Record "Transfer Receipt Line"; CommitIsSuppressed: Boolean; TransLine: Record "Transfer Line"; PostedWhseRcptHeader: Record "Posted Whse. Receipt Header")
    var
        Location: Record Location;
    begin
        // if not TransferLine."Direct Transfer" then begin
        Location.Get(ItemJournalLine."Location Code");
        ItemJournalLine.Validate("Location Code", Location.Code);
        //     Message('Test 3');
        // end;
        // TransferLine.Validate("Transfer-to Code");

        // if not TransferLine."Direct Transfer" then begin
        // TransferLine.Validate("Transfer-from Code");
        // if not TransferLine."Direct Transfer" then begin
        Location.Get(ItemJournalLine."New Location Code");
        ItemJournalLine.Validate("New Location Code", Location.Code);
        //     Message('Test 4');
        // End;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Transfer", OnAfterCreateItemJnlLine, '', false, false)]
    local procedure "TransferOrder-Post Transfer_OnAfterCreateItemJnlLine"(var ItemJnlLine: Record "Item Journal Line"; TransLine: Record "Transfer Line"; DirectTransHeader: Record "Direct Trans. Header"; DirectTransLine: Record "Direct Trans. Line")
    var
        Location: Record Location;
    begin
        // Location.GET(ItemJnlLine."Location Code");
        // ItemJnlLine.Validate("Location Code", Location.Code);

        // Location.GET(ItemJnlLine."New Location Code");
        // ItemJnlLine.Validate("New Location Code", Location.Code);
        // Message('Test');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnAfterPostSplitJnlLine, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnAfterPostSplitJnlLine"(var ItemJournalLine: Record "Item Journal Line"; var TempTrackingSpecification: Record "Tracking Specification" temporary)
    begin
    end;

    [EventSubscriber(ObjectType::Report, Report::"Standard Sales - Pro Forma Inv", OnAfterLineOnPreDataItem, '', false, false)]
    local procedure PFInvOnAfterLineOnPreDataItem(var SalesLine: Record "Sales Line")
    begin
        SalesLine.SetRange(Type);
    end;

    [EventSubscriber(ObjectType::Report, Report::"Standard Sales - Pro Forma Inv", OnBeforeGetItemForRec, '', false, false)]
    local procedure PFInvOnBeforeGetItemForRec(var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;
}
