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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnBeforeOnRun, '', false, false)]
    local procedure "TransferOrder-Post Shipment_OnBeforeOnRun"(var TransferHeader: Record "Transfer Header"; var HideValidationDialog: Boolean; var SuppressCommit: Boolean; var IsHandled: Boolean)
    var
        Location: Record Location;
        DefaultDim: Record "Default Dimension";
        DimSetEntry: Record "Dimension Set Entry";
        NewSetEntryRequired: Boolean;
        GenLedSetup: Record "General Ledger Setup";
        TransLine: Record "Transfer Line";
    begin
        GenLedSetup.Get();
        Location.Get(TransferHeader."Transfer-From Code");
        DefaultDim.SetRange("Table ID", Database::Location);
        DefaultDim.SetRange("No.", Location.Code);
        if DefaultDim.FindSet() then
            repeat
                DimSetEntry.SetRange("Dimension Set ID", TransferHeader."Dimension Set ID");
                DimSetEntry.SetRange("Dimension Code", DefaultDim."Dimension Code");
                if DimSetEntry.FindFirst() then begin
                    if (DefaultDim."Value Posting" = DefaultDim."Value Posting"::"Same Code") AND (DefaultDim."Dimension Value Code" <> DimSetEntry."Dimension Value Code") then begin
                        if GenLedSetup."Global Dimension 1 Code" = DefaultDim."Dimension Code" then begin
                            TransferHeader.SetHideValidationDialog(True);
                            TransferHeader.Validate("Shortcut Dimension 1 Code", DefaultDim."Dimension Value Code");
                            TransferHeader.Modify();
                        end;
                        if GenLedSetup."Global Dimension 2 Code" = DefaultDim."Dimension Code" then begin
                            TransferHeader.SetHideValidationDialog(True);
                            TransferHeader.Validate("Shortcut Dimension 2 Code", DefaultDim."Dimension Value Code");
                            TransferHeader.Modify();
                            // TransLine.SetRange("Document No.", TransferHeader."No.");
                            // if TransLine.FindSet() then
                            //     TransLine.ModifyAll("Shortcut Dimension 2 Code", TransferHeader."Shortcut Dimension 2 Code");
                        end;
                    end;// else
                        // NewSetEntryRequired := true;
                end;// else
                    //NewSetEntryRequired := true;
            until DefaultDim.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Line", OnAfterIsShippedDimChanged, '', false, false)]
    local procedure "Transfer Line_OnAfterIsShippedDimChanged"(var TransferLine: Record "Transfer Line"; var Result: Boolean)
    begin
        Result := false;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", OnBeforeOnRun, '', false, false)]
    local procedure "TransferOrder-Post Receipt_OnBeforeOnRun"(var TransferHeader2: Record "Transfer Header")
    var
        Location: Record Location;
        DefaultDim: Record "Default Dimension";
        DimSetEntry: Record "Dimension Set Entry";
        NewSetEntryRequired: Boolean;
        GenLedSetup: Record "General Ledger Setup";
        TransLine: Record "Transfer Line";
    begin
        GenLedSetup.Get();
        Location.Get(TransferHeader2."Transfer-to Code");
        DefaultDim.SetRange("Table ID", Database::Location);
        DefaultDim.SetRange("No.", Location.Code);
        if DefaultDim.FindSet() then
            repeat
                DimSetEntry.SetRange("Dimension Set ID", TransferHeader2."Dimension Set ID");
                DimSetEntry.SetRange("Dimension Code", DefaultDim."Dimension Code");
                if DimSetEntry.FindFirst() then begin
                    if (DefaultDim."Value Posting" = DefaultDim."Value Posting"::"Same Code") AND (DefaultDim."Dimension Value Code" <> DimSetEntry."Dimension Value Code") then begin
                        if GenLedSetup."Global Dimension 1 Code" = DefaultDim."Dimension Code" then begin
                            TransferHeader2.SetHideValidationDialog(True);
                            TransferHeader2.Validate("Shortcut Dimension 1 Code", DefaultDim."Dimension Value Code");
                            TransferHeader2.Modify();
                        end;
                        if GenLedSetup."Global Dimension 2 Code" = DefaultDim."Dimension Code" then begin
                            TransferHeader2.SetHideValidationDialog(True);
                            TransferHeader2.Validate("Shortcut Dimension 2 Code", DefaultDim."Dimension Value Code");
                            TransferHeader2.Modify();
                        end;
                    end;
                end;
            until DefaultDim.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Get Source Doc. Inbound", OnBeforeCreateFromInbndTransferOrder, '', false, false)]
    local procedure "Get Source Doc. Inbound_OnBeforeCreateFromInbndTransferOrder"(var TransferHeader: Record "Transfer Header"; var IsHandled: Boolean)
    var
        Location: Record Location;
        DefaultDim: Record "Default Dimension";
        DimSetEntry: Record "Dimension Set Entry";
        GenLedSetup: Record "General Ledger Setup";
        TransLine: Record "Transfer Line";
    begin
        GenLedSetup.Get();
        Location.Get(TransferHeader."Transfer-to Code");
        DefaultDim.SetRange("Table ID", Database::Location);
        DefaultDim.SetRange("No.", Location.Code);
        if DefaultDim.FindSet() then
            repeat
                DimSetEntry.SetRange("Dimension Set ID", TransferHeader."Dimension Set ID");
                DimSetEntry.SetRange("Dimension Code", DefaultDim."Dimension Code");
                if DimSetEntry.FindFirst() then begin
                    if (DefaultDim."Value Posting" = DefaultDim."Value Posting"::"Same Code") AND (DefaultDim."Dimension Value Code" <> DimSetEntry."Dimension Value Code") then begin
                        if GenLedSetup."Global Dimension 1 Code" = DefaultDim."Dimension Code" then begin
                            TransferHeader.SetHideValidationDialog(True);
                            TransferHeader.Validate("Shortcut Dimension 1 Code", DefaultDim."Dimension Value Code");
                            TransferHeader.Modify();
                        end;
                        if GenLedSetup."Global Dimension 2 Code" = DefaultDim."Dimension Code" then begin
                            TransferHeader.SetHideValidationDialog(True);
                            TransferHeader.Validate("Shortcut Dimension 2 Code", DefaultDim."Dimension Value Code");
                            TransferHeader.Modify();
                        end;
                    end;
                end;
            until DefaultDim.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Get Source Doc. Outbound", OnBeforeCreateFromOutbndTransferOrder, '', false, false)]
    local procedure "Get Source Doc. Outbound_OnBeforeCreateFromOutbndTransferOrder"(var TransferHeader: Record "Transfer Header")
    var
        Location: Record Location;
        DefaultDim: Record "Default Dimension";
        DimSetEntry: Record "Dimension Set Entry";
        GenLedSetup: Record "General Ledger Setup";
        TransLine: Record "Transfer Line";
    begin
        GenLedSetup.Get();
        Location.Get(TransferHeader."Transfer-From Code");
        DefaultDim.SetRange("Table ID", Database::Location);
        DefaultDim.SetRange("No.", Location.Code);
        if DefaultDim.FindSet() then
            repeat
                DimSetEntry.SetRange("Dimension Set ID", TransferHeader."Dimension Set ID");
                DimSetEntry.SetRange("Dimension Code", DefaultDim."Dimension Code");
                if DimSetEntry.FindFirst() then begin
                    if (DefaultDim."Value Posting" = DefaultDim."Value Posting"::"Same Code") AND (DefaultDim."Dimension Value Code" <> DimSetEntry."Dimension Value Code") then begin
                        if GenLedSetup."Global Dimension 1 Code" = DefaultDim."Dimension Code" then begin
                            TransferHeader.SetHideValidationDialog(True);
                            TransferHeader.Validate("Shortcut Dimension 1 Code", DefaultDim."Dimension Value Code");
                            TransferHeader.Modify();
                        end;
                        if GenLedSetup."Global Dimension 2 Code" = DefaultDim."Dimension Code" then begin
                            TransferHeader.SetHideValidationDialog(True);
                            TransferHeader.Validate("Shortcut Dimension 2 Code", DefaultDim."Dimension Value Code");
                            TransferHeader.Modify();
                        end;
                    end;
                end;
            until DefaultDim.Next() = 0;
    end;

    local procedure UpdateTransferDimensions(OldDimSetId: Integer; LocCode: Code[20]): Integer
    var
        DefaultDim: Record "Default Dimension";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        DimSetEntry: Record "Dimension Set Entry";
        DimMgt: Codeunit DimensionManagement;
        DimValue: Record "Dimension Value";
        Flag: Boolean;
        NewDimSetID: Integer;
    begin
        TempDimSetEntry.DELETEALL;
        DimSetEntry.SetRange("Dimension Set ID", OldDimSetId);
        if DimSetEntry.FindSet() then
            repeat
                DefaultDim.Reset();
                DefaultDim.SetRange("Table ID", Database::Location);
                DefaultDim.SetRange("No.", LocCode);
                DefaultDim.SetRange("Dimension Code", DimSetEntry."Dimension Code");
                If Not DefaultDim.FindFirst() then begin
                    DimValue.Get(DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code");
                    TempDimSetEntry.INIT;
                    TempDimSetEntry."Dimension Code" := DimValue."Dimension Code";
                    TempDimSetEntry."Dimension Value Code" := DimValue.Code;
                    TempDimSetEntry."Dimension Value ID" := DimValue."Dimension Value ID";
                    TempDimSetEntry.INSERT;
                    Flag := true;
                end;
            until DimSetEntry.Next() = 0;
        if Flag then begin
            DefaultDim.Reset();
            DefaultDim.SetRange("Table ID", Database::Location);
            DefaultDim.SetRange("No.", LocCode);
            if DefaultDim.FindSet() then
                repeat
                    DimValue.Get(DefaultDim."Dimension Code", DefaultDim."Dimension Value Code");
                    TempDimSetEntry.INIT;
                    TempDimSetEntry."Dimension Code" := DefaultDim."Dimension Code";
                    TempDimSetEntry."Dimension Value Code" := DefaultDim."Dimension Value Code";
                    TempDimSetEntry."Dimension Value ID" := DimValue."Dimension Value ID";
                    TempDimSetEntry.INSERT;
                until DefaultDim.Next() = 0;
        end;
        TempDimSetEntry.RESET;
        IF NOT TempDimSetEntry.ISEMPTY THEN
            NewDimSetID := DimMgt.GetDimensionSetID(TempDimSetEntry);
        exit(NewDimSetID);
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
