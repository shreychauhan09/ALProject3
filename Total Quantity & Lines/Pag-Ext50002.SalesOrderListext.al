/// <summary>
/// PageExtension Sales Order List ext (ID 50002) extends Record Sales Order List.
/// </summary>
pageextension 50002 "Sales Order List ext" extends "Sales Order List"
{
    layout
    {
        addafter(Amount)
        {
            // field("Total Quantity"; Rec."Total Quantity")
            // {
            //     ApplicationArea = All;
            // }
            // field("Total Lines"; Rec."Total Lines")
            // {
            //     ApplicationArea = All;
            // }
        }
        addbefore(Control1902018507)
        {
            part(salesOrderWorkDescription; "Sales Order Work Description")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No."),
                              "Document Type" = field("Document Type");
            }
        }
    }
}
