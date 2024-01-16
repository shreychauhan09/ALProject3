/// <summary>
/// Codeunit Hide Progress Bar (ID 60019).
/// </summary>
codeunit 60019 "Hide Progress Bar"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforePostSalesDoc, '', false, false)]
    local procedure OnBeforePostSalesDoc(var HideProgressWindow: Boolean);
    begin
        HideProgressWindow := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforePostPurchaseDoc, '', false, false)]
    local procedure OnBeforePostPurchaseDoc(var HideProgressWindow: Boolean);
    begin
        HideProgressWindow := true;
    end;
}