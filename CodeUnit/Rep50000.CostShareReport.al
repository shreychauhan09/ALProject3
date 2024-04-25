report 50062 "Cost Share Reports"
{
    ApplicationArea = All;
    Caption = 'Cost Share Reports';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    UseRequestPage = true;
    RDLCLayout = 'Cost Share Reports.rdl';
    dataset
    {
        dataitem(BOMBuffer; "BOM Buffer")
        {
            DataItemTableView = sorting("No.") where(Indentation = filter(1), Type = filter(Item));
            RequestFilterFields = "No.";
            column(No_; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName)
            {
            }
            column(UserWorkDate; UserWorkDate)
            {
            }
            column(FGAmount; FGAmount)
            {
            }
            column(RMAmount; RMAmount)
            {
            }
            column(BOPAmount; BOPAmount)
            {
            }
            column(JWAmount; JWAmount)
            {
            }
            column(PKGAmount; PKGAmount)
            {
            }
            column(CONSAmount; CONSAmount)
            {
            }
            column(SCRAPAmount; SCRAPAmount)
            {
            }
            column(WIPAmount; WIPAmount)
            {
            }
            trigger OnAfterGetRecord()
            begin
                UserWorkDate := WorkDate;
                FGAmount := 0;
                RMAmount := 0;
                BOPAmount := 0;
                JWAmount := 0;
                PKGAmount := 0;
                CONSAmount := 0;
                SCRAPAmount := 0;
                WIPAmount := 0;
                // if BOMBuffer."Inventory Posting Group" = 'FG' then begin
                //     FGAmount := BOMBuffer."Total Cost";
                // end;
                // if BOMBuffer."Inventory Posting Group" = 'RM' then begin
                //     RMAmount := BOMBuffer."Total Cost";
                // end;
                // if BOMBuffer."Inventory Posting Group" = 'BOP' then begin
                //     BOPAmount := BOMBuffer."Total Cost";
                // end;
                // if BOMBuffer."Inventory Posting Group" = 'JW' then begin
                //     JWAmount := BOMBuffer."Total Cost";
                // end;
                // if BOMBuffer."Inventory Posting Group" = 'PKG' then begin
                //     PKGAmount := BOMBuffer."Total Cost";
                // end;
                // if BOMBuffer."Inventory Posting Group" = 'CONS' then begin
                //     CONSAmount := BOMBuffer."Total Cost";
                // end;
                // if BOMBuffer."Inventory Posting Group" = 'SCRAP' then begin
                //     SCRAPAmount := BOMBuffer."Total Cost";
                // end;
                // if BOMBuffer."Inventory Posting Group" = 'WIP' then begin
                //     WIPAmount := BOMBuffer."Total Cost";
                // end;
            end;
        }
    }
    trigger OnPreReport()
    begin
        FGAmount := 0;
        RMAmount := 0;
        BOPAmount := 0;
        JWAmount := 0;
        PKGAmount := 0;
        CONSAmount := 0;
        SCRAPAmount := 0;
        WIPAmount := 0;
    end;

    var
        FGAmount: Decimal;
        RMAmount: Decimal;
        BOPAmount: Decimal;
        JWAmount: Decimal;
        PKGAmount: Decimal;
        CONSAmount: Decimal;
        SCRAPAmount: Decimal;
        WIPAmount: Decimal;
        workdate: Date;
        UserWorkDate: Date;
}