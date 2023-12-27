/// <summary>
/// Codeunit API Handler (ID 60014).
/// </summary>
codeunit 60014 "API Handler"
{
    TableNo = "Custom API Table";

    trigger OnRun()
    begin

    end;

    /// <summary>
    /// GetJsonValue.
    /// </summary>
    /// <param name="json_Object">VAR JsonObject.</param>
    /// <param name="Property">Text.</param>
    /// <param name="json_Value">VAR JsonValue.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure GetJsonValue(var json_Object: JsonObject; Property: Text; var json_Value: JsonValue): Boolean
    var
        json_Token: JsonToken;
    begin
        if not json_Object.Get(Property, json_Token) then
            exit;
        json_Value := json_Token.AsValue();
        exit(true);
    end;

    /// <summary>
    /// GetJsonValueAsText.
    /// </summary>
    /// <param name="json_Object">VAR JsonObject.</param>
    /// <param name="Property">Text.</param>
    /// <returns>Return variable Value of type Text.</returns>
    procedure GetJsonValueAsText(var json_Object: JsonObject; Property: Text) Value: Text
    var
        json_Value: JsonValue;
    begin
        if not GetJsonValue(json_Object, Property, json_Value) then
            exit;
        Value := json_Value.AsText;
    end;

    /// <summary>
    /// GetJsonValueAsBoolean.
    /// </summary>
    /// <param name="json_Object">VAR JsonObject.</param>
    /// <param name="Property">Text.</param>
    /// <returns>Return variable Value of type Boolean.</returns>
    procedure GetJsonValueAsBoolean(var json_Object: JsonObject; Property: Text) Value: Boolean
    var
        json_Value: JsonValue;
    begin
        if not GetJsonValue(json_Object, Property, json_Value) then
            exit;
        Value := json_Value.AsBoolean();
    end;

    /// <summary>
    /// GetJsonValueAsInteger.
    /// </summary>
    /// <param name="json_Object">VAR JsonObject.</param>
    /// <param name="Property">Text.</param>
    /// <returns>Return variable Value of type Integer.</returns>
    procedure GetJsonValueAsInteger(var json_Object: JsonObject; Property: Text) Value: Integer
    var
        json_Value: JsonValue;
    begin
        if not GetJsonValue(json_Object, Property, json_Value) then
            exit;
        Value := json_Value.AsInteger();
    end;

    /// <summary>
    /// GetJsonValueAsDecimal.
    /// </summary>
    /// <param name="json_Object">VAR JsonObject.</param>
    /// <param name="Property">Text.</param>
    /// <returns>Return variable Value of type Decimal.</returns>
    procedure GetJsonValueAsDecimal(var json_Object: JsonObject; Property: Text) Value: Decimal
    var
        json_Value: JsonValue;
    begin
        if not GetJsonValue(json_Object, Property, json_Value) then
            exit;
        Value := json_Value.AsDecimal();
    end;

    /// <summary>
    /// GetJsonToken.
    /// </summary>
    /// <param name="json_Object">JsonObject.</param>
    /// <param name="tokenKey">Text.</param>
    /// <returns>Return variable json_Token of type JsonToken.</returns>
    procedure GetJsonToken(json_Object: JsonObject; tokenKey: Text) json_Token: JsonToken;
    begin
        if not json_Object.Get(tokenKey, json_Token) then
            Error('Token not found with key %1', tokenKey);
    end;

    /// <summary>
    /// SelectJsonToken.
    /// </summary>
    /// <param name="json_object">JsonObject.</param>
    /// <param name="path">Text.</param>
    /// <returns>Return variable json_Token of type JsonToken.</returns>
    procedure SelectJsonToken(json_object: JsonObject; path: Text) json_Token: JsonToken;
    begin
        if not json_object.SelectToken(path, json_Token) then
            Error('Token not found with path %1', path);
    end;
}
