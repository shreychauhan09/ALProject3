codeunit 50006 "Enable Social Media Extension"
{
    // Extend and modify Essential experience tier with "Social Media App Area"
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Application Area Mgmt.", 'OnGetEssentialExperienceAppAreas', '', false, false)]
    local procedure RegisterSocialExtensionOnGetEssentialExperienceAppAreas(var TempApplicationAreaSetup: Record "Application Area Setup" temporary)
    begin
        TempApplicationAreaSetup."Social Media" := true;
        // Modify other application areas here
    end;

    // Validate that application areas needed for the extension are enabled
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Application Area Mgmt.", 'OnValidateApplicationAreas', '', false, false)]
    local procedure VerifyApplicationAreasOnValidateApplicationAreas(ExperienceTierSetup: Record "Experience Tier Setup"; TempApplicationAreaSetup: Record "Application Area Setup" temporary)
    begin
        if ExperienceTierSetup.Essential then
            if not TempApplicationAreaSetup."Social Media" then
                Error('Social Media App Area should be part of Essential in order for the Social Media Extension to work.');
    end;

    procedure IsSocialApplicationAreaEnabled(): Boolean
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if (ApplicationAreaMgmtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName())) then
            exit(ApplicationAreaSetup."Social Media");
    end;

    procedure EnableSocialMediaExtension()
    var
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        ApplicationAreaMgmtFacade.RefreshExperienceTierCurrentCompany();
    end;
}
