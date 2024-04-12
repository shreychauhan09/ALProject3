controladdin CustInfoCtrl
{
    RequestedHeight = 300;
    MinimumHeight = 300;
    MaximumHeight = 300;
    RequestedWidth = 700;
    MinimumWidth = 700;
    MaximumWidth = 700;
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalStretch = true;
    HorizontalShrink = true;
    Scripts = 'https://code.jquery.com/jquery-3.4.1.min.js';
    StartupScript = 'C:\Users\Admin\Documents\AL\ALProject3\ControlAdd-in\start.js';

    procedure GetCustomerInfo(CustInfo: JsonObject);
}
