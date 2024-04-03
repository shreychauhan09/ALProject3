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
                    Xmlport.Run(50100, true, false);
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
                    Xmlport.Run(50101, false, true);
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
    }
}
