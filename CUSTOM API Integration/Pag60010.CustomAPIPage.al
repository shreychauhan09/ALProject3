/// <summary>
/// Page Custom API Page (ID 60010).
/// </summary>
page 60010 "Custom API Page"
{
    ApplicationArea = All;
    Caption = 'Custom API Page';
    PageType = List;
    SourceTable = "Custom API Table";
    UsageCategory = Lists;
    CardPageId = "API Card";
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                    trigger OnAfterLookup(Selected: RecordRef)
                    var
                        Item: record Item;
                    begin
                        Selected.SetTable(Item);
                        // Validate(Name, Item.Description);
                    end;
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Specifies the value of the Address 2 field.';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field.';
                }
                field(State; Rec.State)
                {
                    ToolTip = 'Specifies the value of the State field.';
                }
                field("Contact No."; Rec."Contact No.")
                {
                    ToolTip = 'Specifies the value of the Contact No. field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field("API URL"; Rec."API URL")
                {

                }
                field(Enums; Rec.Enums)
                {

                }
                field(Options; Rec.Options)
                {

                }
                field("Auto Format"; Rec."Auto Format")
                {

                }
                field(Code; Rec.Code)
                {

                }
                field(Booleans; Rec.Booleans)
                {

                }
                field(UserName; GetUserNameFromSecurityId(Rec.SystemCreatedBy))
                {
                    Caption = 'User Name';
                    ApplicationArea = All;
                }
                field(RichText; RichText)
                {
                    ApplicationArea = ALL;
                    // ExtendedDataType = RichContent;
                    ExtendedDatatype = RichContent;
                    MultiLine = true;

                    // Ensures that the value from the RichText variable is persisted in the record
                    trigger OnValidate()
                    begin
                        Rec.SaveRichText(RichText);
                    end;
                }
            }

        }
    }
    actions
    {
        area(Processing)
        {
            action("API Call")
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    CallAPI();
                end;
            }
            action("Format Action")
            {
                ApplicationArea = All;
                Image = Alerts;
                trigger OnAction()
                var
                    DecimalToRound: Decimal;
                    Direction: Text;
                    Precision: Decimal;
                    Result: Decimal;
                    Text: Label 'Round(%1, %2, %3) returns %4.';
                begin
                    MESSAGE('%1', FORMAT(1000.1, 0, '<Precision,5:5><Standard Format,0>'));
                    Message('%1', Format(DT2Date(CurrentDateTime), 40, '<Standard Format,4>'));
                    Message('%1', Format(DT2Date(CurrentDateTime), 30, '<Weekday Text>, <Month Text> <Day>'));
                    Message('%1', Format(DT2Time(CurrentDateTime), 20, '<Standard Format,9>'));
                    Message('%1', Format(CurrentDateTime, 40, '<Standard Format,9>'));
                    Message('%1', Format(Rec.SystemId, 38, '<Standard Format,3>'));
                    Message('%1', Format(Rec.Enums), '<Standard Format,1>');
                    Message('%1', Format(Rec.Options), '<Standard Format,1>');
                    Message('%1', Format(123));
                    Message('%1', format(Rec.SystemCreatedAt, 0, '<Day,2>/<Month,2>/<Year4> <Hours12,2>:<Minutes,2>:<Seconds,2> <AM/PM>'));
                    DecimalToRound := 1234.5678912;
                    Direction := '>';
                    Precision := 0.01;
                    Result := Round(DecimalToRound, Precision, Direction);
                    Message(Text, Format(DecimalToRound, 0, 1), Precision, Direction, Result);
                    // Message(Format(JsonToken));
                    // Message(Format(JsonValues));
                    // Message(Format(JsonObjects));
                    Message('%1', Format(Rec.Booleans));
                    Message('%1', Format(Rec.Code));
                end;
            }
        }
        area(Navigation)
        {
            action(BlobImport)
            {
                ApplicationArea = all;
                Image = Import;
                trigger OnAction()
                var
                    tempblob: Codeunit "Temp Blob";
                    Instr: InStream;
                    OutStr: OutStream;
                begin
                    ImportBlob(tempblob, Rec.Name);
                    tempblob.CreateInStream(Instr);
                    Rec."Rich Text".CreateOutStream(OutStr);
                    CopyStream(OutStr, Instr);
                    Rec.Modify();
                end;
            }
            action(BlobExport)
            {
                ApplicationArea = ALl;
                Image = Export;
                trigger OnAction()
                var
                    tempblob: Codeunit "Temp Blob";
                    Instr: InStream;
                    OutStr: OutStream;
                begin
                    Rec.CalcFields("Rich Text");
                    if Rec."Rich Text".HasValue then begin
                        Message('My Blob filed has some value');
                        Rec."Rich Text".CreateInStream(Instr);
                        tempblob.CreateOutStream(OutStr);
                        CopyStream(OutStr, Instr);
                        ExportBlob(tempblob, Rec.Name);
                    end else
                        Message('Blob does not hold any thing');
                end;
            }
        }
    }
    /// <summary>
    /// CallAPI.
    /// </summary>
    procedure CallAPI()
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
        // TempBlob: Record "Temp Blob" temporary;
        AuthText: Text;
        RequestText: Text;
        Convert: Codeunit "Base64 Convert";
    begin

        // RequestMessage.GetHeaders(RequestHeaders);
        // AuthText := StrSubstNo('%1:%2', 'DESKTOP-IV1KDP1\ADMIN', '2962');
        // TempBlob.WriteAsText(AuthText, TextEncoding::Windows);
        // RequestHeaders.Add('Authorization', StrSubstNo('NTLM %1:%2', 'DESKTOP-IV1KDP1\ADMIN', '2962'));
        // HttpClient.UseWindowsAuthentication('DESKTOP-IV1KDP1\ADMIN', '2962');
        // HttpClient.UseDefaultNetworkWindowsAuthentication()
        Content.GetHeaders(contentHeaders);
        RequestMessage.GetHeaders(RequestHeaders);
        RequestHeaders.Add('Username', 'DESKTOP-IV1KDP1\ADMIN');
        RequestHeaders.Add('Password', '2962');

        // RequestHeaders.Add('Authorization', 'Basic ' + Convert.ToBase64('DESKTOP-IV1KDP1\ADMIN' + ':' + '2962'));

        // ContentHeaders.Add('Username', 'DESKTOP-IV1KDP1\ADMIN');
        // ContentHeaders.Add('Password', '2962');
        // RequestHeaders.Add('request-id', Format(Random(9999)));
        // RequestHeaders.Add('OData-Version', '4.0');
        // RequestHeaders.Add('Access-Control-Allow-Credentials', 'true');
        // RequestMessage.SetRequestUri(Rec."API URL");
        if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
        ContentHeaders.Add('Content-Type', 'application/json');
        RequestMessage.SetRequestUri('http://desktop-iv1kdp1:7048/BC240/ODataV4/Company(''CRONUS%20India%20Ltd.'')/CustomApiPage');
        RequestMessage.Method('GET');
        // IsSuccessful := HttpClient.Get('http://desktop-iv1kdp1:7048/BC220/ODataV4/Company(''CRONUS%20India%20Ltd.'')/CustomAPI', ResponseMessage);
        IsSuccessful := HttpClient.Send(RequestMessage, ResponseMessage);
        Error('Status Code: %1\ Reason : %2', ResponseMessage.HttpStatusCode, ResponseMessage.ReasonPhrase);
        if not IsSuccessful then
            Error('Status Code: %1\ Reason : %2', ResponseMessage.HttpStatusCode, ResponseMessage.ReasonPhrase)
        else begin
            ResponseMessage.Content.ReadAs(ResponseText);
            JObject.ReadFrom(ResponseText);
            Message(ResponseText);
        end;

    end;

    /// <summary>
    /// GetUserNameFromSecurityId.
    /// </summary>
    /// <param name="UserSecurityID">Guid.</param>
    /// <returns>Return value of type Code[50].</returns>
    procedure GetUserNameFromSecurityId(UserSecurityID: Guid): Code[50]
    var
        User: Record User;
    begin
        User.Get(UserSecurityID);
        exit(User."User Name");
    end;


    trigger OnPageBackgroundTaskCompleted(TaskId: Integer; Results: Dictionary of [Text, Text])
    var
        started: Text;
        waited: Text;
        finished: Text;
        PBTNotification: Notification;
        WaitTaskId: Integer;
        before1: Text;
        duration1: text;
        after1: Text;
    begin
        if (TaskId = WaitTaskId) then begin
            Evaluate(started, Results.Get('started'));
            Evaluate(waited, Results.Get('waited'));
            Evaluate(finished, Results.Get('finished'));

            before1 := started;
            duration1 := waited;
            after1 := finished;
            PBTNotification.Message('Start and finish times have been updated.');
            PBTNotification.Send();
            Message('%1 : %2 : %3', before1, duration1, after1);
        end;
    end;

    trigger OnPageBackgroundTaskError(TaskId: Integer; ErrorCode: Text; ErrorText: Text; ErrorCallStack: Text; var IsHandled: Boolean)
    var
        PBTErrorNotification: Notification;
    begin
        if (ErrorText = 'Could not parse parameter WaitParam') then begin
            IsHandled := true;
            PBTErrorNotification.Message('Something went wrong. The start and finish times have been updated.');
            PBTErrorNotification.Send();
        end

        else
            if (ErrorText = 'Child Session task was terminated because of a timeout.') then begin
                IsHandled := true;
                PBTErrorNotification.Message('It took to long to get results. Try again.');
                PBTErrorNotification.Send();
            end
    end;

    /// <summary>
    /// ImportBlob.
    /// </summary>
    /// <param name="tblob">VAR Codeunit "Temp Blob".</param>
    /// <param name="fieldname">VAR Text.</param>
    procedure ImportBlob(var tblob: Codeunit "Temp Blob"; var fieldname: Text)
    var
        filemanagement: Codeunit "File Management";
        filename: Text;
    begin
        fieldname := filemanagement.BLOBImport(tblob, filename);
    end;
    /// <summary>
    /// ExportBlob.
    /// </summary>
    /// <param name="tblob">VAR Codeunit "Temp Blob".</param>
    /// <param name="fieldname">VAR Text.</param>
    procedure ExportBlob(var tblob: Codeunit "Temp Blob"; var fieldname: Text)
    var
        filemanagement: Codeunit "File Management";
    begin
        filemanagement.BLOBExport(tblob, fieldname, true);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        RichText := Rec.GetRichText();
    end;

    var
        RichText: Text;
}