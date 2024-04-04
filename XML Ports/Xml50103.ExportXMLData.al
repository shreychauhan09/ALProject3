xmlport 50103 ExportXMLData
{
    Caption = 'ExportXMLData';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = true;
    FieldSeparator = ',';
    FieldDelimiter = '"';
    TableSeparator = '<NewLine>';
    RecordSeparator = '<NewLine>';
    DefaultFieldsValidation = true;
    FormatEvaluate = Legacy;
    TransactionType = Report;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(Integer; Integer)
            {
                XmlName = 'XMLHeader';
                SourceTableView = SORTING(Number) WHERE(Number = CONST(1));
                textelement(XMLDataNoTitle)
                {
                    trigger OnBeforePassVariable()
                    begin
                        XMLDataNoTitle := XMLData.FieldCaption(AreaCode);
                    end;
                }
                textelement(XMLDataDescTitle)
                {
                    trigger OnBeforePassVariable()
                    begin
                        XMLDataDescTitle := XMLData.FieldCaption(City);
                    end;
                }
                textelement(ItemTypeTitle)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ItemTypeTitle := XMLData.FieldCaption(Company);
                    end;
                }
                textelement(ItemInventoryTitle)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ItemInventoryTitle := XMLData.FieldCaption(FirstName);
                    end;
                }
                textelement(ItemBaseUnitofMeasureTitle)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ItemBaseUnitofMeasureTitle := XMLData.FieldCaption(LastName);
                    end;
                }
                textelement(ItemUnitCostTitle)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ItemUnitCostTitle := XMLData.FieldCaption(Phone);
                    end;
                }
                textelement(ItemUnitPriceTitle)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ItemUnitPriceTitle := XMLData.FieldCaption(RowID);
                    end;
                }
                textelement(ItemVendorNoTitle)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ItemVendorNoTitle := XMLData.FieldCaption(State);
                    end;
                }
                textelement(StreetName)
                {
                    trigger OnBeforePassVariable()
                    begin
                        StreetName := XMLData.FieldCaption(StreetName)
                    end;
                }
                textelement(zip)
                {
                    trigger OnBeforePassVariable()
                    begin
                        zip := XMLData.FieldCaption(Zip)
                    end;
                }
            }
            tableelement(XMLData; "XML Data")
            {
                RequestFilterFields = FirstName;
                fieldelement(AreaCode; XMLData.AreaCode)
                {
                }
                fieldelement(City; XMLData.City)
                {
                }
                fieldelement(Company; XMLData.Company)
                {
                }
                fieldelement(FirstName; XMLData.FirstName)
                {
                }
                fieldelement(LastName; XMLData.LastName)
                {
                }
                fieldelement(Phone; XMLData.Phone)
                {
                }
                fieldelement(RowID; XMLData.RowID)
                {
                }
                fieldelement(State; XMLData.State)
                {
                }
                fieldelement(StreetName; XMLData.StreetName)
                {
                }
                fieldelement(Zip; XMLData.Zip)
                {
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
