using Microsoft.Finance.GeneralLedger.Ledger;

pageextension 50011 GeneralLedgerEntriesExt extends "General Ledger Entries"
{
    actions
    {
        addfirst(processing)
        {
            action(UpdateSelectedLine)
            {
                ApplicationArea = All;
                Caption = 'Update Selected Line';
                Promoted = true;
                PromotedCategory = Process;
                Image = UpdateUnitCost;

                trigger OnAction()
                var
                    GLEntry: Record "G/L Entry";
                    EditGLEntry: Codeunit EditGLEntry;
                begin
                    GLEntry.Reset();
                    CurrPage.SetSelectionFilter(GLEntry);
                    EditGLEntry.ClearDocumentTypeForSelectedLine(GLEntry);
                end;
            }
            action(InsertEntry)
            {
                ApplicationArea = All;
                Caption = 'Insert Entry';
                Promoted = true;
                PromotedCategory = Process;
                Image = Insert;

                trigger OnAction()
                var
                    EditGLEntry: Codeunit EditGLEntry;
                begin
                    EditGLEntry.InsertEntry();
                end;
            }
            action(DeleteEntry)
            {
                ApplicationArea = All;
                Caption = 'Delete Entry';
                Promoted = true;
                PromotedCategory = Process;
                Image = Delete;

                trigger OnAction()
                var
                    EditGLEntry: Codeunit EditGLEntry;
                begin
                    EditGLEntry.DeleteEntry();
                end;
            }
        }
    }
}
