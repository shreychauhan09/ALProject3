codeunit 50012 EditGLEntry
{
    Permissions = TableData "G/L Entry" = rimd;

    procedure ClearDocumentTypeForSelectedLine(var GLEntry: Record "G/L Entry")
    begin
        if GLEntry.FindFirst() then begin
            GLEntry."Document Type" := GLEntry."Document Type"::" ";
            GLEntry."Document No." := 'Updated';
            GLEntry.Amount := 999;
            GLEntry.Modify(true);
        end;
    end;

    procedure InsertEntry()
    var
        GLEntry: Record "G/L Entry";
    begin
        GLEntry.Init();
        GLEntry."Entry No." := 999999999;
        GLEntry."Document Type" := GLEntry."Document Type"::Invoice;
        GLEntry."Document No." := 'xxxxxxxx';
        GLEntry."Posting Date" := WorkDate();
        GLEntry.Amount := 100;
        GLEntry.Insert();
    end;

    procedure DeleteEntry()
    var
        GLEntry: Record "G/L Entry";
    begin
        if GLEntry.Get(999999999) then
            GLEntry.Delete(true);
    end;
}
