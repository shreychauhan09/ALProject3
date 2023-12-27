/// <summary>
/// Codeunit API Request handler codeunit (ID 60012).
/// </summary>
codeunit 60012 "API Request handler codeunit"
{
    TableNo = "Custom API Table";

    trigger OnRun()
    begin
    end;

    /// <summary>
    /// GetResponse.
    /// </summary>
    /// <param name="requestURL">Text.</param>
    /// <param name="erroMsg">Text.</param>
    /// <returns>Return value of type Text.</returns>
    procedure GetResponse(requestURL: Text; erroMsg: Text): Text
    var
        httpClient: HttpClient;
        httpResponseMsg: HttpResponseMessage;
        httpRequestMsg: HttpRequestMessage;
        response: Text;
    // recWebServiceLog: Record WebServiceLog;
    // cuCommon: Codeunit CommonCodeunit;
    begin
        erroMsg := '';
        // cuCommon.InsertWebServiceLog('', '', requestURL, recWebServiceLog);
        if not httpClient.Get(requestURL, httpResponseMsg) then begin
            erroMsg := 'The call to webservice is failed';
        end;

        if not httpResponseMsg.IsSuccessStatusCode then begin
            erroMsg += '\The request call returned an error message. \Detail: \Status Code: ' +
                   Format(httpResponseMsg.HttpStatusCode) + '\Description: ' + httpResponseMsg.ReasonPhrase;
        end;

        httpResponseMsg.Content.ReadAs(response);
        // cuCommon.UpdateWebServiceLog(recWebServiceLog);
        exit(response);
    end;
}
