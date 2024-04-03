xmlport 50103 ExportXMLData
{
    Caption = 'ExportXMLData';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    TableSeparator = '';
    RecordSeparator = '';
    FieldSeparator = ',';
    FieldDelimiter = '"';
    DefaultFieldsValidation = true;
    FormatEvaluate = Legacy;
    // TransactionType = Update;
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
                        // ItemTypeTitle := Item.FieldCaption(Type);
                    end;
                }
                textelement(ItemInventoryTitle)
                {
                    trigger OnBeforePassVariable()
                    begin
                        // ItemInventoryTitle := Item.FieldCaption(Inventory);
                    end;
                }
                textelement(ItemBaseUnitofMeasureTitle)
                {
                    trigger OnBeforePassVariable()
                    begin
                        // ItemBaseUnitofMeasureTitle := Item.FieldCaption("Base Unit of Measure");
                    end;
                }
                textelement(ItemBaseCostisAdjustedTitle)
                {
                    trigger OnBeforePassVariable()
                    begin
                        // ItemBaseCostisAdjustedTitle := Item.FieldCaption("Cost is Adjusted");
                    end;
                }
                textelement(ItemUnitCostTitle)
                {
                    trigger OnBeforePassVariable()
                    begin
                        // ItemUnitCostTitle := Item.FieldCaption("Unit Cost");
                    end;
                }
                textelement(ItemUnitPriceTitle)
                {
                    trigger OnBeforePassVariable()
                    begin
                        // ItemUnitPriceTitle := Item.FieldCaption("Unit Price");
                    end;
                }
                textelement(ItemVendorNoTitle)
                {
                    trigger OnBeforePassVariable()
                    begin
                        // ItemVendorNoTitle := Item.FieldCaption("Vendor No.");
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
                fieldelement(StreetNumber; XMLData.StreetNumber)
                {
                }
                fieldelement(Suffix; XMLData.Suffix)
                {
                }
                fieldelement(SystemCreatedAt; XMLData.SystemCreatedAt)
                {
                }
                fieldelement(SystemCreatedBy; XMLData.SystemCreatedBy)
                {
                }
                fieldelement(SystemId; XMLData.SystemId)
                {
                }
                fieldelement(SystemModifiedAt; XMLData.SystemModifiedAt)
                {
                }
                fieldelement(SystemModifiedBy; XMLData.SystemModifiedBy)
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
