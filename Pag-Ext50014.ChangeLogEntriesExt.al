pageextension 50014 "Change Log Entries Ext" extends "Change Log Entries"
{
    layout
    {
        addafter("Field Caption")
        {
            field("Field Caption Customized"; Rec."Field Caption Customized")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        if Rec."Field Caption" <> '' then
            Rec."Field Caption Customized" := Rec."Field Caption";
        Rec.Modify();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if Rec."Field Caption" <> '' then
            Rec."Field Caption Customized" := Rec."Field Caption";
        Rec.Modify();
    end;
}
