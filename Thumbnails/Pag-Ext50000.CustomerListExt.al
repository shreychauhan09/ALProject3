/// <summary>
/// PageExtension Customer List Ext (ID 50000) extends Record Customer List.
/// </summary>
pageextension 50000 "Customer List Ext" extends "Customer List"
{
    layout
    {
        addafter(Name)
        {
            field(Thumbnails; Rec.Thumbnails)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(ApplyTemplate)
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
                            if TenantMedia.Get(Rec.Image.MediaId) then begin
                                TenantMedia.CalcFields(Content);
                                Rec.Thumbnails := TenantMedia.Content;
                                Rec.Modify(true);
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
