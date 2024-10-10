tableextension 55000 "SGN Ext. Sales Header" extends "Sales Header"
{
    fields
    {
        field(55000; "SGN Signature"; Blob)
        {
            Caption = 'Customer Signature';
            DataClassification = CustomerContent;
            SubType = Bitmap;
        }
        field(50101; "Large Text"; Blob)
        {
            Caption = 'Large Text';
            DataClassification = CustomerContent;
        }
        field(50102; "QR Code"; Blob)
        {
            Subtype = Bitmap;
            Caption = 'QR Code';
            DataClassification = CustomerContent;
        }
    }

    procedure SignDocument(var Base64Text: Text)
    var
        Base64Cu: Codeunit "Base64 Convert";
        RecordRef: RecordRef;
        OutStream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        ImageBase64String: Text;
    begin
        Base64Text := Base64Text.Replace('data:image/png;base64,', '');
        TempBlob.CreateOutStream(OutStream);
        Base64Cu.FromBase64(Base64Text, OutStream);
        RecordRef.GetTable(Rec);
        TempBlob.ToRecordRef(RecordRef, Rec.FieldNo("SGN Signature"));
        RecordRef.Modify();
    end;
}