
/// ROLE CENTER EXTENSION - BUSINESS MANAGER ROLE CENTER
pageextension 50115 roleCenterExt extends "Business Manager Role Center"
{

    layout
    {
        addafter(Control9)
        {
            part(MeteoPart; Meteo)       //ADD Meteo Part
            {
                ApplicationArea = All;

            }
            part(StocksPart; Stocks)      //ADD Stock Part
            {
                ApplicationArea = All;

            }
            part(ExchangePart; Exchange)    //ADD Exchange Part
            {
                ApplicationArea = All;

            }
        }
        addbefore(Control55)
        {
            group("GST Portal")
            {
                part(gstportal; "GST Portal")
                {
                    ApplicationArea = All;
                }
            }
            group(GSTs)
            {
                part(GST; GST)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {

    }

    var
        myInt: Integer;
}