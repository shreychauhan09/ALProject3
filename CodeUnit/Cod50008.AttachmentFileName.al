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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Mailing", 'OnBeforeGetAttachmentFileName', '', false, false)]
    local procedure OnBeforeGetAttachmentFileName(var AttachmentFileName: Text[250]; PostedDocNo: Code[20]; EmailDocumentName: Text[250]; ReportUsage: Integer)
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        ForNAVLanguageSetup: Record "Email Attachments";
        ReportSelectionUsage: Enum "Report Selection Usage";
        ReportAsPdfFileNameMsg: Label '%1 %2.pdf', Comment = '%1 = Document Type %2 = Invoice No. or Job Number';
    begin
        if PostedDocNo = '' then
            exit;
        case ReportUsage of
            ReportSelectionUsage::"S.Order".AsInteger():
                begin
                    SalesInvoiceHeader.Get(PostedDocNo);
                    AttachmentFileName := '"Custom Name"'
                end;
        end;
        SendCompletionMail(SalesInvoiceHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Layout Reporting", 'OnGenerateFileNameOnAfterAssignFileName', '', false, false)]
    local procedure OnGenerateFileNameOnAfterAssignFileName(var FileName: Text; ReportID: Integer; Extension: Text; DataRecRef: RecordRef)
    var
        AllObjWithCaption: Record AllObjWithCaption;
        Customer: Record Customer;
        // ForNAVLanguageSetup: Record "ForNAV Language Setup";
        FilenameLbl: Label '%1 - %2%3', Comment = '%1 = report caption, %2 = customer name, %3 = extension';
    begin
        if DataRecRef.Number <> Database::Customer then
            exit;
        DataRecRef.SetTable(Customer);

        FileName := '"Custom Name"';

    end;


    procedure SendCompletionMail(SalesInvoiceHeader: Record "Sales Invoice Header"): Boolean
    var
        Subject: Text[150];
        Body: text[1024];
        Instr: InStream;
        EmailMessage: Codeunit "Email Message";
        MailManagement: Codeunit "Mail Management";
        Email: Codeunit Email;
        TempBlob: Codeunit "Temp Blob";
        ToRecipients: List of [Text];
        BCCRecipients: List of [Text];
        CCRecipients: List of [Text];
        ReportParameters: text;
        Instrm: InStream;
        OutStr: OutStream;
        users: Record User;
        UserStp: Record "User Setup";
    begin
        // UserStp.SetRange("User ID", Rec.Indenter);
        // if UserStp.FindFirst() then
        //     ToRecipients.Add(UserStp."E-Mail");

        // BCCRecipients.Add('');
        // Subject := 'Material Movement Notification : ' + Rec."Source Name";
        // EmailMessage.Create(ToRecipients, Subject, '', true, CCRecipients, BCCRecipients);

        // EmailMessage.AppendToBody('Dear Sir/ Madam,');
        // EmailMessage.AppendToBody('<br>');
        // EmailMessage.AppendToBody('The material movement has been completed, details as follows:');
        // EmailMessage.AppendToBody('<br><br>');

        // EmailMessage.AppendToBody('<b>• Material description | Quantity : </b>' + Rec."Material Description" + ' | ' + Rec."Quantity/Weight");
        // EmailMessage.AppendToBody('<br>');
        // EmailMessage.AppendToBody('<b>• Delivery /collection            : </b>' + Format(Rec."Delivery/Collect"));
        // EmailMessage.AppendToBody('<br>');
        // EmailMessage.AppendToBody('<b>• Vehicle number                  : </b>' + Rec."Vehicle Name");
        // EmailMessage.AppendToBody('<br>');
        // EmailMessage.AppendToBody('<b>• Remarks                         : </b>' + Rec.Remarks);
        // EmailMessage.AppendToBody('<br>');
        // EmailMessage.AppendToBody('<b>• Date of Activity                : </b>' + Format(Rec."Plan Date"));
        // EmailMessage.AppendToBody('<br>');
        // EmailMessage.AppendToBody('<br>');

        // EmailMessage.AppendToBody('In case of a query, Please contact the logistics department.');
        // EmailMessage.AppendToBody('<br><br>');

        // EmailMessage.AppendToBody('Warm Regards,');
        // EmailMessage.AppendToBody('<br>');
        // EmailMessage.AppendToBody('Team Logistics');
        // EmailMessage.AppendToBody('<br>');
        // EmailMessage.AppendToBody('EQUITRON MEDICA PRIVATE LIMITED');
        // EmailMessage.AppendToBody('<br>');
        // EmailMessage.AppendToBody('Plot EL-177, Electronic Zone, TTC Industrial Area,');
        // EmailMessage.AppendToBody('<br>');
        // EmailMessage.AppendToBody('MIDC Mahape, Navi Mumbai 400710, MH, INDIA.');
        // EmailMessage.AppendToBody('<br>');
        // EmailMessage.AppendToBody('T: 022 6618-9989 Extn: 946 / 6618-9946 (Dir)');
        // EmailMessage.AppendToBody('<br>');
        // EmailMessage.AppendToBody('M: +91 86579-35501');
        // EmailMessage.AppendToBody('<br>');
        // EmailMessage.AppendToBody('E: logistics2@medicainstrument.com');
        // EmailMessage.AppendToBody('<br>');
        // EmailMessage.AppendToBody('W: www.medicainstrument.com');
        // EmailMessage.AppendToBody('<br>');

        ToRecipients.Add('shrey.c@lfspl.com');

        //  ReportParameters := AttachedReport.RunRequestPage();
        TempBlob.CreateOutStream(OutStr);
        Report.SaveAs(Report::"Work Order", ReportParameters, ReportFormat::Pdf, OutStr);
        TempBlob.CreateInStream(Instrm);
        CCRecipients.Add('pratik.m@lfspl.com');
        BCCRecipients.Add('');
        Subject := 'How to Change Subject, Body and Attachment Name ' + Format(Today);
        Body := 'Dear Sir/ Madam,';
        Body += '<p>Please find the attachment for Sales' + Format(Today) + '<p>';
        EmailMessage.Create(ToRecipients, Subject, Body, true, CCRecipients, BCCRecipients);
        EmailMessage.AddAttachment('Work Order.Pdf', '.Pdf', Instrm);
        Email.Send(EmailMessage);

        Email.Send(EmailMessage);
        Message('Notification Mail sent successfully');
    end;
    // // This event is triggered before the attachment file name is retrieved for document mailing.
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Mailing", 'OnBeforeGetAttachmentFileName', '', false, false)]
    // local procedure OnBeforeGetAttachmentFileName(var AttachmentFileName: Text[250]; PostedDocNo: Code[20]; EmailDocumentName: Text[250]; ReportUsage: Integer)
    // var
    //     SalesInvoiceHeader: Record "Sales Invoice Header";
    //     EmailAttachments: Record "Email Attachments";
    //     ReportSelectionUsage: Enum "Report Selection Usage";
    //     SalesReportFileNameMsg: Label '%1 - Invoice %2.pdf', Comment = '%1 = Report Name, %2 = Invoice No.';
    // begin
    //     if PostedDocNo = '' then
    //         exit;

    //     case ReportUsage of
    //         ReportSelectionUsage::"S.Invoice".AsInteger():
    //             if SalesInvoiceHeader.Get(PostedDocNo) then begin
    //                 EmailAttachments.SetRange(Scenario, Enum::"Email Scenario"::"Sales Order"); // Adjust Enum as per your usage
    //                 if EmailAttachments.FindFirst() then begin
    //                     EmailAttachments."Attachment Name" := StrSubstNo(SalesReportFileNameMsg, EmailAttachments."Attachment Name", PostedDocNo);
    //                     EmailAttachments.Modify();
    //                     AttachmentFileName := EmailAttachments."Attachment Name";
    //                 end;
    //             end;
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Mailing", OnBeforeSendEmail, '', false, false)]
    // local procedure "Document-Mailing_OnBeforeSendEmail"(var TempEmailItem: Record "Email Item" temporary; var IsFromPostedDoc: Boolean; var PostedDocNo: Code[20]; var HideDialog: Boolean; var ReportUsage: Integer; var EmailSentSuccesfully: Boolean; var IsHandled: Boolean; EmailDocName: Text[250]; SenderUserID: Code[50]; EmailScenario: Enum "Email Scenario")
    // begin
    //     EmailDocName := 'Shrey Chauhan';
    // end;

    //  [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Mailing", 'OnBeforeGetAttachmentFileName', '', false, false)]
    // local procedure OnBeforeGetAttachmentFileName(var AttachmentFileName: Text[250]; PostedDocNo: Code[20]; EmailDocumentName: Text[250]; ReportUsage: Integer)
    // var
    //     SalesInvoiceHeader: Record "Sales Invoice Header";
    //     ForNAVLanguageSetup: Record "Email Attachments";
    //     ReportSelectionUsage: Enum "Report Selection Usage";
    //     ReportAsPdfFileNameMsg: Label '%1 %2.pdf', Comment = '%1 = Document Type %2 = Invoice No. or Job Number';
    // begin
    //     if PostedDocNo = '' then
    //         exit;
    //     case ReportUsage of
    //         ReportSelectionUsage::"S.Invoice".AsInteger():
    //             begin
    //                 SalesInvoiceHeader.Get(PostedDocNo);
    //         AttachmentFileName := "Custom Name"
    //             end;
    //     end;
    // end;
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Layout Reporting", 'OnGenerateFileNameOnAfterAssignFileName', '', false, false)]
    // local procedure OnGenerateFileNameOnAfterAssignFileName(var FileName: Text; ReportID: Integer; Extension: Text; DataRecRef: RecordRef)
    // var
    //     AllObjWithCaption: Record AllObjWithCaption;
    //     Customer: Record Customer;
    //     ForNAVLanguageSetup: Record "ForNAV Language Setup";
    //     FilenameLbl: Label '%1 - %2%3', Comment = '%1 = report caption, %2 = customer name, %3 = extension';
    // begin
    //     if DataRecRef.Number <> Database::Customer then
    //         exit;
    //     DataRecRef.SetTable(Customer);

    //     FileName := "Custom Name";
    // end;

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


