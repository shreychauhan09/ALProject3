

#pragma warning disable AL0789
using Microsoft.Finance.GeneralLedger.Journal;
#pragma warning restore AL0789

#pragma warning disable AA0215
tableextension 50002 "Gen. Jnournal Line Ext" extends "Gen. Journal Line"
#pragma warning restore AA0215
{
    // fields
    // {
    //     field(50000; ""; )
    //     {
    //         Caption = '';
    //         DataClassification = ToBeClassified;
    //     }
    // }
    var
        GeneralJournalLine: Record "Gen. Journal Line";

    PROCEDURE DimensionsBudgetings2(GenJnlLine: Record "Gen. Journal Line");
    VAR
        GLBudgetName: Record 95;
        DimensionSetEntry: Record 480;
        GLBudgetEntry: Record 96;
        GeneralLedgerSetup: Record 98;
        TotalAmtDim: Decimal;
        // SalesLine: Record 37;
        // DimensionSet1: Text;
        // DimensionSet2: Text;
        // SalesLn: Record 37;
#pragma warning disable AA0021
        DimEnt: Record 480;
#pragma warning restore AA0021
        StartDt: Date;
        EndDt: Date;
        TotalAmtDim2: Decimal;
        GLE: Record 17;
        TotalAmtDim3: Decimal;
        TotalAmtDim4: Decimal;
        MonthVar: Integer;
        YearVar: Integer;
    BEGIN
        //LFS:SC:17/04/2024:11759 Created Procedure of Dimension Budgeting to check the line amount with dimensions amount ++
        BEGIN
            GeneralLedgerSetup.GET();
            GLBudgetName.RESET();
            GLBudgetName.SETRANGE("Dimension Budgeting", TRUE);
            IF GLBudgetName.FINDFIRST() THEN BEGIN
                GenJnlLine.RESET();
                GenJnlLine.SETRANGE("Line No.", Rec."Line No.");
                GenJnlLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                GenJnlLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                GenJnlLine.SETRANGE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                GenJnlLine.SETRANGE("Account No.", Rec."Account No.");
                IF GenJnlLine.FINDSET() THEN
                    REPEAT
                        EVALUATE(YearVar, FORMAT(GenJnlLine."Posting Date", 0, '<Year4>'));
                        MonthVar := DATE2DMY(GenJnlLine."Posting Date", 2);
                        CASE MonthVar OF
                            1 .. 3:
                                BEGIN
                                    EVALUATE(StartDt, FORMAT('0101') + FORMAT(YearVar));
                                    EVALUATE(EndDt, FORMAT('0331') + FORMAT(YearVar));
                                END;
                            4 .. 6:
                                BEGIN
                                    EVALUATE(StartDt, FORMAT('0401') + FORMAT(YearVar));
                                    EVALUATE(EndDt, FORMAT('0630') + FORMAT(YearVar));
                                END;
                            7 .. 9:
                                BEGIN
                                    EVALUATE(StartDt, FORMAT('0701') + FORMAT(YearVar));
                                    EVALUATE(EndDt, FORMAT('0930') + FORMAT(YearVar));
                                END;
                            10 .. 12:
                                BEGIN
                                    EVALUATE(StartDt, FORMAT('1001') + FORMAT(YearVar));
                                    EVALUATE(EndDt, FORMAT('1231') + FORMAT(YearVar));
                                END;
                        END;
                        GLBudgetEntry.RESET();
                        GLBudgetEntry.SETRANGE("G/L Account No.", GenJnlLine."Account No.");
                        GLBudgetEntry.SETFILTER("Start Date", '>=%1', StartDt);
                        GLBudgetEntry.SETFILTER("End Date", '<=%1', EndDt);
                        DimensionSetEntry.RESET();
                        DimensionSetEntry.SETCURRENTKEY("Dimension Code");
                        DimensionSetEntry.ASCENDING(TRUE);
                        DimensionSetEntry.SETRANGE("Dimension Set ID", GenJnlLine."Dimension Set ID");
                        DimensionSetEntry.SETRANGE("Dimension Code", GLBudgetName."Budget Dimension 1 Code");
                        //                SalesLine.SETCURRENTKEY("Dimension Set ID");
                        //                SalesLine.SETCURRENTKEY("Department Code");
                        IF DimensionSetEntry.FINDFIRST() THEN BEGIN
                            GLBudgetEntry.SETRANGE("Budget Dimension 1 Code", DimensionSetEntry."Dimension Value Code");
                            //                GLBudgetEntry.SETRANGE("Budget Dimension 1 Code",DimensionSetEntry."Dimension Code");
                            IF GLBudgetEntry.FINDSET() THEN
                                REPEAT
                                    TotalAmtDim += GLBudgetEntry.Amount;
                                UNTIL GLBudgetEntry.NEXT() = 0;
                            TotalAmtDim2 := 0;
                            GeneralJournalLine.RESET();
                            GeneralJournalLine.SETRANGE("Posting Date", StartDt, EndDt);
                            //            SalesHeader.SETRANGE("Document Type",SalesHeader."Document Type"::"Blanket Order");
                            //            IF GeneralJournalLine.FINDSET THEN REPEAT
                            //              SalesLn.RESET;
                            //              SalesLn.SETRANGE("Posting Date",StartDt,EndDt);
                            GeneralJournalLine.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
                            GeneralJournalLine.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
                            GeneralJournalLine.SETRANGE("Account Type", GeneralJournalLine."Account Type"::"G/L Account");
                            GeneralJournalLine.SETRANGE("Account No.", GenJnlLine."Account No.");
                            IF GeneralJournalLine.FINDSET() THEN
                                REPEAT
                                    DimEnt.RESET();
                                    DimEnt.SETRANGE("Dimension Set ID", GeneralJournalLine."Dimension Set ID");
                                    DimEnt.SETRANGE("Dimension Code", GLBudgetName."Budget Dimension 1 Code");
                                    DimEnt.SETRANGE("Dimension Value Code", DimensionSetEntry."Dimension Value Code");
                                    IF DimEnt.FINDFIRST() THEN
                                        //                    REPEAT
                                        TotalAmtDim2 += GeneralJournalLine."Amount (LCY)";
                                //                      UNTIL DimEnt.NEXT = 0;


                                UNTIL GeneralJournalLine.NEXT() = 0;
                            //              UNTIL SalesHeader.NEXT=0;
                            GLE.RESET();
                            GLE.SETRANGE("G/L Account No.", GeneralJournalLine."Account No.");
                            GLE.SETRANGE("Posting Date", StartDt, EndDt);
                            GLE.SETRANGE("Journal Batch Name", GeneralJournalLine."Journal Batch Name");
                            IF GLE.FINDSET() THEN
                                REPEAT
                                    DimEnt.RESET();
                                    DimEnt.SETRANGE("Dimension Set ID", GLE."Dimension Set ID");
                                    DimEnt.SETRANGE("Dimension Code", GLBudgetName."Budget Dimension 1 Code");
                                    DimEnt.SETRANGE("Dimension Value Code", DimensionSetEntry."Dimension Value Code");
#pragma warning disable AA0175
                                    IF DimEnt.FINDFIRST() THEN
#pragma warning restore AA0175
                                        TotalAmtDim3 += GLE.Amount;
                                UNTIL GLE.NEXT() = 0;
                            TotalAmtDim4 := TotalAmtDim2 + TotalAmtDim3;
                        END;
                        IF TotalAmtDim < TotalAmtDim4 THEN
                            ERROR('G/L Budget exceeded');
                    UNTIL GenJnlLine.NEXT() = 0;

            END;
        END;
        //LFS:SC:17/04/2024:11759:Created Procedure of Dimension Budgeting to check the line amount with dimensions amount  --
    END;

}
