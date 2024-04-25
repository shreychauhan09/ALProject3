page 50001 "GL Vendor Differences"
{
    ApplicationArea = All;
    Caption = 'GL Vendor Differences';
    PageType = List;
    SourceTable = "GL Vendor Difference";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {

                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("GLE Amount"; Rec."GLE Amount")
                {
                    ToolTip = 'Specifies the value of the GLE Amount field.';
                }
                field("VLE Amount (LCY)"; Rec."VLE Amount (LCY)")
                {
                    ToolTip = 'Specifies the value of the VLE Amount (LCY) field.';
                }
            }
        }
    }
}
