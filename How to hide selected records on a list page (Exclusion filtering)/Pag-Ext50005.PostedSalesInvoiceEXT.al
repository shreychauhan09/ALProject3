pageextension 50005 "Posted Sales Invoice EXT" extends "Posted Sales Invoices"
{
    actions
    {
        addbefore("Update Document")
        {
            action(Hideselected)
            {
                ApplicationArea = All;
                Caption = 'Hide selected';
                Image = Filter;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    Filter := '';
                    Rec.Reset();
                    SalesInvoiceHeader.Reset();
                    CurrPage.SetSelectionFilter(SalesInvoiceHeader);
                    SalesReceivablesSetup.Get();
                    Filter := SalesReceivablesSetup."Hidden Posted Sales Invoices";
                    SetExclusionFilter(SalesInvoiceHeader);
                    Rec.filtergroup(100);
                    Rec.SetFilter("No.", SalesReceivablesSetup."Hidden Posted Sales Invoices");
                    Rec.FilterGroup(0);
                end;
            }
        }
        addbefore("Update Document")
        {
            action(FilterSelected)
            {
                ApplicationArea = All;
                Caption = 'Filter Selected';
                Image = Filter;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    CurrPage.Update();
                end;
            }
            action(ResetFilter)
            {
                ApplicationArea = All;
                Caption = 'Reset Filter';
                Image = Filter;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    Rec.Reset();
                    CurrPage.Update();
                end;
            }
            action(ExclusionFilter)
            {
                ApplicationArea = All;
                Caption = 'Exclusion Filter';
                Image = Filter;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    Rec.Reset();
                    SalesInvoiceHeader.Reset();
                    CurrPage.SetSelectionFilter(SalesInvoiceHeader);
                    Rec.SetFilter("No.", GetExclusionFilter(SalesInvoiceHeader));
                    CurrPage.Update();
                end;
            }
        }
    }
    local procedure GetExclusionFilter(var SalesInvoiceHeader: Record "Sales Invoice Header"): Text
    var
        Filter: Text;
    begin
        Filter := '';
        if SalesInvoiceHeader.FindSet() then
            repeat
                if Filter = '' then
                    Filter := '<>' + Format(SalesInvoiceHeader."No.")
                else
                    Filter := Filter + '&' + '<>' + Format(SalesInvoiceHeader."No.");
            until SalesInvoiceHeader.Next() = 0;
        exit(Filter);
    end;

    trigger OnOpenPage()
    begin
        SalesReceivablesSetup.Get();
        if SalesReceivablesSetup."Hidden Posted Sales Invoices" <> '' then begin
            Rec.filtergroup(100);
            Rec.SetFilter("No.", SalesReceivablesSetup."Hidden Posted Sales Invoices");
            Rec.FilterGroup(0);
        end;
    end;

    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        Filter: Text;

    local procedure SetExclusionFilter(var SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        if SalesInvoiceHeader.FindSet() then
            repeat
                if Filter = '' then
                    Filter := '<>' + Format(SalesInvoiceHeader."No.")
                else
                    Filter := Filter + '&' + '<>' + Format(SalesInvoiceHeader."No.");
            until SalesInvoiceHeader.Next() = 0;
        if Filter <> '' then begin
            SalesReceivablesSetup.Get();
            SalesReceivablesSetup."Hidden Posted Sales Invoices" := Filter;
            SalesReceivablesSetup.Modify(true);
        end;
    end;
}