controladdin StocksAddin
{
    RequestedHeight = 300;
    MinimumHeight = 300;
    MaximumHeight = 300;
    RequestedWidth = 700;
    MinimumWidth = 400;
    MaximumWidth = 700;
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalStretch = true;
    HorizontalShrink = true;

    StartupScript = 'ControlAddins\stocks\js\main.js';

    // SCRIPT Plugin
    Scripts =

            'https://code.jquery.com/jquery-3.6.0.min.js',// jquery  
                                                         'https://s3.tradingview.com/tv.js',
                                                         'ControlAddins\stocks\js\stocks.js'
        ;


    // includo i css da cdn per evitare di scaricarli in locale
    StyleSheets = 'https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css',// bootstrap                      
                    'https://pro.fontawesome.com/releases/v5.10.0/css/all.css';// fontawesome

    event controlAddinReady()

    procedure MyProcedure()
}