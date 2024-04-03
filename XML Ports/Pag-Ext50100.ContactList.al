pageextension 50100 ContactList extends "Contact List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addlast("F&unctions")
        {
            action(ExportContact)
            {
                ApplicationArea = All;
                Caption = 'Export Contact(s)';
                ToolTip = 'Export Contact(s)';
                Image = ExportContact;

                trigger OnAction()
                var
                    FileManagement: Codeunit "File Management";
                    TempBlob: Codeunit "Temp Blob";
                    XmlExportContact: XmlPort "Export Contact";
                    InStr: InStream;
                    OutStr: OutStream;
                    FileName: Text;
                begin
                    begin
                        FileName := 'ExportContacts.xml';

                        TempBlob.CreateOutStream(OutStr);
                        XmlExportContact.SetDestination(OutStr);
                        XmlExportContact.Export();

                        TempBlob.CreateInStream(InStr);
                        File.DownloadFromStream(InStr, 'Download XML Export', '',
                                                FileManagement.GetToFilterText('', FileName),
                                                FileName);
                    end;
                end;
            }
        }
    }
}