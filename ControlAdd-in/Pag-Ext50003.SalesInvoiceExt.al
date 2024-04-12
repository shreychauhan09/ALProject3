pageextension 50003 SalesInvoiceExt extends "Sales Invoice"
{
    layout
    {
        addfirst(factboxes)
        {
            part(CustInfoCardPart; CustInfoCardPart)
            {
                SubPageLink = "No." = field("Bill-to Customer No.");
            }
        }
    }
}
