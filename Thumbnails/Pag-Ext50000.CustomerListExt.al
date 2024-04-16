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
            field(Facebook; Rec.Facebook)
            {
                Caption = 'Facebook';
                ApplicationArea = SocialMedia;
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
        addafter(ApplyTemplate)
        {
            action("Item list - Test01")
            {
                ApplicationArea = All;
                Caption = 'Item list - Test01';
                Image = Open;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    OpenSpecifiedView('aa49406f-6f68-4565-b857-496faa0e77aa_Test0112223', Page::"Item List");
                end;
            }
            action("Item list - Test02")
            {
                ApplicationArea = All;
                Caption = 'Item list - Test02';
                Image = Open;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    OpenSpecifiedView('aa49406f-6f68-4565-b857-496faa0e77aa_Test0221625', Page::"Item List");
                end;
            }
            action("Item list - ZYTest")
            {
                ApplicationArea = All;
                Caption = 'Item list - ZYTest';
                Image = Open;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    OpenSpecifiedView('aa49406f-6f68-4565-b857-496faa0e77aa_ZYTest00045', Page::"Item List");
                end;
            }
            action("Customer Ledger Entries - Invoice")
            {
                ApplicationArea = All;
                Caption = 'Customer Ledger Entries - Invoice';
                Image = Open;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    OpenSpecifiedView('aa49406f-6f68-4565-b857-496faa0e77aa_Invoice07400', Page::"Customer Ledger Entries");
                end;
            }
        }
        addafter(ApprovalEntries)
        {
            action("Open Social Media")
            {
                ApplicationArea = All;
                Caption = 'Open Social Media';
                Image = Information;
                trigger OnAction();
                begin
                    // Call your codeunit here
                    // Codeunit.Run(Codeunit::"Open Social Media");
                end;
            }
        }
    }

    local procedure OpenSpecifiedView(ViewID: Text; PageID: Integer)
    var
        DefaultView: Text;
        URL: Text;
    begin
        DefaultView := '&view=' + ViewID;
        URL := GetUrl(CurrentClientType, CompanyName, ObjectType::Page, PageID) + DefaultView;
        Hyperlink(URL);
    end;

    trigger OnOpenPage()
    var
        EnableSocialExtension: Codeunit "Enable Social Media Extension";
    begin
        if EnableSocialExtension.IsSocialApplicationAreaEnabled() then
            Message('App published: Social Extension');
    end;
}