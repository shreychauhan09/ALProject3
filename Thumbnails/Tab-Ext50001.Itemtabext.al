/// <summary>
/// TableExtension Item tab ext (ID 50001) extends Record Item.
/// </summary>
tableextension 50001 "Item tab ext" extends Item
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
