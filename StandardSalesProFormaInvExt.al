reportextension 50123 StandardSalesProFormaInvExt extends "Standard Sales - Pro Forma Inv"
{
    dataset
    {
        modify(Line)
        {
            trigger OnBeforeAfterGetRecord()
            begin
                if Item.Get(Line."No.") then;
            end;
        }
    }
}
