pageextension 50009 "Vendor Ledger Entries ext" extends "Vendor Ledger Entries"
{
    actions
    {
        addafter("Print Voucher")
        {

            action("Print Voucher New")
            {
                ApplicationArea = Basic;
                Caption = 'Print Voucher New';
                Ellipsis = true;
                Image = PrintVoucher;

                trigger OnAction()
                var
                    GLEntry: Record "G/L Entry";
                begin
                    GLEntry.SetCurrentkey("Document No.", "Posting Date");
                    GLEntry.SetRange("Document No.", Rec."Document No.");
                    GLEntry.SetRange("Posting Date", Rec."Posting Date");
                    if GLEntry.Find('-') then
                        Report.Run(50151, true, true, GLEntry);
                end;
            }
        }
    }
}
