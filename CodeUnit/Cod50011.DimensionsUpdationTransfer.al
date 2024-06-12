codeunit 50011 "Dimensions Updation Transfer"
{
    //Updation of Dimension for Transfer Receipt for Transfer-to Code.

    Permissions = tabledata "G/L Entry" = RM,
tabledata "Value Entry" = RM,
tabledata "Vendor Ledger Entry" = RM,
tabledata "Cust. Ledger Entry" = RM,
tabledata "FA Ledger Entry" = RM,
tabledata "Bank Account Ledger Entry" = RM,
tabledata "Employee Ledger Entry" = RM,
tabledata "Item Ledger Entry" = RM;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", OnBeforePostItemJournalLine, '', false, false)]
    local procedure "TransferOrder-Post Receipt_OnBeforePostItemJournalLine"(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferReceiptHeader: Record "Transfer Receipt Header"; TransferReceiptLine: Record "Transfer Receipt Line"; CommitIsSuppressed: Boolean; TransLine: Record "Transfer Line"; PostedWhseRcptHeader: Record "Posted Whse. Receipt Header")
    var
        Location: Record Location;
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        DimSetEntry: Record "Dimension Set Entry";
        DimValue: Record "Dimension Value";
        DimMgt: Codeunit DimensionManagement;
        DefaultDimension: Record "Default Dimension";
        OldDimSetID: Integer;
        NewDimensionSetID: Integer;
    begin
        Location.Get(ItemJournalLine."New Location Code");
        DefaultDimension.RESET;
        DefaultDimension.SETRANGE(DefaultDimension."Table ID", Database::Location);
        DefaultDimension.SETRANGE(DefaultDimension."No.", Location.Code);
        IF DefaultDimension.FINDSET THEN BEGIN
            REPEAT
                OldDimSetID := ItemJournalLine."Dimension Set ID";
                CLEAR(DimMgt);
                CLEAR(TempDimSetEntry);
                DimMgt.GetDimensionSet(TempDimSetEntry, OldDimSetID);
                TempDimSetEntry.RESET;
                TempDimSetEntry.SETRANGE("Dimension Code", DefaultDimension."Dimension Code");
                IF TempDimSetEntry.FINDFIRST THEN BEGIN
                    TempDimSetEntry.VALIDATE("Dimension Value Code", DefaultDimension."Dimension Value Code");
                    TempDimSetEntry.MODIFY;
                END
                ELSE BEGIN
                    TempDimSetEntry.INIT;
                    TempDimSetEntry.VALIDATE("Dimension Code", DefaultDimension."Dimension Code");
                    TempDimSetEntry.VALIDATE("Dimension Value Code", DefaultDimension."Dimension Value Code");
                    TempDimSetEntry.INSERT;
                END;
                NewDimensionSetID := DimMgt.GetDimensionSetID(TempDimSetEntry);

                IF NewDimensionSetID <> OldDimSetID THEN BEGIN
                    ItemJournalLine.Validate("New Shortcut Dimension 1 Code", DefaultDimension."Dimension Value Code");
                    ItemJournalLine.VALIDATE(ItemJournalLine."New Dimension Set ID", NewDimensionSetID);
                END;
            UNTIL DefaultDimension.NEXT = 0;
        END;
    end;

    // Updation of Dimensions for the Functionality of Dimension Correction

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Dim Correction Run", OnAfterUpdateGLEntry, '', false, false)]
    local procedure "Dim Correction Run_OnAfterUpdateGLEntry"(var GLEntry: Record "G/L Entry"; var TempDimCorrectionSetBuffer: Record "Dim Correction Set Buffer"; var Result: Boolean; DimensionCorrectionEntryNo: Integer; var TempInvalidatedDimCorrection: Record "Invalidated Dim Correction" temporary)
    var
        ValEnt: Record "Value Entry";
        GlAcc: Record "G/L Account";
        ILE: Record "Item Ledger Entry";

    begin
        GLEntry.CalcFields("Shortcut Dimension 3 Code", "Shortcut Dimension 4 Code", "Shortcut Dimension 5 Code", "Shortcut Dimension 6 Code", "Shortcut Dimension 7 Code", "Shortcut Dimension 8 Code");
        // GLEntry.SD1 := GLEntry."Shortcut Dimension 3 Code";
        // GLEntry.SD2 := GLEntry."Shortcut Dimension 4 Code";
        // GLEntry.SD3 := GLEntry."Shortcut Dimension 5 Code";
        // GLEntry.SD4 := GLEntry."Shortcut Dimension 6 Code";
        // GLEntry.SD5 := GLEntry."Shortcut Dimension 7 Code";
        // GLEntry.SD6 := GLEntry."Shortcut Dimension 8 Code";
        GLEntry.Modify();


        ValEnt.SetRange("Document No.", GLEntry."Document No.");
        ValEnt.SetRange("Posting Date", GLEntry."Posting Date");
        IF ValEnt.FindFirst() then begin
            // IF GlAcc.Get(GLEntry."G/L Account No.") then
            //     IF GlAcc."Inventory G/L" then begin
            ILE.SetRange("Entry No.", ValEnt."Item Ledger Entry No.");
            IF ILE.FindFirst() then begin
                ILE.Validate("Dimension Set ID", GLEntry."Dimension Set ID");
                ILE."Global Dimension 1 Code" := GLEntry."Global Dimension 1 Code";
                ILE."Global Dimension 2 Code" := GLEntry."Global Dimension 2 Code";
                // ILE.SD1 := GLEntry."Shortcut Dimension 3 Code";
                // ILE.SD2 := GLEntry."Shortcut Dimension 4 Code";
                // ILE.SD3 := GLEntry."Shortcut Dimension 5 Code";
                // ILE.SD4 := GLEntry."Shortcut Dimension 6 Code";
                // ILE.SD5 := GLEntry."Shortcut Dimension 7 Code";
                // ILE.SD6 := GLEntry."Shortcut Dimension 8 Code";
                ILE.Modify();

                ValEnt.Validate("Dimension Set ID", GLEntry."Dimension Set ID");
                ValEnt."Global Dimension 1 Code" := GLEntry."Global Dimension 1 Code";
                ValEnt."Global Dimension 2 Code" := GLEntry."Global Dimension 2 Code";
                // ValEnt.SD1 := GLEntry."Shortcut Dimension 3 Code";
                // ValEnt.SD2 := GLEntry."Shortcut Dimension 4 Code";
                // ValEnt.SD3 := GLEntry."Shortcut Dimension 5 Code";
                // ValEnt.SD4 := GLEntry."Shortcut Dimension 6 Code";
                // ValEnt.SD5 := GLEntry."Shortcut Dimension 7 Code";
                // ValEnt.SD6 := GLEntry."Shortcut Dimension 8 Code";
                ValEnt.Modify();
            end;
        end;
    end;
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Dim Correction Run", OnUpdateGLEntryOnAfterUpdateGlobalDimFromDimSetID, '', false, false)]
    local procedure "Dim Correction Run_OnUpdateGLEntryOnAfterUpdateGlobalDimFromDimSetID"(var GLEntry: Record "G/L Entry")
    var
        VLE: Record "Vendor Ledger Entry";
        VPG: Record "Vendor Posting Group";
        CLE: Record "Cust. Ledger Entry";
        BLE: Record "Bank Account Ledger Entry";
        ILE: Record "Item Ledger Entry";
        ValEnt: Record "Value Entry";
        FLE: Record "FA Ledger Entry";
        InvPostGrp: Record "Inventory Posting Setup";
        FAPostGrp: Record "FA Posting Group";
        GenLedgENt: Record "G/L Entry";
        ELE: Record "Employee Ledger Entry";
        GlAcc: Record "G/L Account";

    begin

        GLEntry.CalcFields("Shortcut Dimension 3 Code", "Shortcut Dimension 4 Code", "Shortcut Dimension 5 Code", "Shortcut Dimension 6 Code", "Shortcut Dimension 7 Code", "Shortcut Dimension 8 Code");


        IF GLEntry."Source Type" = GLEntry."Source Type"::Vendor then begin
            VLE.SetRange("Entry No.", GLEntry."Entry No.");
            if VLE.FindFirst() then begin

                VLE.Validate("Dimension Set ID", GLEntry."Dimension Set ID");
                VLE."Global Dimension 1 Code" := GLEntry."Global Dimension 1 Code";
                VLE."Global Dimension 2 Code" := GLEntry."Global Dimension 2 Code";
                // VLE.SD1 := GLEntry."Shortcut Dimension 3 Code";
                // VLE.SD2 := GLEntry."Shortcut Dimension 4 Code";
                // VLE.SD3 := GLEntry."Shortcut Dimension 5 Code";
                // VLE.SD4 := GLEntry."Shortcut Dimension 6 Code";
                // VLE.SD5 := GLEntry."Shortcut Dimension 7 Code";
                // VLE.SD6 := GLEntry."Shortcut Dimension 8 Code";
                VLE.Modify();

            End;
        end;



        IF GLEntry."Source Type" = GLEntry."Source Type"::Customer then begin
            CLE.SetRange("Entry No.", GLEntry."Entry No.");
            if CLE.FindFirst() then begin
                CLE.Validate("Dimension Set ID", GLEntry."Dimension Set ID");
                CLE."Global Dimension 1 Code" := GLEntry."Global Dimension 1 Code";
                CLE."Global Dimension 2 Code" := GLEntry."Global Dimension 2 Code";
                // CLE.SD1 := GLEntry."Shortcut Dimension 3 Code";
                // CLE.SD2 := GLEntry."Shortcut Dimension 4 Code";
                // CLE.SD3 := GLEntry."Shortcut Dimension 5 Code";
                // CLE.SD4 := GLEntry."Shortcut Dimension 6 Code";
                // CLE.SD5 := GLEntry."Shortcut Dimension 7 Code";
                // CLE.SD6 := GLEntry."Shortcut Dimension 8 Code";
                CLE.Modify();


            end;
        end;

        IF GLEntry."Source Type" = GLEntry."Source Type"::"Bank Account" then begin
            BLE.SetRange("Entry No.", GLEntry."Entry No.");
            if BLE.FindFirst() then begin
                BLE.Validate("Dimension Set ID", GLEntry."Dimension Set ID");
                BLE."Global Dimension 1 Code" := GLEntry."Global Dimension 1 Code";
                BLE."Global Dimension 2 Code" := GLEntry."Global Dimension 2 Code";
                // BLE.SD1 := GLEntry."Shortcut Dimension 3 Code";
                // BLE.SD2 := GLEntry."Shortcut Dimension 4 Code";
                // BLE.SD3 := GLEntry."Shortcut Dimension 5 Code";
                // BLE.SD4 := GLEntry."Shortcut Dimension 6 Code";
                // BLE.SD5 := GLEntry."Shortcut Dimension 7 Code";
                // BLE.SD6 := GLEntry."Shortcut Dimension 8 Code";
                BLE.Modify();


            end;
        end;


        IF GLEntry."FA Entry Type" = GLEntry."FA Entry Type"::"Fixed Asset" then begin
            FLE.SetRange("G/L Entry No.", GLEntry."Entry No.");
            IF FLE.FindFirst() then begin
                // IF FLE."FA Posting Type" = FLE."FA Posting Type"::"Acquisition Cost" then
                //     IF FAPostGrp.Get(FLE."FA Posting Group") then
                //         IF FAPostGrp."Acquisition Cost Account" = GLEntry."G/L Account No." then begin
                FLE.Validate("Dimension Set ID", GLEntry."Dimension Set ID");
                FLE."Global Dimension 1 Code" := GLEntry."Global Dimension 1 Code";
                FLE."Global Dimension 2 Code" := GLEntry."Global Dimension 2 Code";
                // FLE.SD1 := GLEntry."Shortcut Dimension 3 Code";
                // FLE.SD2 := GLEntry."Shortcut Dimension 4 Code";
                // FLE.SD3 := GLEntry."Shortcut Dimension 5 Code";
                // FLE.SD4 := GLEntry."Shortcut Dimension 6 Code";
                // FLE.SD5 := GLEntry."Shortcut Dimension 7 Code";
                // FLE.SD6 := GLEntry."Shortcut Dimension 8 Code";
                FLE.Modify();
                //         end;

            end;
        end;

        IF GLEntry."Source Type" = GLEntry."Source Type"::Employee then begin
            ELE.SetRange("Entry No.", GLEntry."Entry No.");
            if ELE.FindFirst() then begin
                ELE.Validate("Dimension Set ID", GLEntry."Dimension Set ID");
                ELE."Global Dimension 1 Code" := GLEntry."Global Dimension 1 Code";
                ELE."Global Dimension 2 Code" := GLEntry."Global Dimension 2 Code";
                ELE."Shortcut Dimension 3 Code" := GLEntry."Shortcut Dimension 3 Code";
                ELE."Shortcut Dimension 4 Code" := GLEntry."Shortcut Dimension 4 Code";
                ELE."Shortcut Dimension 5 Code" := GLEntry."Shortcut Dimension 5 Code";
                ELE."Shortcut Dimension 6 Code" := GLEntry."Shortcut Dimension 6 Code";
                ELE."Shortcut Dimension 7 Code" := GLEntry."Shortcut Dimension 7 Code";
                ELE."Shortcut Dimension 8 Code" := GLEntry."Shortcut Dimension 8 Code";
                ELE.Modify();

            end;

        end;


    end;
}
