page 50102 "GST Portal"
{
    Caption = 'GST Portal';
    PageType = ListPart;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            usercontrol(GSTPortal; GSTPortal)
            {
                ApplicationArea = All;

                trigger controlAddinReady()
                begin

                end;
            }
        }
    }
}
