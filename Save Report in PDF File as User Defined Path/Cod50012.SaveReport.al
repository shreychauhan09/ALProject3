// // using System.Security.User;
// // using Microsoft.Sales.Reports;
// // using Microsoft.Sales.Customer;

// codeunit 50012 "Save Report"
// {
//     procedure CheckSetup()
//     begin
//         UserSetup.GET(USERID);
//         UserSetup.TESTFIELD("Path to Save Report");
//     end;

//     procedure CustomerStatement(CustNo: Code[20])
//     begin
//         CheckSetup();
//         Customer.SETRANGE("No.", CustNo);
//         IF Customer.FINDFIRST THEN BEGIN

//             IF clear(File1) THEN CREATE(File1);
//             IF ISCLEAR(BullZipPDF) THEN CREATE(BullZipPDF);
//             IF NOT File1.FolderExists(UserSetup."Path to Save Report") THEN File1.CreateFolder(UserSetup."Path to Save Report");
//             Filename1 := UserSetup."Path to Save Report" + 'DayStatement' + '.pdf';
//             IF EXISTS(Filename1) THEN ERASE(Filename1);

//             BullZipPDF.Init;
//             BullZipPDF.LoadSettings;
//             RunOnceFile: BullZipPDF.GetSettings FileName(TRUE);
//             BullZipPDF.SetValue('Output', Filename1);
//             BullZipPDF.SetValue('Showsettings', 'never');
//             BullZipPDF.SetValue('ShowPDF', 'no');
//             BullZipPDF.SetValue('ShowProgress', 'no');
//             BullZipPDF.SetValue('ShowProgressFinished', 'no');
//             BullZipPDF.SetValue('SuppressErrors', 'yes');
//             BullZipPDF.SetValue('ConfirmOverwrite', 'no');
//             BullZipPDF.WriteSettings(TRUE);

//             SalesStat.SETTABLEVIEW(Customer);
//             SalesStat.UseRequestPage(FALSE);
//             SalesStat.RUNMODAL();
//             CLEAR(File1);
//             CLEAR(BullZipPDF);

//         end;
//     end;

//     var
//         // BullZipPDF: Automation 'Bullzip'.PDFPrinterSettings;

//         UserSetup: Record "User Setup";

//         Customer: Record Customer;

//         File1: Automation 'Microsoft Scripting Runtime'.FileSystemObject;

//         Filename1: Text[250];

//         RunOnceFile: Text[250];

//         SalesStat: Report "Sales Statistics";

// }
