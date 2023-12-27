/// <summary>
/// Page Custom API (ID 60011).
/// </summary>
page 60011 "Custom API"
{
    APIGroup = 'Demo';
    APIPublisher = 'Shrey';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'customAPI';
    DelayedInsert = true;
    EntityName = 'CustomAPI';
    EntitySetName = 'Custom';
    PageType = API;
    SourceTable = "Custom API Table";
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(address; Rec.Address)
                {
                    Caption = 'Address';
                }
                field(address2; Rec."Address 2")
                {
                    Caption = 'Address 2';
                }
                field(city; Rec.City)
                {
                    Caption = 'City';
                }
                field(state; Rec.State)
                {
                    Caption = 'State';
                }
                field(contactNo; Rec."Contact No.")
                {
                    Caption = 'Contact No.';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}
