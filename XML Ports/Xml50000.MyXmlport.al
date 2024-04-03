xmlport 50100 MyXmlport
{
    Caption = 'Export Contacts to XML';
    Direction = Export;
    // Format = Xml;
    UseRequestPage = false;
    DefaultFieldsValidation = true;
    Format = VariableText;
    FieldSeparator = ',';
    FieldDelimiter = '"';
    TableSeparator = '<NewLine>';
    RecordSeparator = '<NewLine>';
    TextEncoding = UTF8;
    schema
    {
        textelement(Contacts)
        {
            XmlName = 'Contacts';
            tableelement(Integer; Integer)
            {
                XmlName = 'ContactHeader';

                SourceTableView = sorting(Number) where(Number = const(1));

                textelement(ContNoTitle)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ContNoTitle := Contact.FieldCaption("No.");
                    end;
                }
                textelement(ContNameTitle)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ContNameTitle := Contact.FieldCaption(Name);
                    end;
                }
                textelement("ContE-MailTitle")
                {
                    trigger OnBeforePassVariable()
                    begin
                        "ContE-MailTitle" := Contact.FieldCaption("E-Mail");
                    end;
                }
            }
            tableelement(Contact; Contact)
            {
                RequestFilterFields = "No.";
                XmlName = 'Contact';

                fieldattribute(No; Contact."No.")
                {
                }
                fieldattribute(ExternalID; Contact."External ID")
                {
                }
                fieldelement(Name; Contact.Name)
                {
                }
                fieldelement("E-Mail"; Contact."E-Mail")
                {
                }
                fieldelement(HomePage; Contact."Home Page")
                {
                }
                textelement(Company)
                {
                    XmlName = 'Company';

                    fieldattribute(CompanyNo; Contact."Company No.")
                    {
                    }
                    fieldelement(CompanyName; Contact."Company Name")
                    {
                        Width = 20;
                    }
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