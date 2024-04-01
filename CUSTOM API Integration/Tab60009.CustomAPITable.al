/// <summary>
/// Table Custom API Table (ID 60009).
/// </summary>
table 60009 "Custom API Table"
{
    Caption = 'Custom API Table Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(3; "Contact No."; Text[10])
        {
            Caption = 'Contact No.';
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            var
                TyperHelper: Codeunit "Type Helper";
                PhoneNoCannotContainLettersErr: Label 'must not contain letters';
            begin
                if not TyperHelper.IsPhoneNumber("Contact No.") then
                    FieldError("Contact No.", PhoneNoCannotContainLettersErr);
            end;
        }
        field(4; Address; Text[100])
        {
            Caption = 'Address';
        }
        field(5; "Address 2"; Text[200])
        {
            Caption = 'Address 2';
        }
        field(6; City; Text[50])
        {
            Caption = 'City';
        }
        field(7; State; Text[50])
        {
            Caption = 'State';
        }
        field(8; "API URL"; Text[1000])
        {

        }
        field(9; "Enums"; Enum Enums)
        {

        }
        field(10; "Options"; Option)
        {
            OptionCaption = ' ,Red,Black,White,Yellow,Green,Blue';
            OptionMembers = " ","Red","Black","White","Yellow","Green","Blue";
        }
        field(11; "Auto Format"; Decimal)
        {
            AutoFormatExpression = '1,IRN';
            AutoFormatType = 10;
        }
        field(12; Booleans; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; Code; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Rich Text"; Blob)
        {
            DataClassification = ToBeClassified;
            Description = 'Contains a rich text value';
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    procedure GetRichText(): Text
    var
        InStream: Instream;
        TextValue: Text;
    begin
        Rec.CalcFields(Rec."Rich Text");
        Rec."Rich Text".CreateInStream(InStream);
        InStream.ReadText(TextValue);
        exit(TextValue);
    end;

    procedure SaveRichText(RichText: Text)
    var
        OutStream: OutStream;
    begin
        Rec."Rich Text".CreateOutStream(OutStream);
        OutStream.WriteText(RichText);
        Rec.Modify();
    end;
}
