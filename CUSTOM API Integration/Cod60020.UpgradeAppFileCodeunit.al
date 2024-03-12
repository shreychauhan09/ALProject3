codeunit 60020 UpgradeAppFileCodeunit
{
    Subtype = Upgrade;

    trigger OnCheckPreconditionsPerDatabase();
    var
        myInfo: ModuleInfo;
    begin
        if NavApp.GetCurrentModuleInfo(myInfo) then
            if myInfo.DataVersion = Version.Create(1, 0, 0, 1) then
                error('The upgrade isn''t compatible');
    end;

    trigger OnUpgradePerDatabase()
    begin
#pragma warning disable AL0667
        NavApp.RestoreArchiveData(Database::"Custom API Line");
#pragma warning restore AL0667
    end;
}

