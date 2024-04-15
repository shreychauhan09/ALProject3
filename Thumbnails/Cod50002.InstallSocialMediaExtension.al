codeunit 50002 "Install Social Media Extension"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        EnableSocialExtension: Codeunit "Enable Social Media Extension";
    begin
        if (EnableSocialExtension.IsSocialApplicationAreaEnabled()) then
            exit;

        EnableSocialExtension.EnableSocialMediaExtension();

        // Add your code here
    end;
}
