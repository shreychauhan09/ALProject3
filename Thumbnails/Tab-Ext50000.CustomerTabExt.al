/// <summary>
/// TableExtension Customer Tab Ext (ID 50000) extends Record Customer.
/// </summary>
tableextension 50000 "Customer Tab Ext" extends Customer
{
    fields
    {
        field(50000; Thumbnails; Blob)
        {
            Caption = 'Thumbnails';
            DataClassification = ToBeClassified;
            Subtype = Bitmap;
        }
        field(50100; Facebook; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Facebook';
        }
        field(50200; "Multiple Location Codes"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Multiple Location Codes';
        }
    }
}
