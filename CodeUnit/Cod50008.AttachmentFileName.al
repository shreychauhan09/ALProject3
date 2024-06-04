// codeunit 50008 "Attachment FileName"
// {
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Mailing", 'OnBeforeGetAttachmentFileName', '', false, false)]
//     local procedure OnBeforeGetAttachmentFileName(var AttachmentFileName: Text[250]; PostedDocNo: Code[20]; EmailDocumentName: Text[250]; ReportUsage: Integer)
//     var
//         SalesInvoiceHeader: Record "Sales Invoice Header";
//         EmailAttachmentsSetup: Record "Email Attachments";
//         ReportSelectionUsage: Enum "Report Selection Usage";
//         ReportAsPdfFileNameMsg: Label '%1 %2.pdf', Comment = '%1 = Document Type %2 = Invoice No. or Job Number';
//     begin
//         if PostedDocNo = '' then
//             exit;

//         case ReportUsage of
//             ReportSelectionUsage::"S.Invoice".AsInteger():
//                 begin
//                     SalesInvoiceHeader.Get(PostedDocNo);
//                     EmailAttachmentsSetup.SetRange("Report ID", 0);
//                     EmailAttachmentsSetup.SetRange("Language Code", SalesInvoiceHeader."Language Code");
//                     EmailAttachmentsSetup.SetRange("Table No.", Database::"Sales Invoice Header");
//                     EmailAttachmentsSetup.SetRange("Field No.", 0);
//                     if not EmailAttachmentsSetup.FindFirst() then
//                         exit;

//                     AttachmentFileName := StrSubstNo(ReportAsPdfFileNameMsg, EmailAttachmentsSetup."Translate To", PostedDocNo);
//                     EmailDocumentName := AttachmentFileName; // Update the email document name
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Layout Reporting", 'OnGenerateFileNameOnAfterAssignFileName', '', false, false)]
//     local procedure OnGenerateFileNameOnAfterAssignFileName(var FileName: Text; ReportID: Integer; Extension: Text; DataRecRef: RecordRef)
//     var
//         AllObjWithCaption: Record AllObjWithCaption;
//         Customer: Record Customer;
//         EmailAttachmentsSetup: Record "Email Attachments";
//         FilenameLbl: Label '%1 - %2%3', Comment = '%1 = report caption, %2 = customer name, %3 = extension';
//     begin
//         if DataRecRef.Number <> Database::Customer then
//             exit;

//         DataRecRef.SetTable(Customer);
//         EmailAttachmentsSetup.SetRange("Report ID", ReportID);
//         EmailAttachmentsSetup.SetRange("Language Code", Customer."Language Code");
//         EmailAttachmentsSetup.SetRange("Table No.", 0);
//         EmailAttachmentsSetup.SetRange("Field No.", 0);
//         if not EmailAttachmentsSetup.FindFirst() then begin
//             AllObjWithCaption.Get(AllObjWithCaption."Object Type"::Report, ReportID);
//             FileName := StrSubstNo(FileNameLbl, AllObjWithCaption."Object Caption", Customer.Name, Extension);
//             exit;
//         end;

//         FileName := StrSubstNo(FileNameLbl, EmailAttachmentsSetup."Translate To", Customer.Name, Extension);
//     end;
// }
codeunit 50008 "Attachment FileName"
{
    // This event is triggered before the attachment file name is retrieved for document mailing.
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Mailing", 'OnBeforeGetAttachmentFileName', '', false, false)]
    local procedure OnBeforeGetAttachmentFileName(var AttachmentFileName: Text[250]; PostedDocNo: Code[20]; EmailDocumentName: Text[250]; ReportUsage: Integer)
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        EmailAttachments: Record "Email Attachments";
        ReportSelectionUsage: Enum "Report Selection Usage";
        SalesReportFileNameMsg: Label '%1 - Invoice %2.pdf', Comment = '%1 = Report Name, %2 = Invoice No.';
    begin
        if PostedDocNo = '' then
            exit;

        case ReportUsage of
            ReportSelectionUsage::"S.Invoice".AsInteger():
                if SalesInvoiceHeader.Get(PostedDocNo) then begin
                    EmailAttachments.SetRange(Scenario, Enum::"Email Scenario"::"Sales Order"); // Adjust Enum as per your usage
                    if EmailAttachments.FindFirst() then begin
                        EmailAttachments."Attachment Name" := StrSubstNo(SalesReportFileNameMsg, EmailAttachments."Attachment Name", PostedDocNo);
                        EmailAttachments.Modify();
                        AttachmentFileName := EmailAttachments."Attachment Name";
                    end;
                end;
        end;
    end;

    // Subscribe to additional events if needed to handle different scenarios or reports
    // Further customization for other scenarios can be done similarly by handling other Enum cases
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Mailing", 'OnBeforeGetAttachmentFileName', '', false, false)]
    // local procedure OnBeforeGetAttachmentFileName(var AttachmentFileName: Text[250]; PostedDocNo: Code[20]; EmailDocumentName: Text[250]; ReportUsage: Integer)
    // var
    //     SalesInvoiceHeader: Record "Sales Invoice Header";
    //     EmailAttachmentsSetup: Record "Email Attachments";
    //     ReportSelectionUsage: Enum "Report Selection Usage";
    //     ReportAsPdfFileNameMsg: Label '%1 %2.pdf', Comment = '%1 = Document Type %2 = Invoice No. or Job Number';
    // begin
    //     if PostedDocNo = '' then
    //         exit;

    //     case ReportUsage of
    //         ReportSelectionUsage::"S.Invoice".AsInteger():
    //             begin
    //                 SalesInvoiceHeader.Get(PostedDocNo);
    //                 EmailAttachmentsSetup.SetRange("Scenario", EmailAttachmentsSetup.Scenario::"Sales Invoice");
    //                 EmailAttachmentsSetup.SetRange("Attachment Name", SalesInvoiceHeader."No.");
    //                 if not EmailAttachmentsSetup.FindFirst() then
    //                     exit;

    //                 AttachmentFileName := StrSubstNo(ReportAsPdfFileNameMsg, EmailAttachmentsSetup."Attachment Name", PostedDocNo);
    //                 EmailDocumentName := AttachmentFileName; // Update the email document name
    //             end;
    //     end;
    // end;
}


