// pageextension 50008 "Sales Order Extend" extends "Sales Order"
// {
//     actions
//     {
//         addafter("P&osting")
//         {
//             action(SetShipToOptions)
//             {
//                 ApplicationArea = All;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 Image = SetPriorities;
//                 Caption = 'Set Ship To Options';

//                 trigger OnAction()
//                 var
//                     Selected: Integer;
//                 begin
//                     Selected := 0;
//                     Selected := StrMenu('Default (Sell-to Address),Alternate Shipping Address,Custom Address', 0, 'Select Ship To Options');
//                     case Selected of
//                         1:
//                             Rec.Validate("Ship-to Code", '');

//                         2:
//                             Rec.Validate("Ship-to Code", 'FLEET');
//                         3:
//                             begin
//                                 Rec.Validate("Ship-to Code", '');
//                                 Rec.Validate("Ship-to Name", 'Custom Ship To Name');
//                             end;
//                     end;
//                 end;
//             }
//         }
//     }
// }
