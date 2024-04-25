table 50001 "GL Vendor Difference"
{
    Caption = 'GL Vendor Difference';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "GLE Amount"; Decimal)
        {
            Caption = 'GLE Amount';
        }
        field(3; "VLE Amount (LCY)"; Decimal)
        {
            Caption = 'VLE Amount (LCY)';
        }
        field(4; "Entry No."; Integer)
        {

        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
