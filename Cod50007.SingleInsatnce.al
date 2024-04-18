#pragma warning disable AL0679
codeunit 50007 "Single Insatnce"
#pragma warning restore AL0679
{
    SingleInstance = true;

    VAR
        ShowDimMessage: Boolean;

    PROCEDURE SetGetReceiptLinesBatch(ShowMessage: Boolean);
    BEGIN
        //**GNC1.0**260712**DD Start
        ShowDimMessage := ShowMessage;
        //**GNC1.0**260712**DD End
    END;

    PROCEDURE GetGetReceiptLinesBatch(): Boolean;
    BEGIN
        //**GNC1.0**260712**DD Start
        EXIT(ShowDimMessage);
        //**GNC1.0**260712**DD End
    END;
}
