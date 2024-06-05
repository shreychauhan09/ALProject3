#pragma warning disable AA0215
codeunit 50010 "Event Subscriber"
#pragma warning restore AA0215
{
    Permissions = tabledata "Sales Shipment Header" = rm, tabledata "Purchase Header" = rm, tabledata "Prod. Order Line" = rm, tabledata "Production Order" = rm, tabledata "Reservation Entry" = rm, tabledata "Sales Invoice Header" = rm, tabledata "Sales Invoice Line" = rm, tabledata 7312 = rm;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Posting Selection Management", OnConfirmPostPurchaseDocumentOnBeforePurchaseOrderGetPurchaseInvoicePostingPolicy, '', false, false)]
    local procedure "Posting Selection Management_OnConfirmPostPurchaseDocumentOnBeforePurchaseOrderGetPurchaseInvoicePostingPolicy"(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
        PurchaseHeader.Receive := true;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Posting Selection Management", OnConfirmPostSalesDocumentOnBeforeSalesOrderGetSalesInvoicePostingPolicy, '', false, false)]
    local procedure "Posting Selection Management_OnConfirmPostSalesDocumentOnBeforeSalesOrderGetSalesInvoicePostingPolicy"(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        SalesHeader.Invoice := true;
        IsHandled := true;
    end;
}

