report 50151 "General Voucher Report BC"
{
    //  LFS-NS-06182.00 : 30/03/2017 : Report Changes for G/L Account wise debit and Credit Amount
    //  LFS-NS  :23-05-2017: ,'<>%1&<>%2&<>%3&<>%4','SALESAPPL','UNAPPSALE','PURCHAPPL','UNAPPPURCH' add this code to filtrout the entry
    // 
    // LFS-RKS-1292.00 : 21.11.2018 : Print Prepared by from Voucher header "created by" and Checked by from G/L Entry User id.
    DefaultLayout = RDLC;
    RDLCLayout = './GeneralVoucherReportBC.rdl';

    Caption = 'General Voucher Report BC';

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING("Document No.", "Posting Date", Amount)
                                ORDER(Descending)
                                WHERE("Source Code" = FILTER('<>SALESAPPL&<>UNAPPSALE&<>PURCHAPPL&<>UNAPPPURCH'));
            RequestFilterFields = "Posting Date", "Document No.";
            column(GLAccountNo_GLEntry; "G/L Entry"."G/L Account No.")
            {
            }
            column(VoucherSourceDesc; SourceDesc + ' Voucher')
            {
            }
            column(DocumentNo_GLEntry; "Document No.")
            {
            }
            column(BRANCHADDRESS1; BRANCHADDRESS1)
            {
            }
            column(BRANCHADDRESS2; BRANCHADDRESS2)
            {
            }
            column(PostingDateFormatted; 'Date: ' + FORMAT("Posting Date"))
            {
            }
            column(CompanyInformationAddress; CompanyInformation.Address + ' ' + CompanyInformation."Address 2" + '  ' + CompanyInformation.City)
            {
            }
            column(CompanyInformationName; CompanyInformation.Name)
            {
            }
            column(CreditAmount_GLEntry; "G/L Entry"."Credit Amount")
            {
            }
            column(DebitAmount_GLEntry; "G/L Entry"."Debit Amount")
            {
            }
            column(Caption; NoSeries.Description)
            {
            }
            column(DrText; DrText)
            {
            }
            column(GLAccName1; GLAccName)
            {
            }
            column(CrText; CrText)
            {
            }
            column(DebitAmountTotal; DebitAmountTotal)
            {
            }
            column(CreditAmountTotal; CreditAmountTotal)
            {
            }
            column(ChequeDetail; 'Cheque No: ' + ChequeNo + '  Dated: ' + FORMAT(ChequeDate))
            {
            }
            column(ChequeNo; ChequeNo)
            {
            }
            column(ChequeDate; ChequeDate)
            {
            }
            column(RsNumberText1NumberText2S; 'Rs. ' + NumberText[1] + ' ' + NumberText[2])
            {
            }
            column(EntryNo_GLEntry; "Entry No.")
            {
            }
            column(PostingDate_GLEntry; "Posting Date")
            {
            }
            column(TransactionNo_GLEntryE; "Transaction No.")
            {
            }
            column(VoucherNoCaption; VoucherNoCaptionLbl)
            {
            }
            column(CreditAmountCaption; CreditAmountCaptionLbl)
            {
            }
            column(DebitAmountCaption; DebitAmountCaptionLbl)
            {
            }
            column(ParticularsCaption; ParticularsCaptionLbl)
            {
            }
            column(AmountInWordsCaption; AmountInWordsCaptionLbl)
            {
            }
            column(PreparedByCaption; PreparedByCaptionLbl)
            {
            }
            column(CheckedByCaption; CheckedByCaptionLbl)
            {
            }
            column(ApprovedByCaption; ApprovedByCaptionLbl)
            {
            }
            column(Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(Address; CompanyInformation.Address)
            {
            }
            column(Address2; CompanyInformation."Address 2")
            {
            }
            column(City; CompanyInformation.City)
            {
            }
            column(PostCode; CompanyInformation."Post Code")
            {
            }
            column(PageNo; PageNo)
            {
            }
            column(HasApplicationOf; HasApplicationOf)
            {
            }
            column(UserName; UserName)
            {
            }
            column(Preparedby; Preparedby)
            {
            }
            column(ApproveBy; ApprovedBy)
            {
            }
            column(PostBy; PostBy)
            {
            }
            column(InvoiceNo; "External Document No.")
            {
            }
            column(DocDate; FORMAT("Document Date"))
            {
            }
            column(PurchComment1; PurchComment[1])
            {
            }
            column(PurchComment2; PurchComment[2])
            {
            }
            column(PurchComment3; PurchComment[3])
            {
            }
            column(PurchComment4; PurchComment[4])
            {
            }
            column(PurchComment5; PurchComment[5])
            {
            }
            column(PurchComment6; PurchComment[6])
            {
            }
            column(PurchComment7; PurchComment[7])
            {
            }
            column(PurchComment8; PurchComment[8])
            {
            }
            column(PurchComment9; PurchComment[9])
            {
            }
            column(PurchComment10; PurchComment[10])
            {
            }
            column(tdsper; tdsper)
            {
            }
            column(tdslineamt; tdslineamt)
            {
            }
            column(BillDecptn1; BillDecptn1)
            {
            }
            column(DimValue1; DimValue1)
            {
            }
            column(comet1; comet1)
            {
            }
            column(DimValue; DimValue3)
            {
            }
            column(PrintDimensions; PrintDimensions)
            {
            }
            dataitem(LineNarration; "Posted Narration")
            {
                DataItemLink = "Transaction No." = FIELD("Transaction No."), "Entry No." = FIELD("Entry No.");
                DataItemTableView = SORTING("Entry No.", "Transaction No.", "Line No.");
                column(Narration_LineNarration; Narration)
                {
                }
                column(PrintLineNarration; PrintLineNarration)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF PrintLineNarration THEN BEGIN
                        PageLoop := PageLoop - 1;
                        LinesPrinted := LinesPrinted + 1;
                    END;
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(IntegerOccurcesCaption; IntegerOccurcesCaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    PageLoop := PageLoop - 1;
                end;

                trigger OnPreDataItem()
                begin
                    GLEntry.SETCURRENTKEY("Document No.", "Posting Date", Amount);
                    GLEntry.ASCENDING(FALSE);
                    GLEntry.SETRANGE("Posting Date", "G/L Entry"."Posting Date");
                    GLEntry.SETRANGE("Document No.", "G/L Entry"."Document No.");
                    GLEntry.SETFILTER("Source Code", '<>%1&<>%2&<>%3&<>%4', 'SALESAPPL', 'UNAPPSALE', 'PURCHAPPL', 'UNAPPPURCH');
                    GLEntry.FINDLAST;
                    IF NOT (GLEntry."Entry No." = "G/L Entry"."Entry No.") THEN
                        CurrReport.BREAK;

                    SETRANGE(Number, 1, PageLoop)
                end;
            }
            dataitem(PostedNarration1; "Posted Narration")
            {
                DataItemLink = "Transaction No." = FIELD("Transaction No.");
                DataItemTableView = SORTING("Entry No.", "Transaction No.", "Line No.")
                                    WHERE("Entry No." = FILTER(0));
                column(Narration_PostedNarration1; Narration)
                {
                }
                column(NarrationCaption; NarrationCaptionLbl)
                {
                }

                trigger OnPreDataItem()
                begin
                    GLEntry.SETCURRENTKEY("Document No.", "Posting Date", Amount);
                    GLEntry.ASCENDING(FALSE);
                    GLEntry.SETRANGE("Posting Date", "G/L Entry"."Posting Date");
                    GLEntry.SETRANGE("Document No.", "G/L Entry"."Document No.");
                    GLEntry.SETFILTER("Source Code", '<>%1&<>%2&<>%3&<>%4', 'SALESAPPL', 'UNAPPSALE', 'PURCHAPPL', 'UNAPPPURCH');
                    GLEntry.FINDLAST;
                    IF NOT (GLEntry."Entry No." = "G/L Entry"."Entry No.") THEN
                        CurrReport.BREAK;
                end;
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemTableView = SORTING("Entry No.")
                                    ORDER(Ascending);
                column(VENPOST; "Vendor Ledger Entry"."Posting Date")
                {
                }
                column(VENDODC; "Vendor Ledger Entry"."Document No.")
                {
                }
                column(VENDocument_Date; "Vendor Ledger Entry"."Document Date")
                {
                }
                dataitem(DetailedVendorLedgEntry1; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Applied Vend. Ledger Entry No." = FIELD("Entry No.");
                    DataItemLinkReference = "Vendor Ledger Entry";
                    DataItemTableView = SORTING("Applied Vend. Ledger Entry No.", "Entry Type")
                                        WHERE(Unapplied = CONST(false));
                    column(AppliedVLENo_DtldVendLedgEntry; "Applied Vend. Ledger Entry No.")
                    {
                    }
                    dataitem(VendLedgEntry1; "Vendor Ledger Entry")
                    {
                        DataItemLink = "Entry No." = FIELD("Vendor Ledger Entry No.");
                        DataItemLinkReference = DetailedVendorLedgEntry1;
                        DataItemTableView = SORTING("Entry No.");
                        column(PostingDate_VendLedgEntry1; FORMAT("Posting Date", 0, '<Day,2>/<Month,02>/<Year4>'))
                        {
                        }
                        column(DocType_VendLedgEntry1; "Document Type")
                        {
                            IncludeCaption = true;
                        }
                        column(DocNo_VendLedgEntry1; "Document No.")
                        {
                            IncludeCaption = true;
                        }
                        column(Description_VendLedgEntry1; Description)
                        {
                            IncludeCaption = true;
                        }
                        column(VEND1AMOUNT; VendLedgEntry1."Amount (LCY)")
                        {
                        }
                        column(NegShowAmountVendLedgEntry1; -NegShowAmountVendLedgEntry1)
                        {
                        }
                        column(NegPmtDiscInvCurrVendLedgEntry1; -NegPmtDiscInvCurrVendLedgEntry1)
                        {
                        }
                        column(NegPmtTolInvCurrVendLedgEntry1; -NegPmtTolInvCurrVendLedgEntry1)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF "Entry No." = "Vendor Ledger Entry"."Entry No." THEN
                                CurrReport.SKIP;

                            NegPmtDiscInvCurrVendLedgEntry1 := 0;
                            NegPmtTolInvCurrVendLedgEntry1 := 0;
                            PmtDiscPmtCurr := 0;
                            PmtTolPmtCurr := 0;

                            NegShowAmountVendLedgEntry1 := -DetailedVendorLedgEntry1.Amount;

                            IF "Vendor Ledger Entry"."Currency Code" <> "Currency Code" THEN BEGIN
                                NegPmtDiscInvCurrVendLedgEntry1 := ROUND("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                                NegPmtTolInvCurrVendLedgEntry1 := ROUND("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                                AppliedAmount :=
                                  ROUND(
                                    -DetailedVendorLedgEntry1.Amount / "Original Currency Factor" * "Vendor Ledger Entry"."Original Currency Factor",
                                    Currency."Amount Rounding Precision");
                            END ELSE BEGIN
                                NegPmtDiscInvCurrVendLedgEntry1 := ROUND("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                                NegPmtTolInvCurrVendLedgEntry1 := ROUND("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                                AppliedAmount := -DetailedVendorLedgEntry1.Amount;
                            END;

                            PmtDiscPmtCurr := ROUND("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry"."Original Currency Factor");

                            PmtTolPmtCurr := ROUND("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry"."Original Currency Factor");

                            RemainingAmount := (RemainingAmount - AppliedAmount) + PmtDiscPmtCurr + PmtTolPmtCurr;
                        end;
                    }
                }
                dataitem(DetailedVendorLedgEntry2; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Vendor Ledger Entry No." = FIELD("Entry No.");
                    DataItemLinkReference = "Vendor Ledger Entry";
                    DataItemTableView = SORTING("Vendor Ledger Entry No.", "Entry Type", "Posting Date")
                                        WHERE(Unapplied = CONST(false));
                    column(VLENo_DtldVendLedgEntry; "Vendor Ledger Entry No.")
                    {
                    }
                    dataitem(VendLedgEntry2; "Vendor Ledger Entry")
                    {
                        DataItemLink = "Entry No." = FIELD("Applied Vend. Ledger Entry No.");
                        DataItemLinkReference = DetailedVendorLedgEntry2;
                        DataItemTableView = SORTING("Entry No.");
                        column(NegAppliedAmt; -AppliedAmount)
                        {
                        }
                        column(Description_VendLedgEntry2; Description)
                        {
                        }
                        column(DocNo_VendLedgEntry2; "Document No.")
                        {
                        }
                        column(DocType_VendLedgEntry2; "Document Type")
                        {
                        }
                        column(VEND2AMOUNT; VendLedgEntry2."Amount (LCY)")
                        {
                        }
                        column(PostingDate_VendLedgEntry2; FORMAT("Posting Date", 0, '<Day,2>/<Month,02>/<Year4>'))
                        {
                        }
                        column(NegPmtDiscInvCurrVendLedgEntry2; -NegPmtDiscInvCurrVendLedgEntry1)
                        {
                        }
                        column(NegPmtTolInvCurr1VendLedgEntry2; -NegPmtTolInvCurrVendLedgEntry1)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF "Entry No." = "Vendor Ledger Entry"."Entry No." THEN
                                CurrReport.SKIP;

                            NegPmtDiscInvCurrVendLedgEntry1 := 0;
                            NegPmtTolInvCurrVendLedgEntry1 := 0;
                            PmtDiscPmtCurr := 0;
                            PmtTolPmtCurr := 0;

                            NegShowAmountVendLedgEntry1 := DetailedVendorLedgEntry2.Amount;

                            IF "Vendor Ledger Entry"."Currency Code" <> "Currency Code" THEN BEGIN
                                NegPmtDiscInvCurrVendLedgEntry1 := ROUND("Pmt. Disc. Rcd.(LCY)" * "Original Currency Factor");
                                NegPmtTolInvCurrVendLedgEntry1 := ROUND("Pmt. Tolerance (LCY)" * "Original Currency Factor");
                            END ELSE BEGIN
                                NegPmtDiscInvCurrVendLedgEntry1 := ROUND("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                                NegPmtTolInvCurrVendLedgEntry1 := ROUND("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                            END;

                            PmtDiscPmtCurr := ROUND("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry"."Original Currency Factor");

                            PmtTolPmtCurr := ROUND("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry"."Original Currency Factor");

                            AppliedAmount := DetailedVendorLedgEntry2.Amount;
                            RemainingAmount := (RemainingAmount - AppliedAmount) + PmtDiscPmtCurr + PmtTolPmtCurr;
                        end;
                    }
                }
                dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
                {
                    DataItemTableView = SORTING("Entry No.")
                                        ORDER(Ascending)
                                        WHERE("Entry Type" = FILTER(Application));
                    column(Application_PostingDate; FORMAT(AppliedDate))
                    {
                    }
                    column(Application_DocumentNo; AppliedDocNo)
                    {
                    }
                    column(Application_ExtDocumentNo; InvoiceNo)
                    {
                    }
                    column(Application_DocumentDate; FORMAT(InvoiceDate))
                    {
                    }
                    column(Application_AmountLCY; "Detailed Vendor Ledg. Entry"."Amount (LCY)")
                    {
                    }
                    column(Application_AppliestoID; "Vendor Ledger Entry"."Applies-to ID")
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        VendorLedgerEntry: Record "Vendor Ledger Entry";
                    begin
                        ClearApplicationVariables;
                        VendorLedgerEntry.GET("Vendor Ledger Entry No.");
                        AppliedDocNo := VendorLedgerEntry."Document No.";
                        AppliedDate := VendorLedgerEntry."Posting Date";
                        InvoiceNo := VendorLedgerEntry."External Document No.";
                        InvoiceDate := VendorLedgerEntry."Document Date";
                        CheckRepeatLoop += 1;
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF (("G/L Entry"."Source Code" = 'BANKPYMTV') OR ("G/L Entry"."Source Code" = 'BANKRCPTV')
                          OR ("G/L Entry"."Source Code" = 'CASHPYMTV') OR ("G/L Entry"."Source Code" = 'CASHRCPTV')
                          OR ("G/L Entry"."Source Code" = 'GENJNL') OR ("G/L Entry"."Source Code" = 'PURCHASES')) THEN BEGIN
                            SETFILTER("Applied Vend. Ledger Entry No.", '%1', "Vendor Ledger Entry"."Entry No.");
                            SETFILTER("Vendor Ledger Entry No.", '<>%1', "Vendor Ledger Entry"."Entry No.");
                        END
                        ELSE BEGIN
                            SETFILTER("Vendor Ledger Entry No.", '%1', "Vendor Ledger Entry"."Entry No.");
                        END;
                        SETRANGE("Detailed Vendor Ledg. Entry".Unapplied, false);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CheckRepeatLoop += 1;
                    IF docno1 <> "G/L Entry"."Document No." THEN BEGIN
                        // SETRANGE("Document No.","G/L Entry"."Document No.")
                    END ELSE
                        CurrReport.SKIP;
                    docno1 := "G/L Entry"."Document No.";
                end;

                trigger OnPreDataItem()
                begin
                    // IF (CheckRepeatLoop > 1) THEN
                    //  CurrReport.BREAK;
                    //
                    // IF ((HasApplicationOf = 0) OR (HasApplicationOf = 2)) THEN
                    //   CurrReport.BREAK;


                    SETRANGE("Document No.", "G/L Entry"."Document No.");
                end;
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemTableView = SORTING("Entry No.");
                column(CUSTDOC; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(CUSTPOST; FORMAT("Cust. Ledger Entry"."Posting Date", 0, '<Day,2>/<Month,02>/<Year4>'))
                {
                }
                column(CUSTDocument_Date; "Cust. Ledger Entry"."Document Date")
                {
                }
                dataitem(DetailedCustLedgEntry1; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Applied Cust. Ledger Entry No." = FIELD("Entry No.");
                    DataItemLinkReference = "Cust. Ledger Entry";
                    DataItemTableView = SORTING("Applied Cust. Ledger Entry No.", "Entry Type")
                                        WHERE(Unapplied = CONST(false));
                    dataitem(CustLedgEntry1; "Cust. Ledger Entry")
                    {
                        DataItemLink = "Entry No." = FIELD("Cust. Ledger Entry No.");
                        DataItemLinkReference = DetailedCustLedgEntry1;
                        DataItemTableView = SORTING("Entry No.");
                        column(PostDate_CustLedgEntry1; FORMAT("Posting Date", 0, '<Day,2>/<Month,02>/<Year4>'))
                        {
                        }
                        column(DocType_CustLedgEntry1; "Document Type")
                        {
                            IncludeCaption = true;
                        }
                        column(DocumentNo_CustLedgEntry1; "Document No.")
                        {
                            IncludeCaption = true;
                        }
                        column(Desc_CustLedgEntry1; Description)
                        {
                            IncludeCaption = true;
                        }
                        column(ShowAmount; CustLedgEntry1."Amount (LCY)")
                        {
                        }
                        column(PmtDiscInvCurr; PmtDiscInvCurr)
                        {
                        }
                        column(PmtTolInvCurr; PmtTolInvCurr)
                        {
                        }
                        column(CurrencyCodeCaption; FIELDCAPTION("Currency Code"))
                        {
                        }
                        column(AppliedAmount1; AppliedAmount)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF "Entry No." = "Cust. Ledger Entry"."Entry No." THEN
                                CurrReport.SKIP;

                            PmtDiscInvCurr := 0;
                            PmtTolInvCurr := 0;
                            PmtDiscPmtCurr := 0;
                            PmtTolPmtCurr := 0;

                            ShowAmount := -DetailedCustLedgEntry1.Amount;

                            IF "Cust. Ledger Entry"."Currency Code" <> "Currency Code" THEN BEGIN
                                PmtDiscInvCurr := ROUND("Pmt. Disc. Given (LCY)" * "Original Currency Factor");
                                PmtTolInvCurr := ROUND("Pmt. Tolerance (LCY)" * "Original Currency Factor");
                                AppliedAmount :=
                                  ROUND(
                                    -DetailedCustLedgEntry1.Amount / "Original Currency Factor" *
                                    "Cust. Ledger Entry"."Original Currency Factor", Currency."Amount Rounding Precision");
                            END ELSE BEGIN
                                PmtDiscInvCurr := ROUND("Pmt. Disc. Given (LCY)" * "Cust. Ledger Entry"."Original Currency Factor");
                                PmtTolInvCurr := ROUND("Pmt. Tolerance (LCY)" * "Cust. Ledger Entry"."Original Currency Factor");
                                AppliedAmount := -DetailedCustLedgEntry1.Amount;
                            END;

                            PmtDiscPmtCurr := ROUND("Pmt. Disc. Given (LCY)" * "Cust. Ledger Entry"."Original Currency Factor");
                            PmtTolPmtCurr := ROUND("Pmt. Tolerance (LCY)" * "Cust. Ledger Entry"."Original Currency Factor");

                            RemainingAmount := (RemainingAmount - AppliedAmount) + PmtDiscPmtCurr + PmtTolPmtCurr;
                        end;
                    }
                }
                dataitem(DetailedCustLedgEntry2; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Cust. Ledger Entry No." = FIELD("Entry No.");
                    DataItemLinkReference = "Cust. Ledger Entry";
                    DataItemTableView = SORTING("Cust. Ledger Entry No.", "Entry Type", "Posting Date")
                                        WHERE(Unapplied = CONST(false));
                    dataitem(CustLedgEntry2; "Cust. Ledger Entry")
                    {
                        DataItemLink = "Entry No." = FIELD("Applied Cust. Ledger Entry No.");
                        DataItemLinkReference = DetailedCustLedgEntry2;
                        DataItemTableView = SORTING("Entry No.");
                        column(AppliedAmount; CustLedgEntry2."Amount (LCY)")
                        {
                        }
                        column(Desc_CustLedgEntry2; Description)
                        {
                        }
                        column(DocumentNo_CustLedgEntry2; "Document No.")
                        {
                        }
                        column(DocType_CustLedgEntry2; "Document Type")
                        {
                        }
                        column(PostDate_CustLedgEntry2; FORMAT("Posting Date", 0, '<Day,2>/<Month,02>/<Year4>'))
                        {
                        }
                        column(PmtDiscInvCurr1; PmtDiscInvCurr)
                        {
                        }
                        column(PmtTolInvCurr1; PmtTolInvCurr)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF "Entry No." = "Cust. Ledger Entry"."Entry No." THEN
                                CurrReport.SKIP;

                            PmtDiscInvCurr := 0;
                            PmtTolInvCurr := 0;
                            PmtDiscPmtCurr := 0;
                            PmtTolPmtCurr := 0;

                            ShowAmount := DetailedCustLedgEntry2.Amount;

                            IF "Cust. Ledger Entry"."Currency Code" <> "Currency Code" THEN BEGIN
                                PmtDiscInvCurr := ROUND("Pmt. Disc. Given (LCY)" * "Original Currency Factor");
                                PmtTolInvCurr := ROUND("Pmt. Tolerance (LCY)" * "Original Currency Factor");
                            END ELSE BEGIN
                                PmtDiscInvCurr := ROUND("Pmt. Disc. Given (LCY)" * "Cust. Ledger Entry"."Original Currency Factor");
                                PmtTolInvCurr := ROUND("Pmt. Tolerance (LCY)" * "Cust. Ledger Entry"."Original Currency Factor");
                            END;

                            PmtDiscPmtCurr := ROUND("Pmt. Disc. Given (LCY)" * "Cust. Ledger Entry"."Original Currency Factor");
                            PmtTolPmtCurr := ROUND("Pmt. Tolerance (LCY)" * "Cust. Ledger Entry"."Original Currency Factor");

                            AppliedAmount := DetailedCustLedgEntry2.Amount;
                            RemainingAmount := (RemainingAmount - AppliedAmount) + PmtDiscPmtCurr + PmtTolPmtCurr;
                        end;
                    }
                }
                dataitem(DetailedCustLedgEntry3; "Detailed Cust. Ledg. Entry")
                {
                    DataItemTableView = SORTING("Entry No.")
                                        WHERE("Entry Type" = FILTER(Application));
                    column(Application_PostingDate_Customer; FORMAT(AppliedDate))
                    {
                    }
                    column(Application_DocumentNo_Customer; AppliedDocNo)
                    {
                    }
                    column(Application_ExtDocumentNo_Customer; InvoiceNo)
                    {
                    }
                    column(Application_DocumentDate_Customer; FORMAT(InvoiceDate))
                    {
                    }
                    column(Application_AmountLCY_Customer; "Amount (LCY)")
                    {
                    }
                    column(Application_AppliestoID_Customer; "Cust. Ledger Entry"."Applies-to ID")
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        CustLedgerEntry: Record "Cust. Ledger Entry";
                    begin
                        ClearApplicationVariables;
                        CustLedgerEntry.GET("Cust. Ledger Entry No.");
                        AppliedDocNo := CustLedgerEntry."Document No.";
                        AppliedDate := CustLedgerEntry."Posting Date";
                        InvoiceNo := CustLedgerEntry."External Document No.";
                        InvoiceDate := CustLedgerEntry."Document Date";

                        CheckRepeatLoop += 1;
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF (("G/L Entry"."Source Code" = 'BANKPYMTV') OR ("G/L Entry"."Source Code" = 'BANKRCPTV')
                          OR ("G/L Entry"."Source Code" = 'CASHPYMTV') OR ("G/L Entry"."Source Code" = 'CASHRCPTV')
                          OR ("G/L Entry"."Source Code" = 'GENJNL')) THEN BEGIN
                            SETFILTER("Applied Cust. Ledger Entry No.", '%1', "Cust. Ledger Entry"."Entry No.");
                            SETFILTER("Cust. Ledger Entry No.", '<>%1', "Cust. Ledger Entry"."Entry No.");
                        END
                        ELSE BEGIN
                            SETFILTER("Cust. Ledger Entry No.", '%1', "Cust. Ledger Entry"."Entry No.");
                        END;
                        SETRANGE(Unapplied, false);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CheckRepeatLoop += 1;
                    IF docno1 <> "G/L Entry"."Document No." THEN BEGIN
                        // SETRANGE("Document No.","G/L Entry"."Document No.")
                    END ELSE
                        CurrReport.SKIP;
                    docno1 := "G/L Entry"."Document No.";
                end;

                trigger OnPreDataItem()
                begin
                    // IF (CheckRepeatLoop > 1)   THEN
                    //  CurrReport.BREAK;
                    //
                    // IF ((HasApplicationOf = 0) OR (HasApplicationOf = 1)) THEN
                    //   CurrReport.BREAK;
                    SETRANGE("Document No.", "G/L Entry"."Document No.");
                end;
            }
            dataitem("Detailed GST Ledger Entry"; "Detailed GST Ledger Entry")
            {
                column(GSTPER; "Detailed GST Ledger Entry"."GST %")
                {
                }
                column(GSTAMT; "Detailed GST Ledger Entry"."GST Amount")
                {
                }

                trigger OnPreDataItem()
                begin
                    "Detailed GST Ledger Entry".RESET;
                    "Detailed GST Ledger Entry".SETRANGE("Detailed GST Ledger Entry"."Document No.", "G/L Entry"."Document No.");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //Prepared by print;
                //LFS-RKS-1292.00++
                CLEAR(Preparedby);
                CLEAR(UserName);
                UserTable.RESET;
                UserTable.SETRANGE(UserTable."User Name", "G/L Entry"."User ID");
                IF UserTable.FINDFIRST THEN
                    UserName := UserTable."Full Name";

                ApprovedBy := '';
                PostBy := '';
                SendBy := '';
                approvalentry.RESET;
                approvalentry.SETCURRENTKEY("Last Date-Time Modified");
                approvalentry.SETRANGE("Document No.", "G/L Entry"."Document No.");
                IF approvalentry.FINDLAST THEN BEGIN
                    UserTable.RESET;
                    UserTable.SETRANGE(UserTable."User Name", approvalentry."Last Modified By User ID");
                    IF UserTable.FINDFIRST THEN
                        ApprovedBy := UserTable."Full Name";
                END;


                IF ApprovedBy = '' THEN BEGIN
                    PostedAppEntry.RESET;
                    PostedAppEntry.SETCURRENTKEY("Last Date-Time Modified");
                    PostedAppEntry.SETRANGE("Document No.", "G/L Entry"."Document No.");
                    IF PostedAppEntry.FINDFIRST THEN
                        SendBy := PostedAppEntry."Sender ID";

                    PostedAppEntry.RESET;
                    PostedAppEntry.SETCURRENTKEY("Last Date-Time Modified");
                    PostedAppEntry.SETRANGE("Document No.", "G/L Entry"."Document No.");
                    PostedAppEntry.SETFILTER("Last Modified By ID", '<>%1', SendBy);
                    IF PostedAppEntry.FINDLAST THEN BEGIN
                        UserTable.RESET;
                        UserTable.SETRANGE(UserTable."User Name", PostedAppEntry."Last Modified By ID");
                        IF UserTable.FINDFIRST THEN
                            ApprovedBy := UserTable."Full Name";
                    END;
                END;

                IF ApprovedBy = '' THEN BEGIN
                    UserTable.RESET;
                    UserTable.SETRANGE(UserTable."User Name", "G/L Entry"."User ID");
                    IF UserTable.FINDFIRST THEN
                        ApprovedBy := UserTable."Full Name";
                END;

                UserTable.RESET;
                UserTable.SETRANGE(UserTable."User Name", "G/L Entry"."User ID");
                IF UserTable.FINDFIRST THEN BEGIN
                    PostBy := UserTable."Full Name";
                END;
                //LFS-RKS-1292.00--

                NoSeries.RESET;
                IF NoSeries.GET("G/L Entry"."No. Series") THEN;

                HasApplicationOf := DetermineHasApplicationOf;

                GLAccName := FindGLAccName("G/L Entry"."Source Type", "G/L Entry"."Entry No.", "G/L Entry"."Source No.", "G/L Entry"."G/L Account No.");

                IF Amount < 0 THEN BEGIN
                    CrText := 'To';
                    DrText := '';
                END ELSE BEGIN
                    CrText := '';
                    DrText := 'Dr';
                END;

                SourceDesc := '';
                IF "Source Code" <> '' THEN BEGIN
                    SourceCode.GET("Source Code");
                    SourceDesc := SourceCode.Description;
                END;

                PageLoop := PageLoop - 1;
                LinesPrinted := LinesPrinted + 1;

                ChequeNo := '';
                ChequeDate := 0D;
                IF ("Source No." <> '') AND ("Source Type" = "Source Type"::"Bank Account") THEN BEGIN
                    IF BankAccLedgEntry.GET("Entry No.") THEN BEGIN
                        ChequeNo := BankAccLedgEntry."Cheque No.";
                        ChequeDate := BankAccLedgEntry."Cheque Date";
                    END;
                END;

                IF (ChequeNo <> '') AND (ChequeDate <> 0D) THEN BEGIN
                    PageLoop := PageLoop - 1;
                    LinesPrinted := LinesPrinted + 1;
                END;
                IF PostingDate <> "Posting Date" THEN BEGIN
                    PostingDate := "Posting Date";
                    TotalDebitAmt := 0;
                END;
                IF DocumentNo <> "Document No." THEN BEGIN
                    DocumentNo := "Document No.";
                    TotalDebitAmt := 0;
                END;

                IF PostingDate = "Posting Date" THEN BEGIN
                    InitTextVariable;
                    TotalDebitAmt += "Debit Amount";
                    FormatNoText(NumberText, ABS(TotalDebitAmt), '');
                    PageLoop := NUMLines;
                    LinesPrinted := 0;
                END;
                IF (PrePostingDate <> "Posting Date") OR (PreDocumentNo <> "Document No.") THEN BEGIN
                    DebitAmountTotal := 0;
                    CreditAmountTotal := 0;
                    PrePostingDate := "Posting Date";
                    PreDocumentNo := "Document No.";

                    CheckRepeatLoop := 0;
                END;

                DebitAmountTotal := DebitAmountTotal + "Debit Amount";
                CreditAmountTotal := CreditAmountTotal + "Credit Amount";

                PageNo := 1;
                j := 0;

                WHILE (j < 10)
                  DO BEGIN
                    j += 1;
                    PurchComment[j] := '';
                END;
                j := 0;


                IF PurchInvHead.GET("G/L Entry"."Document No.") THEN BEGIN
                    PostedPurchComment.RESET;
                    PostedPurchComment.SETRANGE(PostedPurchComment."Document Type", PostedPurchComment."Document Type"::"Posted Invoice");
                    PostedPurchComment.SETRANGE(PostedPurchComment."No.", PurchInvHead."No.");
                    PostedPurchComment.SETRANGE(PostedPurchComment."Document Line No.", 0);
                    IF PostedPurchComment.FIND('-') THEN
                        REPEAT
                            j += 1;
                            IF PurchComment[1] = '' THEN
                                PurchComment[1] := PostedPurchComment.Comment
                            ELSE BEGIN
                                PurchComment[j] += ' ' + PostedPurchComment.Comment;
                            END;
                        UNTIL PostedPurchComment.NEXT = 0;
                END;


                CLEAR(DebitAmount);
                CLEAR(CreditAmount);
                // to get Debit amount
                glentrynew.RESET;
                glentrynew.SETFILTER("Source Code", '<>%1&<>%2&<>%3&<>%4', 'SALESAPPL', 'UNAPPSALE', 'PURCHAPPL', 'UNAPPPURCH');
                glentrynew.SETRANGE("Document No.", "Document No.");
                glentrynew.SETRANGE("G/L Account No.", "G/L Account No.");

                glentrynew.SETFILTER(Amount, '>%1', 0);
                IF glentrynew.FINDFIRST THEN
                    REPEAT
                        DebitAmount += glentrynew.Amount;

                    UNTIL glentrynew.NEXT = 0;

                // to get Credit amount
                glentrynew.RESET;
                glentrynew.SETFILTER("Source Code", '<>%1&<>%2&<>%3&<>%4', 'SALESAPPL', 'UNAPPSALE', 'PURCHAPPL', 'UNAPPPURCH');
                glentrynew.SETRANGE("Document No.", "Document No.");
                glentrynew.SETRANGE("G/L Account No.", "G/L Account No.");
                glentrynew.SETFILTER(Amount, '<%1', 0);

                IF glentrynew.FINDFIRST THEN
                    REPEAT
                        CreditAmount += glentrynew.Amount;
                    UNTIL glentrynew.NEXT = 0;

                IF (Amount > 0) THEN BEGIN
                    debitamt := DebitAmount;
                    creditamt := 0;
                END
                ELSE BEGIN
                    debitamt := 0;
                    creditamt := CreditAmount * -1;
                END;

                CLEAR(BRANCHADDRESS1);
                CLEAR(BRANCHADDRESS2);
                RecDimValue.RESET;
                RecDimValue.SETRANGE("Dimension Code", 'BRANCH');
                RecDimValue.SETRANGE(Code, "G/L Entry"."Global Dimension 1 Code");
                IF RecDimValue.FINDFIRST THEN BEGIN
                    //  BRANCHADDRESS1 := RecDimValue."Branch Address 1";    //LFS-AK
                    //  BRANCHADDRESS2 := RecDimValue."Branch Address 2";    //LFS-AK
                END;

                //LFS-MP++
                tdsper := '';
                tdslineamt := '';
                RecTDSEntry.RESET;
                RecTDSEntry.SETRANGE("Document No.", "Document No.");
                IF RecTDSEntry.FINDSET THEN
                    REPEAT
                        tdsper += FORMAT(RecTDSEntry."TDS %") + '%' + ',';
                        tdslineamt += FORMAT(RecTDSEntry."TDS Line Amount") + '|';
                    UNTIL RecTDSEntry.NEXT = 0;
                //LFS-MP--
                BillDecptn1 := '';
                IF docno <> "G/L Entry"."Document No." THEN BEGIN
                    DetailedGSTLedgerEntry.RESET;
                    DetailedGSTLedgerEntry.SETRANGE(DetailedGSTLedgerEntry."Document No.", "G/L Entry"."Document No.");
                    IF DetailedGSTLedgerEntry.FINDSET THEN
                        REPEAT
                            BillDecptn := 'BILL NO. ' + DetailedGSTLedgerEntry."External Document No." + '  ' + DetailedGSTLedgerEntry."GST Component Code" + '  ' + FORMAT(DetailedGSTLedgerEntry."GST Base Amount")
                            + ' @ ' + FORMAT(DetailedGSTLedgerEntry."GST %") + '%1 ' + FORMAT(DetailedGSTLedgerEntry."GST Amount");
                            LFChar := 10;
                            CRChar := 13;
                            CRLF := FORMAT(CRChar) + FORMAT(LFChar);
                            BillDecptn1 := BillDecptn1 + CRLF + BillDecptn;
                        UNTIL DetailedGSTLedgerEntry.NEXT = 0;
                END;

                DimValue1 := '';
                DimensionSetEntry.RESET;
                DimensionSetEntry.SETRANGE("Dimension Set ID", "G/L Entry"."Dimension Set ID");
                IF DimensionSetEntry.FINDSET THEN
                    REPEAT
                        DimensionSetEntry.CALCFIELDS(DimensionSetEntry."Dimension Value Name");
                        DimValue := DimensionSetEntry."Dimension Code" + ' - ' + DimensionSetEntry."Dimension Value Name";
                        LFChar := 10;
                        CRChar := 13;
                        CRLF := FORMAT(CRChar) + FORMAT(LFChar);
                        IF DimValue1 <> '' THEN
                            DimValue1 := DimValue1 + ' , ' + DimValue
                        ELSE
                            DimValue1 := DimValue;
                    //DimValue3:=DimValue3+' , '+DimValue;
                    UNTIL DimensionSetEntry.NEXT = 0;

                comet1 := '';

                PostedNarration.RESET;
                PostedNarration.SETRANGE("Document No.", "G/L Entry"."Document No.");
                IF PostedNarration.FINDFIRST THEN
                    REPEAT
                        comet1 := comet1 + PostedNarration.Narration;
                    UNTIL PostedNarration.NEXT = 0;

                PurchCommentLine.RESET;
                PurchCommentLine.SETRANGE("No.", "G/L Entry"."Document No.");
                IF PurchCommentLine.FINDSET THEN
                    REPEAT
                        comet := PurchCommentLine.Comment;
                        LFChar := 10;
                        CRChar := 13;
                        CRLF := FORMAT(CRChar) + FORMAT(LFChar);
                        comet1 := comet1 + CRLF + comet;

                    UNTIL PurchCommentLine.NEXT = 0;

                SalesCommentLine.RESET;
                SalesCommentLine.SETRANGE("No.", "G/L Entry"."Document No.");
                IF SalesCommentLine.FINDSET THEN
                    REPEAT
                        comet := SalesCommentLine.Comment;
                        LFChar := 10;
                        CRChar := 13;
                        CRLF := FORMAT(CRChar) + FORMAT(LFChar);
                        comet1 := comet1 + CRLF + comet;

                    UNTIL SalesCommentLine.NEXT = 0;
                docno := "G/L Entry"."Document No.";
                LFChar := 10;
                CRChar := 13;
                CRLF := FORMAT(CRChar) + FORMAT(LFChar);
                GLAccName := GLAccName + CRLF + DimValue1;
                DimValue3 := '';
                DimensionSetEntry.RESET;
                DimensionSetEntry.SETRANGE("Dimension Set ID", "G/L Entry"."Dimension Set ID");
                IF DimensionSetEntry.FINDSET THEN
                    REPEAT
                        DimensionSetEntry.CALCFIELDS(DimensionSetEntry."Dimension Value Name");
                        DimValue := DimensionSetEntry."Dimension Code" + ' - ' + DimensionSetEntry."Dimension Value Name";
                        //  LFChar := 10;
                        //CRChar := 13;
                        //CRLF := FORMAT(CRChar) + FORMAT(LFChar);
                        //DimValue1:=DimValue1+CRLF+DimValue;
                        DimValue3 := DimValue + ',' + DimValue3;
                    UNTIL DimensionSetEntry.NEXT = 0;
            end;

            trigger OnPreDataItem()
            begin
                NUMLines := 13;
                PageLoop := NUMLines;
                LinesPrinted := 0;
                DebitAmountTotal := 0;
                CreditAmountTotal := 0;
                tdsper := '';
                tdslineamt := '';
                i := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PrintLineNarration; PrintLineNarration)
                    {
                        Caption = 'PrintLineNarration';
                    }
                    field(PrintDimensions; PrintDimensions)
                    {
                        Caption = 'Print Dimensions';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            PrintDimensions := TRUE;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        SourceCode: Record "Source Code";
        GLEntry: Record "G/L Entry";
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        GLAccName: Text;
        SourceDesc: Text[100];
        CrText: Text[2];
        DrText: Text[2];
        NumberText: array[2] of Text[80];
        PageLoop: Integer;
        LinesPrinted: Integer;
        NUMLines: Integer;
        ChequeNo: Code[100];
        ChequeDate: Date;
        Text16526: Label 'ZERO';
        Text16527: Label 'HUNDRED';
        Text16528: Label 'AND';
        Text16529: Label '%1 results in a written number that is too long.';
        Text16532: Label 'ONE';
        Text16533: Label 'TWO';
        Text16534: Label 'THREE';
        Text16535: Label 'FOUR';
        Text16536: Label 'FIVE';
        Text16537: Label 'SIX';
        Text16538: Label 'SEVEN';
        Text16539: Label 'EIGHT';
        Text16540: Label 'NINE';
        Text16541: Label 'TEN';
        Text16542: Label 'ELEVEN';
        Text16543: Label 'TWELVE';
        Text16544: Label 'THIRTEEN';
        Text16545: Label 'FOURTEEN';
        Text16546: Label 'FIFTEEN';
        Text16547: Label 'SIXTEEN';
        Text16548: Label 'SEVENTEEN';
        Text16549: Label 'EIGHTEEN';
        Text16550: Label 'NINETEEN';
        Text16551: Label 'TWENTY';
        Text16552: Label 'THIRTY';
        Text16553: Label 'FORTY';
        Text16554: Label 'FIFTY';
        Text16555: Label 'SIXTY';
        Text16556: Label 'SEVENTY';
        Text16557: Label 'EIGHTY';
        Text16558: Label 'NINETY';
        Text16559: Label 'THOUSAND';
        Text16560: Label 'MILLION';
        Text16561: Label 'BILLION';
        Text16562: Label 'LAKH';
        Text16563: Label 'CRORE';
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        PrintLineNarration: Boolean;
        PostingDate: Date;
        TotalDebitAmt: Decimal;
        DocumentNo: Code[20];
        DebitAmountTotal: Decimal;
        CreditAmountTotal: Decimal;
        PrePostingDate: Date;
        PreDocumentNo: Code[100];
        VoucherNoCaptionLbl: Label 'Voucher No. :';
        CreditAmountCaptionLbl: Label 'Credit Amount';
        DebitAmountCaptionLbl: Label 'Debit Amount';
        ParticularsCaptionLbl: Label 'Particulars';
        AmountInWordsCaptionLbl: Label 'Amount (in words):';
        PreparedByCaptionLbl: Label 'Prepared by:';
        CheckedByCaptionLbl: Label 'Checked by:';
        ApprovedByCaptionLbl: Label 'Approved by:';
        IntegerOccurcesCaptionLbl: Label 'IntegerOccurces';
        NarrationCaptionLbl: Label 'Narration :';
        PageNo: Integer;
        HasApplicationOf: Integer;
        AppliedDocNo: Code[100];
        AppliedDate: Date;
        InvoiceNo: Code[100];
        InvoiceDate: Date;
        CheckRepeatLoop: Integer;
        UserName: Text[100];
        PurchHeader: Record "Purchase Header";
        PostedPurchComment: Record "Purch. Comment Line";
        PurchComment: array[10] of Text;
        j: Integer;
        PurchInvHead: Record "Purch. Inv. Header";
        debitamt: Decimal;
        creditamt: Decimal;
        glentrynew: Record "G/L Entry";
        ExcelBuffer: Record "Excel Buffer";
        UserTable: Record User;
        CountVLE: Integer;
        CountCLE: Integer;
        CheckRepeatLoopCust: Integer;
        DebitAmount: Decimal;
        CreditAmount: Decimal;
        i: Integer;
        RecDimValue: Record "Dimension Value";
        BRANCHADDRESS1: Text;
        BRANCHADDRESS2: Text;
        UserSetup: Record "User Setup";
        RecTDSEntry: Record "TDS Entry";
        tdsper: Text;
        tdslineamt: Text;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        BillDecptn: Text;
        LFChar: Char;
        CRChar: Char;
        CRLF: Text;
        BillDecptn1: Text;
        docno: Code[20];
        DimensionSetEntry: Record "Dimension Set Entry";
        DimValue: Text;
        DimValue1: Text;
        PurchCommentLine: Record "Purch. Comment Line";
        SalesCommentLine: Record "Sales Comment Line";
        comet: Text;
        comet1: Text;
        NoSeries: Record "No. Series";
        DimValue3: Text;
        PrintDimensions: Boolean;
        CompanyInfo: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        Cust: Record Customer;
        Currency: Record Currency;
        FormatAddr: Codeunit "Format Address";
        ReportTitle: Text[30];
        PaymentDiscountTitle: Text[30];
        CompanyAddr: array[8] of Text[50];
        CustAddr: array[8] of Text[50];
        RemainingAmount: Decimal;
        AppliedAmount: Decimal;
        PmtDiscInvCurr: Decimal;
        PmtDiscPmtCurr1: Decimal;
        PmtTolPmtCurr1: Decimal;
        ShowAmount: Decimal;
        docno1: Code[20];
        Vend: Record Vendor;
        VendAddr: array[8] of Text[50];
        RemainingAmount1: Decimal;
        AppliedAmount1: Decimal;
        NegPmtDiscInvCurrVendLedgEntry1: Decimal;
        NegPmtTolInvCurrVendLedgEntry1: Decimal;
        PmtDiscPmtCurr: Decimal;
        PmtTolPmtCurr: Decimal;
        NegShowAmountVendLedgEntry1: Decimal;
        PmtTolInvCurr: Decimal;
        Preparedby: Text;
        Preparedby_gCode: Code[20];
        approvalentry: Record "Approval Entry";
        ApprovedBy: Text;
        PostBy: Text;
        SendBy: Text;
        PostedAppEntry: Record "Posted Approval Entry";
        PostedNarration: Record "Posted Narration";

    procedure FindGLAccName("Source Type": Option " ",Customer,Vendor,"Bank Account","Fixed Asset"; "Entry No.": Integer; "Source No.": Code[20]; "G/L Account No.": Code[20]): Text[100]
    var
        AccName: Text[100];
        VendLedgerEntry: Record "Vendor Ledger Entry";
        Vend: Record Vendor;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Cust: Record Customer;
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        Bank: Record "Bank Account";
        FALedgerEntry: Record "FA Ledger Entry";
        FA: Record "Fixed Asset";
        GLAccount: Record "G/L Account";
    begin
        IF "Source Type" = "Source Type"::Vendor THEN
            IF VendLedgerEntry.GET("Entry No.") THEN BEGIN
                Vend.GET("Source No.");
                AccName := Vend.Name + ' (' + "Source No." + ') ';
            END ELSE BEGIN
                GLAccount.GET("G/L Account No.");
                AccName := GLAccount.Name;
            END
        ELSE IF "Source Type" = "Source Type"::Customer THEN
            IF CustLedgerEntry.GET("Entry No.") THEN BEGIN
                Cust.GET("Source No.");
                AccName := Cust.Name + ' (' + "Source No." + ') ';
            END ELSE BEGIN
                GLAccount.GET("G/L Account No.");
                AccName := GLAccount.Name;
            END
        ELSE IF "Source Type" = "Source Type"::"Bank Account" THEN
            IF BankLedgerEntry.GET("Entry No.") THEN BEGIN
                Bank.GET("Source No.");
                AccName := Bank.Name;
            END ELSE BEGIN
                GLAccount.GET("G/L Account No.");
                AccName := GLAccount.Name;
            END
        ELSE BEGIN
            GLAccount.GET("G/L Account No.");
            AccName := GLAccount.Name;
        END;

        IF "Source Type" = "Source Type"::" " THEN BEGIN
            GLAccount.GET("G/L Account No.");
            AccName := GLAccount.Name;
        END;

        EXIT(AccName);
    end;

    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        Currency: Record Currency;
        TensDec: Integer;
        OnesDec: Integer;
    begin
        CLEAR(NoText);
        NoTextIndex := 1;
        NoText[1] := '';

        IF No < 1 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text16526)
        ELSE BEGIN
            FOR Exponent := 4 DOWNTO 1 DO BEGIN
                PrintExponent := FALSE;
                IF No > 99999 THEN BEGIN
                    Ones := No DIV (POWER(100, Exponent - 1) * 10);
                    Hundreds := 0;
                END ELSE BEGIN
                    Ones := No DIV POWER(1000, Exponent - 1);
                    Hundreds := Ones DIV 100;
                END;
                Tens := (Ones MOD 100) DIV 10;
                Ones := Ones MOD 10;
                IF Hundreds > 0 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text16527);
                END;
                IF Tens >= 2 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    IF Ones > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                END ELSE
                    IF (Tens * 10 + Ones) > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                IF PrintExponent AND (Exponent > 1) THEN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                IF No > 99999 THEN
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(100, Exponent - 1) * 10
                ELSE
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
            END;
        END;

        IF CurrencyCode <> '' THEN BEGIN
            Currency.GET(CurrencyCode);
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + 'Currency."Currency Numeric Description"');
        END ELSE
            AddToNoText(NoText, NoTextIndex, PrintExponent, 'RUPEES');

        AddToNoText(NoText, NoTextIndex, PrintExponent, Text16528);

        TensDec := ((No * 100) MOD 100) DIV 10;
        OnesDec := (No * 100) MOD 10;
        IF TensDec >= 2 THEN BEGIN
            AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[TensDec]);
            IF OnesDec > 0 THEN
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[OnesDec]);
        END ELSE
            IF (TensDec * 10 + OnesDec) > 0 THEN
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[TensDec * 10 + OnesDec])
            ELSE
                AddToNoText(NoText, NoTextIndex, PrintExponent, Text16526);
        IF (CurrencyCode <> '') THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + 'Currency."Currency Decimal Description"' + ' ONLY')
        ELSE
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' PAISA ONLY');
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent := TRUE;

        WHILE STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) DO BEGIN
            NoTextIndex := NoTextIndex + 1;
            IF NoTextIndex > ARRAYLEN(NoText) THEN
                ERROR(Text16529, AddText);
        END;

        NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    procedure InitTextVariable()
    begin
        OnesText[1] := Text16532;
        OnesText[2] := Text16533;
        OnesText[3] := Text16534;
        OnesText[4] := Text16535;
        OnesText[5] := Text16536;
        OnesText[6] := Text16537;
        OnesText[7] := Text16538;
        OnesText[8] := Text16539;
        OnesText[9] := Text16540;
        OnesText[10] := Text16541;
        OnesText[11] := Text16542;
        OnesText[12] := Text16543;
        OnesText[13] := Text16544;
        OnesText[14] := Text16545;
        OnesText[15] := Text16546;
        OnesText[16] := Text16547;
        OnesText[17] := Text16548;
        OnesText[18] := Text16549;
        OnesText[19] := Text16550;

        TensText[1] := '';
        TensText[2] := Text16551;
        TensText[3] := Text16552;
        TensText[4] := Text16553;
        TensText[5] := Text16554;
        TensText[6] := Text16555;
        TensText[7] := Text16556;
        TensText[8] := Text16557;
        TensText[9] := Text16558;

        ExponentText[1] := '';
        ExponentText[2] := Text16559;
        ExponentText[3] := Text16562;
        ExponentText[4] := Text16563;
    end;

    procedure DetermineHasApplicationOf() IntVal: Integer
    var
        GLEntry: Record "G/L Entry";
    begin
        IntVal := 0;

        //Is Vendor?
        GLEntry.RESET;
        GLEntry.SETRANGE(GLEntry."Document No.", "G/L Entry"."Document No.");
        GLEntry.SETRANGE(GLEntry."Source Type", GLEntry."Source Type"::Vendor);
        IF GLEntry.FINDFIRST THEN
            IntVal := 1;

        //Is Customer?
        GLEntry.RESET;
        GLEntry.SETRANGE(GLEntry."Document No.", "G/L Entry"."Document No.");
        GLEntry.SETRANGE(GLEntry."Source Type", GLEntry."Source Type"::Customer);
        IF GLEntry.FINDFIRST THEN
            IntVal := 2;
    end;

    procedure ClearApplicationVariables()
    begin
        AppliedDocNo := '';
        AppliedDate := 0D;
        InvoiceNo := '';
        InvoiceDate := 0D;
    end;

    procedure FindGLAccNameBalAcc(BalAccountType: Option " ",Customer,Vendor,"Bank Account","Fixed Asset"; "Entry No.": Integer; "Source No.": Code[20]; "G/L Account No.": Code[20]): Text[80]
    var
        AccName: Text[80];
        VendLedgerEntry: Record "Vendor Ledger Entry";
        Vend: Record Vendor;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Cust: Record Customer;
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        Bank: Record "Bank Account";
        FALedgerEntry: Record "FA Ledger Entry";
        FA: Record "Fixed Asset";
        GLAccount: Record "G/L Account";
    begin
        IF BalAccountType = BalAccountType::Vendor THEN
            //IF VendLedgerEntry.GET("Entry No.") THEN BEGIN
            IF Vend.GET("Source No.") THEN BEGIN
                AccName := Vend.Name + '(' + "Source No." + ')';
            END ELSE BEGIN
                GLAccount.GET("G/L Account No.");
                AccName := GLAccount.Name;
            END
        ELSE IF BalAccountType = BalAccountType::Customer THEN
            //IF CustLedgerEntry.GET("Entry No.") THEN BEGIN
            IF Cust.GET("Source No.") THEN BEGIN
                AccName := Cust.Name + '(' + "Source No." + ')';
            END ELSE BEGIN
                GLAccount.GET("G/L Account No.");
                AccName := GLAccount.Name;
            END
        ELSE IF BalAccountType = BalAccountType::"Bank Account" THEN
            //IF BankLedgerEntry.GET("Entry No.") THEN BEGIN
            IF Bank.GET("Source No.") THEN BEGIN
                AccName := Bank.Name;
            END ELSE BEGIN
                GLAccount.GET("G/L Account No.");
                AccName := GLAccount.Name;
            END
        // PS45258.begin
        //ELSE IF "Source Type" = "Source Type"::"Fixed Asset" THEN BEGIN
        //  FALedgerEntry.RESET;
        //  FALedgerEntry.SETCURRENTKEY("G/L Entry No.");
        //  FALedgerEntry.SETRANGE("G/L Entry No.","Entry No.");
        //  IF FALedgerEntry.FINDFIRST THEN BEGIN
        //    FA.GET("Source No.");
        //    AccName := FA.Description;
        //  END ELSE BEGIN
        //    GLAccount.GET("G/L Account No.");
        //    AccName := GLAccount.Name;
        //  END;
        //END ELSE BEGIN
        ELSE BEGIN
            // PS45258.end
            GLAccount.GET("G/L Account No.");
            AccName := GLAccount.Name;
        END;

        IF BalAccountType = BalAccountType::" " THEN BEGIN
            GLAccount.GET("G/L Account No.");
            AccName := GLAccount.Name;
        END;

        EXIT(AccName);
    end;

    procedure SetPreparedBy(Preparedby_lCode: Code[20])
    begin
        Preparedby_gCode := Preparedby_lCode;
    end;
}

