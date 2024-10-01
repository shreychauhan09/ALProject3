namespace ALProject.ALProject;

using Microsoft.Purchases.Document;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Finance.TDS.TDSBase;
using Microsoft.Finance.GST.Base;
using Microsoft.Finance.TaxEngine.TaxTypeHandler;

tableextension 50010 "Purchase Header Ext" extends "Purchase Header"
{
    fields
    {
        field(50000; Message; Decimal)
        {
            Caption = 'Message';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                TotalInclTaxAmount: Decimal;
            begin
                GetPurchaseStatisticsAmount(Rec, TotalInclTaxAmount);
                Rec.Message := TotalInclTaxAmount;
            end;
        }
    }
    procedure GetPurchaseStatisticsAmount(
        PurchaseHeader: Record "Purchase Header";
        var TotalInclTaxAmount: Decimal)
    var
        PurchaseLine: Record "Purchase Line";
        RecordIDList: List of [RecordID];
        GSTAmount: Decimal;
        TDSAmount: Decimal;
    begin
        Clear(TotalInclTaxAmount);

        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document no.", PurchaseHeader."No.");
        if PurchaseLine.FindSet() then
            repeat
                RecordIDList.Add(PurchaseLine.RecordId());
                TotalInclTaxAmount += PurchaseLine.Amount;
            until PurchaseLine.Next() = 0;
        GetGSTPurchaseStatisticsAmount(PurchaseHeader, GSTAmount);
        GetTDSStatisticsAmount(PurchaseHeader, TDSAmount);
        TotalInclTaxAmount := RoundInvoicePrecision((TotalInclTaxAmount + GSTAmount - TDSAmount));
    end;

    procedure GetGSTPurchaseStatisticsAmount(
        PurchaseHeader: Record "Purchase Header";
        var GSTAmount: Decimal)
    var
        PurchaseLine: Record "Purchase Line";
    begin
        Clear(GSTAmount);

        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document no.", PurchaseHeader."No.");
        if PurchaseLine.FindSet() then
            repeat
                GSTAmount += GetGSTAmount(PurchaseLine.RecordId());
            until PurchaseLine.Next() = 0;
    end;

    local procedure GetGSTAmount(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
    begin
        if not GSTSetup.Get() then
            exit;

        TaxTransactionValue.SetCurrentKey("Tax Record ID", "Value Type", "Tax Type", Percent);
        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then
            TaxTransactionValue.CalcSums(Amount);

        exit(TaxTransactionValue.Amount);
    end;

    procedure GetTDSStatisticsAmount(
        PurchaseHeader: Record "Purchase Header";
        var TDSAmount: Decimal)
    var
        PurchaseLine: Record "Purchase Line";
        TDSEntityManagement: Codeunit "TDS Entity Management";
        i: Integer;
        RecordIDList: List of [RecordID];
    begin
        Clear(TDSAmount);

        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document no.", PurchaseHeader."No.");
        if PurchaseLine.FindSet() then
            repeat
                RecordIDList.Add(PurchaseLine.RecordId());
            until PurchaseLine.Next() = 0;

        for i := 1 to RecordIDList.Count() do
            TDSAmount += TDSEntityManagement.RoundTDSAmount(GetTDSAmount(RecordIDList.Get(i)));
    end;

    local procedure GetTDSAmount(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        TDSSetup: Record "TDS Setup";
    begin
        if not TDSSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        TaxTransactionValue.SetRange("Tax Type", TDSSetup."Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then
            TaxTransactionValue.CalcSums(Amount);

        exit(TaxTransactionValue.Amount);
    end;

    local procedure RoundInvoicePrecision(InvoiceAmount: Decimal): Decimal
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        InvRoundingDirection: Text[1];
        InvRoundingPrecision: Decimal;
    begin
        if InvoiceAmount = 0 then
            exit(0);

        GeneralLedgerSetup.Get();
        if GeneralLedgerSetup."Inv. Rounding Precision (LCY)" = 0 then
            exit;

        case GeneralLedgerSetup."Inv. Rounding Type (LCY)" of
            GeneralLedgerSetup."Inv. Rounding Type (LCY)"::Nearest:
                InvRoundingDirection := '=';
            GeneralLedgerSetup."Inv. Rounding Type (LCY)"::Up:
                InvRoundingDirection := '>';
            GeneralLedgerSetup."Inv. Rounding Type (LCY)"::Down:
                InvRoundingDirection := '<';
        end;

        InvRoundingPrecision := GeneralLedgerSetup."Inv. Rounding Precision (LCY)";

        exit(Round(InvoiceAmount, InvRoundingPrecision, InvRoundingDirection));
    end;
}
