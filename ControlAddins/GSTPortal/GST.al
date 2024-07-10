controladdin GST
{
    RequestedHeight = 500;
    MinimumHeight = 400;
    MaximumHeight = 600;
    RequestedWidth = 1300;
    MinimumWidth = 1000;
    MaximumWidth = 1500;
    VerticalStretch = true;
    VerticalShrink = false;
    HorizontalStretch = true;
    HorizontalShrink = false;

    StartupScript = 'ControlAddins\GSTPortal\js\GST.js';


    // SCRIPT Plugin
    Scripts =

            'https://code.jquery.com/jquery-3.6.0.min.js'// jquery  


        ;



    // includo i css da cdn per evitare di scaricarli in locale
    StyleSheets = 'https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css',// bootstrap                      
                    'https://pro.fontawesome.com/releases/v5.10.0/css/all.css';// fontawesome

    event controlAddinReady()

    procedure MyProcedure()
}