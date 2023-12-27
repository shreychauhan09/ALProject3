/// <summary>
/// Codeunit API Response Handler codeunit (ID 60013).
/// </summary>
codeunit 60013 "API Response Handler codeunit"
{
    TableNo = "Custom API Table";

    trigger OnRun()
    begin

    end;

    /// <summary>
    /// UsersInfoFromResponse.
    /// </summary>
    /// <param name="response">Text.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure UsersInfoFromResponse(response: Text): Boolean
    var
        responseArray: JsonArray;
        json_Token: JsonToken;
        json_Object: JsonObject;
        userInfo_JsonObject: JsonObject;
        i: Integer;
    begin
        //if json_Object.ReadFrom(response) then begin        
        if json_Token.ReadFrom(response) then begin
            if json_Token.IsArray then   // json_Token.IsArray; json_Token.IsObject; json_Token.IsValue;
                responseArray := json_Token.AsArray();
            for i := 0 to responseArray.Count() - 1 do begin

                responseArray.Get(i, json_Token);

                if json_Token.IsObject then begin
                    userInfo_JsonObject := json_Token.AsObject();
                    insertUsersDetail(userInfo_JsonObject);
                end;

            end;
        end;
        //end;
        exit(true);
    end;

    /// <summary>
    /// insertUsersDetail.
    /// </summary>
    /// <param name="userInfoJsonObject">JsonObject.</param>
    procedure insertUsersDetail(userInfoJsonObject: JsonObject)
    var
        recJPUser: Record "Custom API Table";
        json_Methods: Codeunit "API Handler";
        retJsonValue: JsonValue;
        addressJsonObject: JsonObject;
        addressJsonToken: JsonToken;
        geoJsonObject: JsonObject;
        geoJsonToken: JsonToken;
        companyJsonObject: JsonObject;
        companyJsonToken: JsonToken;
    begin
        recJPUser.Reset();
        recJPUser.Init();
        recJPUser."No." := json_Methods.GetJsonToken(userInfoJsonObject, 'No.').AsValue().AsInteger();

        recJPUser."No." := json_Methods.GetJsonValueAsInteger(userInfoJsonObject, 'No.');

        if json_Methods.GetJsonValue(userInfoJsonObject, 'No.', retJsonValue) then
            recJPUser."No." := retJsonValue.AsInteger();

        recJPUser.name := json_Methods.GetJsonValueAsText(userInfoJsonObject, 'name');


        if json_Methods.GetJsonValue(userInfoJsonObject, 'Name', retJsonValue) then
            recJPUser.Name := retJsonValue.AsText();

        recJPUser.Address := json_Methods.GetJsonValueAsText(userInfoJsonObject, 'email');


        if userInfoJsonObject.Get('Value', addressJsonToken) then begin
            if addressJsonToken.IsObject then begin
                addressJsonObject := addressJsonToken.AsObject();
                recJPUser."No." := json_Methods.GetJsonValueAsInteger(addressJsonObject, 'No.');
                recJPUser.Name := json_Methods.GetJsonValueAsText(addressJsonObject, 'Name');
                recJPUser.Address := json_Methods.GetJsonValueAsText(addressJsonObject, 'Address');
                recJPUser."Address 2" := json_Methods.GetJsonValueAsText(addressJsonObject, 'Address 2');
                recJPUser.City := json_Methods.GetJsonValueAsText(addressJsonObject, 'City');
                recJPUser.State := json_Methods.GetJsonValueAsText(addressJsonObject, 'State');
                recJPUser."Contact No." := json_Methods.GetJsonValueAsText(addressJsonObject, 'Contact No.');
                //Start: Geo
                // if addressJsonObject.Get('geo', geoJsonToken) then begin
                //     if geoJsonToken.IsObject then begin
                //         geoJsonObject := geoJsonToken.AsObject();
                //         recJPUser.lat := json_Methods.GetJsonValueAsText(geoJsonObject, 'lat');
                //         recJPUser.lng := json_Methods.GetJsonValueAsText(geoJsonObject, 'lng');
                //     end;
                // end;
                // Stop: Geo
            end;
        end;
        // Stop: Get Address Details

        recJPUser."Contact No." := json_Methods.GetJsonValueAsText(userInfoJsonObject, 'Contact No.');
        // recJPUser.website := json_Methods.GetJsonValueAsText(userInfoJsonObject, 'website');

        // Start: Company Details
        // if userInfoJsonObject.Get('company', companyJsonToken) then begin
        //     if companyJsonToken.IsObject then begin
        //         companyJsonObject := companyJsonToken.AsObject();
        //         recJPUser.companyName := json_Methods.GetJsonValueAsText(companyJsonObject, 'name');
        //         recJPUser.companyCatchPhrase := json_Methods.GetJsonValueAsText(companyJsonObject,
        //           'catchPhrase');
        //         recJPUser.companyBS := json_Methods.GetJsonValueAsText(companyJsonObject, 'bs');
        //     end;
        // end;
        // Stop: Company Details
        recJPUser.Insert();
    end;
}
