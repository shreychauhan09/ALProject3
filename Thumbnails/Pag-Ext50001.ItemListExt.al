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
    }
}
