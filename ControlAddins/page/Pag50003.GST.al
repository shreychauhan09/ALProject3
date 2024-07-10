namespace ALProject.ALProject;

page 50003 GST
{
    ApplicationArea = All;
    Caption = 'GST';
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
