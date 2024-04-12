page 50100 CustInfoCardPart
{
    PageType = CardPart;
    SourceTable = Customer;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            usercontrol(CustInfoCtrl; CustInfoCtrl)
            {

            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        GetCustomerInfo();
    end;

    local procedure GetCustomerInfo()
    var
        custInfo: JsonObject;
    begin
        custInfo.Add('name', Rec.Name);
        custInfo.Add('email', Rec."E-Mail");
        custInfo.Add('phone', Rec."Phone No.");
        CurrPage.CustInfoCtrl.GetCustomerInfo(custInfo);
    end;
}
