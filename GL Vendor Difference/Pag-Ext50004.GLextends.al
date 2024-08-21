// pageextension 50004 "GL extends" extends "General Ledger Entries"
// {
//     actions
//     {
//         addafter("Ent&ry")
//         {
//             action("GL Vendor")
//             {
//                 ApplicationArea = All;
//                 Caption = 'GL Vendor Difference';
//                 Image = Open;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 trigger OnAction()
//                 var
//                     GLV: Record "GL Vendor Difference";
//                     VLE: Record "Vendor Ledger Entry";
//                     GLE: Record "G/L Entry";
//                 begin
//                     // InitGLV(Rec);
//                     if Rec.FindSet() then
//                         repeat
//                             VLE.Reset();
//                             VLE.SetRange("Entry No.", Rec."Entry No.");
//                             VLE.SetRange("Document No.", Rec."Document No.");
//                             if VLE.FindSet() then
//                                 repeat
//                                     VLE.CalcFields("Amount (LCY)");
//                                     if VLE."Amount (LCY)" <> Rec.Amount then begin
//                                         GLV.Init;
//                                         GLV."Entry No." := VLE."Entry No.";
//                                         GLV."Document No." := VLE."Document No.";
//                                         // GLV."GLE Amount" := Rec.Amount;
//                                         GLV."VLE Amount (LCY)" := VLE."Amount (LCY)";
//                                         GLV.Insert;
//                                         Commit;
//                                         GLE.Reset();
//                                         GLE.SetRange("Entry No.", VLE."Entry No.");
//                                         GLE.SetRange("Document No.", VLE."Document No.");
//                                         if GLE.FindFirst() then begin
//                                             GLV."GLE Amount" := GLE.Amount;
//                                             GLV.Modify();
//                                         end;
//                                     end;
//                                 until VLE.Next() = 0;
//                         until Rec.Next() = 0;
//                     Page.Run(50001, GLV);
//                 end;
//             }
//         }
//     }
// }
