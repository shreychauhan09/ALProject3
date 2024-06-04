namespace Microsoft.Purchases.Reports;

using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Finance.VAT.Ledger;
using Microsoft.Foundation.AuditCodes;
using System.Security.AccessControl;
using System.IO;
using Microsoft.Purchases.History;
using Microsoft.Purchases.Document;
using Microsoft.Finance.GST.Base;
using Microsoft.Finance.TDS.TDSBase;
using System.Security.User;
using Microsoft.Finance.Dimension;
using Microsoft.Purchases.Comment;
using Microsoft.Sales.Comment;
using Microsoft.Foundation.NoSeries;
using Microsoft.Foundation.Company;
using Microsoft.Foundation.Address;
using Microsoft.Bank.VoucherInterface;
using System.Automation;
using Microsoft.Finance.Currency;
using Microsoft.FixedAssets.FixedAsset;
using Microsoft.FixedAssets.Ledger;
using Microsoft.Bank.BankAccount;
using Microsoft.Bank.Ledger;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Receivables;
using Microsoft.Purchases.Payables;
using Microsoft.Purchases.Vendor;
using System.Utilities;
report 50001 "Day Book Vendor Led Entry New"
{


    DefaultLayout = RDLC;
    RDLCLayout = './Day Book Vendor Ledger Entry/DayBookVendorLedgerEntry New.rdl';
    ApplicationArea = Basic, Suite;
    Caption = 'Day Book Vendor Ledger Entry New';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(ReqVendLedgEntry; "Vendor Ledger Entry")
        {
            DataItemTableView = sorting("Document Type", "Vendor No.", "Posting Date", "Currency Code");
            RequestFilterFields = "Document Type", "Vendor No.", "Posting Date", "Currency Code";

            trigger OnPreDataItem()
            begin
                CurrReport.Break();
            end;
        }
        dataitem(Date; Date)
        {
            DataItemTableView = sorting("Period Type", "Period Start") where("Period Type" = const(Date));
            column(USERID; UserId)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName())
            {
            }
            column(All_amounts_are_in___GLSetup__LCY_Code_; StrSubstNo(AllAmountsAreInLbl, GLSetup."LCY Code"))
            {
            }
            column(Vendor_Ledger_Entry__TABLENAME__________VendLedgFilter; "Vendor Ledger Entry".TableCaption + ': ' + VendLedgFilter)
            {
            }
            column(VendLedgFilter; VendLedgFilter)
            {
            }
            column(PrintCLDetails; PrintCLDetails)
            {
            }
            column(Total_for______Vendor_Ledger_Entry__TABLENAME__________VendLedgFilter; StrSubstNo(TotalForVendLedgerEntryLbl, "Vendor Ledger Entry".TableCaption(), VendLedgFilter))
            {
            }
            column(Vendor_Ledger_Entry___Amount__LCY__; "Vendor Ledger Entry"."Amount (LCY)")
            {
                AutoFormatType = 1;
            }
            column(PmtDiscRcd; PmtDiscRcd)
            {
                AutoFormatType = 1;
            }
            column(ActualAmount; ActualAmount)
            {
                AutoFormatType = 1;
            }
            column(VATBase; VATBase)
            {
                AutoFormatType = 1;
            }
            column(VATAmount; VATAmount)
            {
                AutoFormatType = 1;
            }
            column(PmtDiscRcd4; PmtDiscRcd4)
            {
            }
            column(AmountLCY4; AmountLCY4)
            {
            }
            column(PmtDiscRcd3; PmtDiscRcd3)
            {
            }
            column(AmountLCY3; AmountLCY3)
            {
            }
            column(Date_Period_Type; "Period Type")
            {
            }
            column(Date_Period_Start; "Period Start")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Day_Book_Vendor_Ledger_EntryCaption; Day_Book_Vendor_Ledger_EntryCaptionLbl)
            {
            }
            column(VATAmount_Control23Caption; VATAmount_Control23CaptionLbl)
            {
            }
            column(PmtDiscRcd_Control32Caption; PmtDiscRcd_Control32CaptionLbl)
            {
            }
            column(Vendor_Ledger_Entry__Amount__LCY__Caption; Vendor_Ledger_Entry__Amount__LCY__CaptionLbl)
            {
            }
            column(ActualAmount_Control35Caption; ActualAmount_Control35CaptionLbl)
            {
            }
            column(VATBase_Control26Caption; VATBase_Control26CaptionLbl)
            {
            }
            column(VATAmount_Control23Caption_Control24; VATAmount_Control23Caption_Control24Lbl)
            {
            }
            column(PmtDiscRcd_Control32Caption_Control33; PmtDiscRcd_Control32Caption_Control33Lbl)
            {
            }
            column(VATBase_Control26Caption_Control27; VATBase_Control26Caption_Control27Lbl)
            {
            }
            column(Vendor_Ledger_Entry__Amount__LCY__Caption_Control30; Vendor_Ledger_Entry__Amount__LCY__Caption_Control30Lbl)
            {
            }
            column(Vendor_NameCaption; Vendor_NameCaptionLbl)
            {
            }
            column(Vendor_Ledger_Entry__Vendor_No__Caption; Vendor_Ledger_Entry__Vendor_No__CaptionLbl)
            {
            }
            column(Vendor_Ledger_Entry__External_Document_No__Caption; "Vendor Ledger Entry".FieldCaption("External Document No."))
            {
            }
            column(Vendor_Ledger_Entry__Document_No__Caption; "Vendor Ledger Entry".FieldCaption("Document No."))
            {
            }
            column(ActualAmount_Control35Caption_Control54; ActualAmount_Control35Caption_Control54Lbl)
            {
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemTableView = sorting("Document Type", "Vendor No.", "Posting Date", "Currency Code");
                column(Vendor_Ledger_Entry__FIELDNAME__Posting_Date__________FORMAT_Date__Period_Start__0_4_; FieldCaption("Posting Date") + ' ' + Format(Date."Period Start", 0, 4))
                {
                }
                column(FIELDNAME__Document_Type___________FORMAT___Document_Type__; FieldCaption("Document Type") + ' ' + Format("Document Type"))
                {
                }
                column(Vendor_Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Vendor_Ledger_Entry__External_Document_No__; "External Document No.")
                {
                }
                column(VATAmount_Control23; VATAmount)
                {
                    AutoFormatType = 1;
                }
                column(Vendor_Ledger_Entry__Amount__LCY__; "Amount (LCY)")
                {
                    AutoFormatType = 1;
                }
                column(PmtDiscRcd_Control32; PmtDiscRcd)
                {
                    AutoFormatType = 1;
                }
                column(Vendor_Name; Vendor.Name)
                {
                }
                column(Vendor_Ledger_Entry__Vendor_No__; "Vendor No.")
                {
                }
                column(VATBase_Control26; VATBase)
                {
                    AutoFormatType = 1;
                }
                column(ActualAmount_Control35; ActualAmount)
                {
                    AutoFormatType = 1;
                }
                column(VendorLedgerEntry___EntryNo__; "Entry No.")
                {
                }
                column(Total_for___FIELDNAME__Document_Type_________FORMAT__Document_Type__; StrSubstNo(TotalForVendLedgerEntryLbl, FieldCaption("Document Type"), Format("Document Type")))
                {
                }
                column(Vendor_Ledger_Entry__Amount__LCY___Control46; "Amount (LCY)")
                {
                    AutoFormatType = 1;
                }
                column(PmtDiscRcd_Control47; PmtDiscRcd)
                {
                    AutoFormatType = 1;
                }
                column(ActualAmount_Control48; ActualAmount)
                {
                    AutoFormatType = 1;
                }
                column(VATBase_Control49; VATBase)
                {
                    AutoFormatType = 1;
                }
                column(VATAmount_Control50; VATAmount)
                {
                    AutoFormatType = 1;
                }
                column(AmountLCY2; AmountLCY2)
                {
                }
                column(PmtDiscRcd2; PmtDiscRcd2)
                {
                }
                column(Total_for_____FORMAT_Date__Period_Start__0_4_; StrSubstNo(TotalForDatePeriodStartLbl, Format(Date."Period Start", 0, 4)))
                {
                }
                column(Vendor_Ledger_Entry__Amount__LCY___Control51; "Amount (LCY)")
                {
                    AutoFormatType = 1;
                }
                column(PmtDiscRcd_Control58; PmtDiscRcd)
                {
                    AutoFormatType = 1;
                }
                column(ActualAmount_Control59; ActualAmount)
                {
                    AutoFormatType = 1;
                }
                column(VATBase_Control61; VATBase)
                {
                    AutoFormatType = 1;
                }
                column(VATAmount_Control62; VATAmount)
                {
                    AutoFormatType = 1;
                }
                column(Vendor_Ledger_Entry_Document_Type; "Document Type")
                {
                }
                dataitem("G/L Entry"; "G/L Entry")
                {
                    DataItemTableView = sorting("Transaction No.", "Document No.", "Posting Date", Amount) ORDER(Descending)
                                WHERE("Source Code" = FILTER('<>SALESAPPL&<>UNAPPSALE&<>PURCHAPPL&<>UNAPPPURCH'));
                    column(G_L_Entry__G_L_Account_No__; "G/L Account No.")
                    {
                    }
                    column(G_L_Entry_Amount; Amount)
                    {
                        AutoFormatType = 1;
                    }
                    column(GLAcc_Name; GLAcc.Name)
                    {
                    }
                    column(G_L_Entry___Entry_No__; "Entry No.")
                    {
                    }
                    column(GetPmtDiscRcd; PmtDiscRcd1)
                    {
                    }
                    column(GetVatBase; VatBase1)
                    {
                    }
                    column(GetVatAmount; VatAmount1)
                    {
                    }
                    column(GetAmountLCY; AmountLCY1)
                    {
                    }

                    dataitem("Vendor Ledger Entry 1"; "Vendor Ledger Entry")
                    {
                        // DataItemLink = "Vendor No." = field("Vendor No."), "Document No." = field("Document No."), "Posting Date" = field("Posting Date"), "Entry No." = field("Entry No.");
                        // DataItemLink = "Document No." = field("Document No."), "Posting Date" = field("Posting Date");
                        // DataItemLinkReference = "G/L Entry";
                        DataItemTableView = SORTING("Entry No.")
                                    ORDER(Ascending);
                        column(VENPOST; "Vendor Ledger Entry 1"."Posting Date")
                        {
                        }
                        column(VENDODC; "Vendor Ledger Entry 1"."Document No.")
                        {
                        }
                        dataitem(DetailedVendorLedgEntry1; "Detailed Vendor Ledg. Entry")
                        {
                            DataItemLink = "Applied Vend. Ledger Entry No." = FIELD("Entry No.");
                            DataItemLinkReference = "Vendor Ledger Entry 1";
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
                                column(External_Document_No_1; "External Document No.")
                                {
                                }
                                column(Due_Date1; "Due Date")
                                {
                                }
                                column(Closed_by_Amount1; "Closed by Amount")
                                {
                                }
                                column(VLEcomment1; VLEcomment1)
                                {
                                }
                                trigger OnAfterGetRecord()
                                var
                                    PostPurchInv: Record "Purch. Inv. Header";
                                    PurCommLine: Record "Purch. Comment Line";
                                begin
                                    IF "Entry No." = "Vendor Ledger Entry 1"."Entry No." THEN
                                        CurrReport.SKIP();

                                    NegPmtDiscInvCurrVendLedgEntry1 := 0;
                                    NegPmtTolInvCurrVendLedgEntry1 := 0;
                                    PmtDiscPmtCurr := 0;
                                    PmtTolPmtCurr := 0;

                                    NegShowAmountVendLedgEntry1 := -DetailedVendorLedgEntry1.Amount;

                                    IF "Vendor Ledger Entry"."Currency Code" <> "Currency Code" THEN BEGIN
                                        NegPmtDiscInvCurrVendLedgEntry1 := ROUND("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry 1"."Original Currency Factor");
                                        NegPmtTolInvCurrVendLedgEntry1 := ROUND("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry 1"."Original Currency Factor");
                                        AppliedAmount :=
                                          ROUND(
                                            -DetailedVendorLedgEntry1.Amount / "Original Currency Factor" * "Vendor Ledger Entry 1"."Original Currency Factor",
                                            Currency."Amount Rounding Precision");
                                    END ELSE BEGIN
                                        NegPmtDiscInvCurrVendLedgEntry1 := ROUND("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry 1"."Original Currency Factor");
                                        NegPmtTolInvCurrVendLedgEntry1 := ROUND("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry 1"."Original Currency Factor");
                                        AppliedAmount := -DetailedVendorLedgEntry1.Amount;
                                    END;

                                    PmtDiscPmtCurr := ROUND("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry 1"."Original Currency Factor");

                                    PmtTolPmtCurr := ROUND("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry 1"."Original Currency Factor");

                                    RemainingAmount := (RemainingAmount - AppliedAmount) + PmtDiscPmtCurr + PmtTolPmtCurr;
                                    PostPurchInv.Reset();
                                    PostPurchInv.SetRange("No.", VendLedgEntry1."Document No.");
                                    if PostPurchInv.FindFirst() then begin
                                        Clear(VLEcomment1);
                                        PurCommLine.Reset();
                                        //PurCommLine.SetFilter("Document Type", '%1', "Document Type"::Invoice);
                                        PurCommLine.SetRange("No.", PostPurchInv."No.");
                                        if PurCommLine.FindSet() then
                                            repeat
                                                VLEcomment1 += PurCommLine.Comment + ' ';
                                            until PurCommLine.Next() = 0;

                                    end;
                                end;
                            }
                        }
                        dataitem(DetailedVendorLedgEntry2; "Detailed Vendor Ledg. Entry")
                        {
                            DataItemLink = "Vendor Ledger Entry No." = FIELD("Entry No.");
                            DataItemLinkReference = "Vendor Ledger Entry 1";
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
                                column(External_Document_No_2; "External Document No.")
                                {
                                }
                                column(Closed_by_Amount2; "Closed by Amount")
                                {
                                }
                                column(Due_Date2; "Due Date")
                                {
                                }
                                column(VLEcomment2; VLEcomment2)
                                {
                                }
                                trigger OnAfterGetRecord()
                                var
                                    PostPurchInv: Record "Purch. Inv. Header";
                                    PurCommLine: Record "Purch. Comment Line";
                                begin
                                    IF "Entry No." = "Vendor Ledger Entry 1"."Entry No." THEN
                                        CurrReport.SKIP();

                                    NegPmtDiscInvCurrVendLedgEntry1 := 0;
                                    NegPmtTolInvCurrVendLedgEntry1 := 0;
                                    PmtDiscPmtCurr := 0;
                                    PmtTolPmtCurr := 0;

                                    NegShowAmountVendLedgEntry1 := DetailedVendorLedgEntry2.Amount;

                                    IF "Vendor Ledger Entry"."Currency Code" <> "Currency Code" THEN BEGIN
                                        NegPmtDiscInvCurrVendLedgEntry1 := ROUND("Pmt. Disc. Rcd.(LCY)" * "Original Currency Factor");
                                        NegPmtTolInvCurrVendLedgEntry1 := ROUND("Pmt. Tolerance (LCY)" * "Original Currency Factor");
                                    END ELSE BEGIN
                                        NegPmtDiscInvCurrVendLedgEntry1 := ROUND("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry 1"."Original Currency Factor");
                                        NegPmtTolInvCurrVendLedgEntry1 := ROUND("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry 1"."Original Currency Factor");
                                    END;

                                    PmtDiscPmtCurr := ROUND("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry 1"."Original Currency Factor");

                                    PmtTolPmtCurr := ROUND("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry 1"."Original Currency Factor");

                                    AppliedAmount := DetailedVendorLedgEntry2.Amount;
                                    RemainingAmount := (RemainingAmount - AppliedAmount) + PmtDiscPmtCurr + PmtTolPmtCurr;
                                    PostPurchInv.Reset();
                                    PostPurchInv.SetRange("No.", VendLedgEntry2."Document No.");
                                    if PostPurchInv.FindFirst() then begin
                                        Clear(VLEcomment2);
                                        PurCommLine.Reset();
                                        //PurCommLine.SetFilter("Document Type", '%1', "Document Type"::Invoice);
                                        PurCommLine.SetRange("No.", PostPurchInv."No.");
                                        if PurCommLine.FindSet() then
                                            repeat
                                                VLEcomment2 += PurCommLine.Comment + ' ';
                                            until PurCommLine.Next() = 0;
                                    end;
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
                                    SETFILTER("Applied Vend. Ledger Entry No.", '%1', "Vendor Ledger Entry 1"."Entry No.");
                                    SETFILTER("Vendor Ledger Entry No.", '<>%1', "Vendor Ledger Entry 1"."Entry No.");
                                END
                                ELSE
                                    SETFILTER("Vendor Ledger Entry No.", '%1', "Vendor Ledger Entry 1"."Entry No.");
                                SETRANGE("Detailed Vendor Ledg. Entry".Unapplied, false);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            CheckRepeatLoop += 1;
                            IF docno1 <> "Vendor Ledger Entry"."Document No." THEN begin
                                SETRANGE("Document No.", "G/L Entry"."Document No.");
                                SETRANGE("Posting Date", "G/L Entry"."Posting Date");
                            end
                            ELSE
                                CurrReport.SKIP();
                            docno1 := "G/L Entry"."Document No.";
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (CheckRepeatLoop > 1) THEN
                                CurrReport.BREAK();

                            IF ((HasApplicationOf = 0) OR (HasApplicationOf = 2)) THEN
                                CurrReport.BREAK();


                            SETRANGE("Document No.", "G/L Entry"."Document No.");
                            SetRange("Posting Date", "G/L Entry"."Posting Date");
                        end;
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if "G/L Account No." <> GLAcc."No." then
                            if not GLAcc.Get("G/L Account No.") then
                                GLAcc.Init();

                        AmountLCY1 := "Vendor Ledger Entry"."Amount (LCY)";
                        PmtDiscRcd1 := PmtDiscRcd;
                        if SecondStep then begin
                            VatBase1 := 0;
                            VatAmount1 := 0;
                            SecondStep := false;
                        end else begin
                            VatBase1 := VATBase;
                            VatAmount1 := VATAmount;
                        end;
                    end;

                    trigger OnPreDataItem()
                    var
                        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
                        TransactionNoFilter: Text[250];
                    begin
                        if not PrintGLDetails then
                            CurrReport.Break();

                        DtldVendLedgEntry.Reset();
                        DtldVendLedgEntry.SetRange("Vendor Ledger Entry No.", "Vendor Ledger Entry"."Entry No.");
                        DtldVendLedgEntry.SetFilter("Entry Type", '<>%1', DtldVendLedgEntry."Entry Type"::Application);
                        if DtldVendLedgEntry.FindSet() then begin
                            TransactionNoFilter := Format(DtldVendLedgEntry."Transaction No.");
                            while DtldVendLedgEntry.Next() <> 0 do
                                TransactionNoFilter := TransactionNoFilter + '|' + Format(DtldVendLedgEntry."Transaction No.");
                        end;
                        SetFilter("Transaction No.", TransactionNoFilter);
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    TempVATEntry: Record "VAT Entry" temporary;
                begin
                    SecondStep := true;
                    if "Document Type" <> PreviousVendorLedgerEntry."Document Type" then begin
                        AmountLCY2 := 0;
                        PmtDiscRcd2 := 0;
                    end;
                    AmountLCY2 := AmountLCY2 + "Amount (LCY)";
                    AmountLCY3 := AmountLCY3 + "Amount (LCY)";
                    AmountLCY4 := AmountLCY4 + "Amount (LCY)";
                    PmtDiscRcd2 := PmtDiscRcd2 + PmtDiscRcd;
                    PmtDiscRcd3 := PmtDiscRcd3 + PmtDiscRcd;
                    PmtDiscRcd4 := PmtDiscRcd4 + PmtDiscRcd;
                    PreviousVendorLedgerEntry := "Vendor Ledger Entry";

                    if "Vendor No." <> Vendor."No." then
                        if not Vendor.Get("Vendor No.") then
                            Vendor.Init();

                    VATAmount := 0;
                    VATBase := 0;
                    VATEntry.SetCurrentKey("Transaction No.");
                    VATEntry.SetRange("Transaction No.", "Transaction No.");
                    if VATEntry.FindSet() then
                        if VATEntry."Tax Liable" then begin
                            repeat
                                TempVATEntry.SetRange("Tax Area Code", VATEntry."Tax Area Code");
                                TempVATEntry.SetRange("Tax Group Code", VATEntry."Tax Group Code");
                                if TempVATEntry.FindFirst() then begin
                                    TempVATEntry.Amount += VATEntry.Amount;
                                    TempVATEntry.Modify();
                                end else begin
                                    TempVATEntry := VATEntry;
                                    TempVATEntry.Insert();
                                end;
                            until VATEntry.Next() = 0;
                            TempVATEntry.Reset();
                            TempVATEntry.CalcSums(Amount, Base);
                            VATAmount := -TempVATEntry.Amount;
                            VATBase := -TempVATEntry.Base;
                            TempVATEntry.DeleteAll();
                        end else begin
                            VATEntry.CalcSums(Amount, Base);
                            VATAmount := -VATEntry.Amount;
                            VATBase := -VATEntry.Base;
                        end;

                    PmtDiscRcd := 0;
                    VendLedgEntry.SetCurrentKey("Closed by Entry No.");
                    VendLedgEntry.SetRange("Closed by Entry No.", "Entry No.");
                    if VendLedgEntry.Find('-') then
                        repeat
                            PmtDiscRcd := PmtDiscRcd - VendLedgEntry."Pmt. Disc. Rcd.(LCY)"
                        until VendLedgEntry.Next() = 0;

                    ActualAmount := "Amount (LCY)" - PmtDiscRcd;
                end;

                trigger OnPreDataItem()
                begin
                    Clear(VATAmount);
                    Clear(PmtDiscRcd);
                    Clear(VATBase);
                    Clear(ActualAmount);
                    CopyFilters(ReqVendLedgEntry);
                    SetRange("Posting Date", Date."Period Start");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                AmountLCY2 := 0;
                AmountLCY3 := 0;
                PmtDiscRcd2 := 0;
                PmtDiscRcd3 := 0;
            end;

            trigger OnPreDataItem()
            var
                PostingDateStart: Date;
                PostingDateEnd: Date;
            begin
                Clear(VATAmount);
                Clear(PmtDiscRcd);
                Clear(VATBase);
                Clear(ActualAmount);
                ReqVendLedgEntry.CopyFilter("Posting Date", "Period Start");

                if ReqVendLedgEntry.GetFilter("Posting Date") = '' then
                    Error(MissingDateRangeFilterErr);

                PostingDateStart := ReqVendLedgEntry.GetRangeMin("Posting Date");
                PostingDateEnd := CalcDate('<+1Y>', PostingDateStart);

                if ReqVendLedgEntry.GetRangeMax("Posting Date") > PostingDateEnd then
                    Error(MaxPostingDateErr);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PrintVendLedgerDetails; PrintCLDetails)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Print Vend. Ledger Details';
                        ToolTip = 'Specifies if Cust. Ledger Details is printed';

                        trigger OnValidate()
                        begin
                            PrintCLDetailsOnAfterValidate();
                        end;
                    }
                    field(PrintGLEntryDetails; PrintGLDetails)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Print G/L Entry Details';
                        ToolTip = 'Specifies if G/L Entry Details are printed';

                        trigger OnValidate()
                        begin
                            PrintGLDetailsOnAfterValidate();
                        end;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        VendLedgFilter := ReqVendLedgEntry.GetFilters();
        GLSetup.Get();
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
    end;

    var
        GLSetup: Record "General Ledger Setup";
        GLAcc: Record "G/L Account";
        Vendor: Record Vendor;
        VendLedgEntry: Record "Vendor Ledger Entry";
        VATEntry: Record "VAT Entry";
        PreviousVendorLedgerEntry: Record "Vendor Ledger Entry";
        VendLedgFilter: Text;
        PmtDiscRcd: Decimal;
        VATAmount: Decimal;
        ActualAmount: Decimal;
        VATBase: Decimal;
        AmountLCY1: Decimal;
        PmtDiscRcd1: Decimal;
        VatAmount1: Decimal;
        VatBase1: Decimal;
        PrintGLDetails: Boolean;
        PrintCLDetails: Boolean;
        SecondStep: Boolean;
        AmountLCY2: Decimal;
        PmtDiscRcd2: Decimal;
        AmountLCY3: Decimal;
        AmountLCY4: Decimal;
        PmtDiscRcd3: Decimal;
        PmtDiscRcd4: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Day_Book_Vendor_Ledger_EntryCaptionLbl: Label 'Day Book Vendor Ledger Entry';
        VATAmount_Control23CaptionLbl: Label 'VAT Amount';
        PmtDiscRcd_Control32CaptionLbl: Label 'Payment Discount Rcd.';
        Vendor_Ledger_Entry__Amount__LCY__CaptionLbl: Label 'Ledger Entry Amount';
        ActualAmount_Control35CaptionLbl: Label 'Amount';
        VATBase_Control26CaptionLbl: Label 'VAT Base';
        VATAmount_Control23Caption_Control24Lbl: Label 'VAT Amount';
        PmtDiscRcd_Control32Caption_Control33Lbl: Label 'Payment Discount Rcd.';
        VATBase_Control26Caption_Control27Lbl: Label 'VAT Base';
        Vendor_Ledger_Entry__Amount__LCY__Caption_Control30Lbl: Label 'Ledger Entry Amount';
        Vendor_NameCaptionLbl: Label 'Name';
        Vendor_Ledger_Entry__Vendor_No__CaptionLbl: Label 'Account No.';
        ActualAmount_Control35Caption_Control54Lbl: Label 'Actual Amount';
        MissingDateRangeFilterErr: Label 'Posting Date filter must be set.';
        MaxPostingDateErr: Label 'Posting Date period must not be longer than 1 year.';
        TotalForVendLedgerEntryLbl: Label 'Total for  %1 : %2.', Comment = 'Total for Vend. Ledger Entry 3403  ';
        TotalForDatePeriodStartLbl: Label 'Total for %1.', Comment = 'Total for posting date 12122012';
        AllAmountsAreInLbl: Label 'All amounts are in %1.', Comment = 'All amounts are in GBP';

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
        // GLSetup: Record "General Ledger Setup";
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
        VLEcomment2: Text;
        VLEcomment1: Text;

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

    local procedure PrintGLDetailsOnAfterValidate()
    begin
        if PrintGLDetails then
            PrintCLDetails := true;
    end;

    local procedure PrintCLDetailsOnAfterValidate()
    begin
        if not PrintCLDetails then
            PrintGLDetails := false;
    end;
}