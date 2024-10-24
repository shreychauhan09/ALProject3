/// <summary>
/// PageExtension Item List Ext (ID 50001) extends Record Item List.
/// </summary>
pageextension 50001 "Item List Ext" extends "Item List"
{
    layout
    {
        addafter(Description)
        {
            field(Thumbnails; Rec.Thumbnails)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(CopyItem)
        {
            action(BulkEditAttrubute)
            {
                Caption = 'Bulk Edit Attributes';
                Image = Edit;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Item: Record Item;
                    ItemAttributesValueList: Page "Item Attributes Value List";
                    SelectionFilterManagement: Codeunit SelectionFilterManagement;
                    RecRef: RecordRef;
                begin
                    Item.Reset();
                    CurrPage.SetSelectionFilter(Item);
                    RecRef.GetTable(Item);
                    ItemAttributesValueList.GetSelectionFilter(SelectionFilterManagement.GetSelectionFilter(RecRef, Item.FieldNo("No.")));
                    ItemAttributesValueList.RunModal();
                    CurrPage.ItemAttributesFactBox.PAGE.LoadItemAttributesData(Rec."No.");
                end;

            }
            action(CountSelected)
            {

                Caption = 'Count Selected';
                ApplicationArea = All;
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    // Rec.Reset();
                end;
            }
            action(CountDeSelected)
            {

                Caption = 'Count De-Selected';
                ApplicationArea = All;
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    // CurrPage.SetSelectionFilter(Rec);
                    Rec.Reset();
                end;
            }
            action(SaveQueryAsJson)
            {
                ApplicationArea = All;
                Caption = 'Save Query As Json';
                Image = Download;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    // SaveQueryAsJson();
                    // ReadQueryAsJson();
                end;
            }
        }

        addafter(CopyItem)
        {
            action("Update Picture Thumbnails")
            {
                Promoted = true;
                PromotedCategory = Process;
                Image = UpdateDescription;
                ApplicationArea = All;
                trigger OnAction()
                var
                    TenantMedia: Record "Tenant Media";
                begin
                    if Rec.FindSet() then
                        repeat
                            if Rec.Picture.Count > 0 then begin
                                if TenantMedia.Get(Rec.Picture.Item(1)) then begin
                                    TenantMedia.CalcFields(Content);
                                    Rec.Thumbnails := TenantMedia.Content;
                                    Rec.Modify(true);
                                end;
                            end else begin
                                if Rec.Thumbnails.HasValue then begin
                                    Rec.CalcFields(Thumbnails);
                                    Clear(Rec.Thumbnails);
                                    Rec.Modify(true);
                                end;
                            end;
                        until Rec.Next() = 0;
                    Rec.FindFirst();
                end;
            }
            action("Expiration Calculation")
            {
                ApplicationArea = All;
                Caption = 'Expiration Calculation';
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ExpirationFormula, ShelfLife : Text;

                begin
                    ExpirationFormula := Format(Rec."Expiration Calculation"); // Convert DateFormula to Text

                    // Check if the Expiration Calculation field is not empty
                    if ExpirationFormula <> '' then
                        case CopyStr(ExpirationFormula, StrLen(ExpirationFormula), 1) of
                            'Y':
                                ShelfLife := CopyStr(ExpirationFormula, 1, StrLen(ExpirationFormula) - 1) + ' Years';
                            'M':
                                ShelfLife := CopyStr(ExpirationFormula, 1, StrLen(ExpirationFormula) - 1) + ' Months';
                            'W':
                                ShelfLife := CopyStr(ExpirationFormula, 1, StrLen(ExpirationFormula) - 1) + ' Weeks';
                            'D':
                                ShelfLife := CopyStr(ExpirationFormula, 1, StrLen(ExpirationFormula) - 1) + ' Days';
                            'Q':
                                ShelfLife := CopyStr(ExpirationFormula, 1, StrLen(ExpirationFormula) - 1) + ' Quaterlty';
                            'CM':
                                ShelfLife := CopyStr(ExpirationFormula, 1, StrLen(ExpirationFormula) - 1) + ' Current Month';
                            'CW':
                                ShelfLife := CopyStr(ExpirationFormula, 1, StrLen(ExpirationFormula) - 1) + ' Current Week';
                            'CY':
                                ShelfLife := CopyStr(ExpirationFormula, 1, StrLen(ExpirationFormula) - 1) + ' Current Year';
                            'CQ':
                                ShelfLife := CopyStr(ExpirationFormula, 1, StrLen(ExpirationFormula) - 1) + ' Current Quater';
                            else
                                ShelfLife := 'Unknown Format';
                        end else
                        ShelfLife := 'No Expiration Calculation';
                    Message(ShelfLife);
                end;
            }
            fileuploadaction(ImportMultipleItemPictures)
            {
                ApplicationArea = All;
                Caption = 'Import Multiple Item Pictures';
                Image = Import;
                AllowMultipleFiles = true;

                trigger OnAction(files: List of [FileUpload])
                var
                    CurrentFile: FileUpload;
                    InStr: InStream;
                    FileName: Text;
                    FileMgt: Codeunit "File Management";
                    Item: Record Item;
                begin
                    FileName := '';
                    foreach CurrentFile in Files do begin
                        CurrentFile.CreateInStream(InStr, TextEncoding::MSDos);
                        FileName := FileMgt.GetFileNameWithoutExtension(CurrentFile.FileName);
                        if Item.Get(FileName) then begin
                            Clear(Item.Picture);
                            Item.Picture.ImportStream(InStr, 'Demo picture for item ' + Format(Item."No."));
                            Item.Modify(true);
                        end;
                    end;
                end;
            }
        }


        addafter(History)
        {
            action(ExportItems)
            {
                Caption = 'Export Items';
                Promoted = true;
                PromotedCategory = Process;
                Image = Export;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Xmlport.Run(50101, true, false);
                end;
            }

            action(ImportItems)
            {
                Caption = 'Import Items';
                Promoted = true;
                PromotedCategory = Process;
                Image = Import;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Xmlport.Run(50102, false, true);
                end;
            }
        }
#pragma warning disable AL0432
        addafter(Item)
#pragma warning restore AL0432
        {
            action(DeleteDuplicateItems)
            {
                ApplicationArea = All;
                Caption = 'Delete Duplicate Items';
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    Item: Record Item;
                    TempItem: Record Item temporary;
                    NoOfDuplicateItems: Integer;
                    NoDuplicateItemsMsg: Label 'There are no duplicate items.';
                    NoOfDuplicateItemsDeletedMsg: Label '%1 item(s) were deleted.';
                begin
                    if Rec.FindSet() then
                        repeat
                            TempItem.Reset();
                            TempItem.SetRange(Description, Rec.Description); //Filter duplicates
                            if not TempItem.IsEmpty then begin
                                Item.Get(Rec."No.");
                                Item.Delete(true);
                                NoOfDuplicateItems := NoOfDuplicateItems + 1;
                            end else begin
                                TempItem.Init();
                                TempItem := Rec;
                                TempItem.Insert(); //Insert the record to the temporary table, the first inserted record will be retained
                            end;
                        until Rec.Next = 0;
                    if NoOfDuplicateItems = 0 then
                        Message(NoDuplicateItemsMsg)
                    else
                        Message(NoOfDuplicateItemsDeletedMsg, NoOfDuplicateItems);
                end;
            }
        }
        // addafter(CopyItem_Promoted)
        // {
        //     actionref(ImportMultipleItemPictures_Promoted; ImportMultipleItemPictures)
        //     {
        //     }
    }

    procedure SaveQueryAsJson();
    var
        OutS: OutStream;
        InS: InStream;
        TempBlob: Codeunit "Temp Blob";
        FileName: Text[250];
    begin
        TempBlob.CreateOutStream(OutS);
        // if Query.SaveAsJson(Query::"ZY Purchase Order Query", OutS) then begin
        //     FileName := 'PurchaseOrderQuery.json';
        //     TempBlob.CreateInStream(InS);
        //     DownloadFromStream(InS, '', '', '', FileName);
        // end;
    end;

    procedure ReadQueryAsJson();
    var
        OutS: OutStream;
        InS: InStream;
        TempBlob: Codeunit "Temp Blob";
        TypeHelper: Codeunit "Type Helper";
        JsonString: Text;
    begin
        TempBlob.CreateInStream(InS);
        TempBlob.CreateOutStream(OutS);
        // if Query.SaveAsJson(Query::"ZY Purchase Order Query", OutS) then begin
        //     JsonString := TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InS, TypeHelper.LFSeparator(), 'ZY Purchase Order Query');
        //     Message(JsonString);
        // end;
    end;

    trigger OnOpenPage()
    var
        SearchString: Text[250];
        RecRef: RecordRef;
        FldRef: FieldRef;
    begin
        SearchString := 'London chair blue';
        Rec.SetFilter(Description, SplitSearchString(SearchString));
    end;

    local procedure SplitSearchString(var SearchString: Text[250]): Text[250]
    var
        i: Integer;
        StringList: List of [Text];
    begin
        StringList := SearchString.Split(' ');
        if StringList.Count > 0 then
            for i := 1 to StringList.Count do begin
                if i = 1 then
                    SearchString := '&&' + StringList.Get(i) + '*'
                else
                    SearchString := SearchString + '&&&' + StringList.Get(i) + '*';
            end;
        exit(SearchString);
    end;
}
