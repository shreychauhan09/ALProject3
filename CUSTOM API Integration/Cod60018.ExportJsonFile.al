/// <summary>
/// Codeunit Export Json File (ID 60018).
/// </summary>
codeunit 60018 "Export Json File"
{
    /// <summary>
    /// RunCustomerApi.
    /// </summary>
    procedure RunCustomerApi()
    begin

        DocumentNo := Format(customapi."No.");
        WriteJsonFileHeader();
        ReadDocumentHeaderDetails();
        // ExportAsJson('');
    end;
    /// <summary>
    /// SetSalesInvHeader.
    /// </summary>
    /// <param name="customapi_g">Record "Custom API Table".</param>
    procedure SetCustomApi(customapi_g: Record "Custom API Table")
    begin
        CustomApi := customapi_g;
        // IsInvoice := true;
        DocumentNo := Format(customapi."No.");
        WriteJsonFileHeader();
        ReadDocumentHeaderDetails();
    end;

    local procedure Initialize()
    begin
        Clear(JObject);
        Clear(JsonArrayData);
        Clear(JsonText);
    end;

    local procedure ExportAsJson(FileName: Text[20])
    var
        TempBlob: Codeunit "Temp Blob";
        ToFile: Variant;
        InStream: InStream;
        OutStream: OutStream;
    begin
        JsonArrayData.Add(JObject);
        JsonArrayData.WriteTo(JsonText);
        TempBlob.CreateOutStream(OutStream);
        OutStream.WriteText(JsonText);
        ToFile := FileName + '.json';
        TempBlob.CreateInStream(InStream);
        DownloadFromStream(InStream, 'Json Body', '', '', ToFile);
    end;

    local procedure WriteJsonFileHeader()
    begin
        JObject.Add('Version', '1.1');
        // JsonArrayData.Add(JObject);
    end;


    local procedure ReadDocumentHeaderDetails()
    var
        InvoiceType: Text[3];
        PostingDate: Text[10];
        OriginalInvoiceNo: Text[16];
    begin
        Clear(JsonArrayData);
        WriteDocumentHeaderDetails(DocumentNo);
    end;

    local procedure WriteDocumentHeaderDetails(DocumentNo: Text[16])
#pragma warning restore AA0244
    var
        JDocumentHeaderDetails: JsonObject;
    begin
        JDocumentHeaderDetails.Add('No', DocumentNo);
        JDocumentHeaderDetails.Add('Date', CustomApi.SystemCreatedAt);
        JDocumentHeaderDetails.Add('Name', CustomApi.Name);
        JDocumentHeaderDetails.Add('Address', CustomApi.Address);
        JDocumentHeaderDetails.Add('Contact No.', CustomApi."Contact No.");

        JObject.Add('DocDtls', JDocumentHeaderDetails);
    end;

    trigger OnRun()
    begin
        Initialize();
        RunCustomerApi();
        if DocumentNo <> '' then
            ExportAsJson(DocumentNo)
    end;

    var
        JObject: JsonObject;
        JsonArrayData: JsonArray;
        JObjectforExport: JsonObject;
        JsonText: Text;
        CustomApi: Record "Custom API Table";
        DocumentNo: Text;
}
