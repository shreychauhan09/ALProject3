#pragma warning disable AL0679
query 50000 "APIV1 - Customer Sales"
#pragma warning restore AL0679
{
    QueryType = API;
    APIPublisher = 'contoso';
    APIGroup = 'app1';
    APIVersion = 'v2.0';
    Caption = 'customerSales', Locked = true;
    EntityName = 'customerSale';
    EntitySetName = 'customerSales';
    OrderBy = descending(Sum_Qty_Base);
    elements
    {
        dataitem(customer; Customer)
        {

            column(systemId; SystemId)
            {
                Caption = 'Id', Locked = true;
            }
            column(customerNumber; "No.")
            {
                Caption = 'No', Locked = true;
            }
            column(name; Name)
            {
                Caption = 'Name', Locked = true;
            }

            dataitem(custLedgEntry; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = Customer."No.";
                SqlJoinType = LeftOuterJoin;
                DataItemTableFilter = "Document Type" = filter(Invoice |
                                                               "Credit Memo");
                column(totalSalesAmount; "Sales (LCY)")
                {
                    Caption = 'TotalSalesAmount', Locked = true;
                    Method = Sum;
                }
                filter(dateFilter; "Posting Date")
                {
                    Caption = 'DateFilter', Locked = true;
                }
                dataitem(Location; Location)
                {
                    DataItemLink = Code = Customer."Location Code";
                    SqlJoinType = LeftOuterJoin;
                    dataitem(Warehouse_Entry; "Warehouse Entry")
                    {
                        DataItemLink = "Location Code" = Location.Code;
                        SqlJoinType = InnerJoin;

                        column(Sum_Qty_Base; "Qty. (Base)")
                        {
                            ColumnFilter = Sum_Qty_Base = filter(> 0);
                            Method = Sum;
                        }
                        filter(Item_No; "Item No.")
                        {
                        }
                        filter(Variant_Code; "Variant Code")
                        {
                        }
                        column(Location_Code; "Location Code")
                        {
                        }
                        dataitem(Bin_Type; "Bin Type")
                        {
                            DataItemLink = Code = Warehouse_Entry."Bin Type Code";
                            SqlJoinType = InnerJoin;
                            DataItemTableFilter = Receive = const(false),
                                          Ship = const(false),
                                          Pick = const(false);
                        }
                    }
                }
            }
        }
    }
    trigger OnBeforeOpen()
    begin
        CurrQuery.SetFilter(Sum_Qty_Base, '<>%1', 0);
    end;

    procedure GetTop10ProdOrdersXml()
    var
        Top10ProdOrders: Query "Top-10 Prod. Orders - by Cost";
        TempBlob: Codeunit "Temp Blob";
        FileNotSavedMsg: Label 'The file was not saved. The problem was %1';
        OutStr: OutStream;
        InStr: InStream;
        FileName: Text;
    begin
        TempBlob.CreateOutStream(OutStr);
        Top10ProdOrders.TopNumberOfRows(5);
        if not Top10ProdOrders.SaveAsXml(OutStr) then
            Error(FileNotSavedMsg, GetLastErrorText());

        TempBlob.CreateInStream(InStr);
        FileName := 'top_10_prod_orders.xml';
        File.DownloadFromStream(InStr, 'Top 10 Prod. Orders XML', '', '', FileName);
    end;
}