/// <summary>
/// Codeunit API Call (ID 60015).
/// </summary>
codeunit 60015 "API Call"
{
    var
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        IsSuccessful: Boolean;
        HttpClient: HttpClient;
        ResponseMessage: HttpResponseMessage;
        JToken: JsonToken;
        JObject: JsonObject;
        JValue: JsonValue;
        RequestHeaders: HttpHeaders;
        RequestMessage: HttpRequestMessage;
        ResponseText: Text;
        TempBlob: Codeunit "Temp Blob";

    /// <summary>
    /// CallAPI.
    /// </summary>
    procedure CallAPI()
    var
        RequestText: Text;
        AuthText: Text;
        Base64Text: Text;
        Convert: Codeunit "Base64 Convert";
    begin
        Content.WriteFrom(RequestText);
        Content.GetHeaders(ContentHeaders);

        RequestMessage.Content := Content;
        RequestMessage.GetHeaders(RequestHeaders);
        RequestMessage.SetRequestUri('http://desktop-iv1kdp1:7048/BC220/ODataV4/Company(''CRONUS%20India%20Ltd.'')/CustomAPI');
        RequestMessage.Method('GET');

        AuthText := strsubstNo('%1:%2', 'DESKTOP-IV1KDP1\ADMIN', '2962');
        Base64Text := Convert.ToBase64(AuthText); // Convert text to Base64

        RequestHeaders.Add('Authorization', StrSubstNo('Basic %1', Base64Text));
        RequestHeaders.Add('Connection', 'keep-alive');

        HttpClient.Timeout := 30000;
        HttpClient.send(RequestMessage, ResponseMessage);
    end;
}
