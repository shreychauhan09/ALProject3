table 60010 "Custom API Line"
{
    Caption = 'Custom API Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Integer)
        {
            Caption = 'Document No.';
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(3; Description; Text[500])
        {
            Caption = 'Description';
        }
        field(4; Quantity; Integer)
        {
            Caption = 'Quantity';
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(6; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
        }
        field(7; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(8; "Contact No."; Text[10])
        {
            Caption = 'Contact No.';
        }
        field(9; Address; Text[100])
        {
            Caption = 'Address';
        }
        field(10; "Address 2"; Text[200])
        {
            Caption = 'Address 2';
        }
        field(11; City; Text[50])
        {
            Caption = 'City';
        }
        field(12; State; Text[50])
        {
            Caption = 'State';
        }
    }
    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
    }
}
