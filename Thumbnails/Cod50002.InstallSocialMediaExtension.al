codeunit 50002 "Install Social Media Extension"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        EnableSocialExtension: Codeunit "Enable Social Media Extension";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if (EnableSocialExtension.IsSocialApplicationAreaEnabled()) then
            exit;

        EnableSocialExtension.EnableSocialMediaExtension();

        // Add your code here
        AddActionToCustomerCard();
        ApplicationAreaMgmtFacade.RefreshExperienceTierCurrentCompany();
    end;

    procedure AddActionToCustomerCard()
    var
        CustomerCardRec: Record Customer;
        CustomerCardPage: Page "Customer Card";
        NewAction: Action;
    begin
        CustomerCardRec.RESET;
        CustomerCardRec.SETRANGE("No.", 'CustomerNo'); // Replace 'CustomerNo' with actual customer number
        IF CustomerCardRec.FINDFIRST THEN BEGIN
            CustomerCardPage.SetTableView(CustomerCardRec);
            //     NewAction := CustomerCardPage.ACTIONS.ADDFIRST;
            //     NewAction.Caption := 'Open Social Media';
            //     NewAction.Image := Image::Information;
            //     NewAction.RUNOBJECT := Codeunit::"Open Social Media";
        END;
    end;
}
