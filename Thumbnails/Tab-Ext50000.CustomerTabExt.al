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
    }
}
