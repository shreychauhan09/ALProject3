page 50223 "Bom Cost Share Page"
{
    ApplicationArea = All;
    Caption = 'Bom Cost Share Page';
    PageType = List;
    SourceTable = "Bom Cost Share Table";
    UsageCategory = Documents;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Able to Make Parent"; Rec."Able to Make Parent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Able to Make Parent field.';
                }
                field("Able to Make Top Item"; Rec."Able to Make Top Item")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Able to Make Top Item field.';
                }
                field("Available Quantity"; Rec."Available Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Available Quantity field.';
                }
                field("BOM Unit of Measure Code"; Rec."BOM Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BOM Unit of Measure Code field.';
                }
                field(Bottleneck; Rec.Bottleneck)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bottleneck field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Gross Requirement"; Rec."Gross Requirement")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gross Requirement field.';
                }
                field(Indentation; Rec.Indentation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Indentation field.';
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Indirect Cost % field.';
                }
                field(Inventoriable; Rec.Inventoriable)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inventoriable field.';
                }
                field("Is Leaf"; Rec."Is Leaf")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Is Leaf field.';
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lead Time Calculation field.';
                }
                field("Lead-Time Offset"; Rec."Lead-Time Offset")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lead-Time Offset field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Lot Size"; Rec."Lot Size")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lot Size field.';
                }
                field("Low-Level Code"; Rec."Low-Level Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Low-Level Code field.';
                }
                field("Needed by Date"; Rec."Needed by Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Needed by Date field.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Overhead Rate"; Rec."Overhead Rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Overhead Rate field.';
                }
                field("Production BOM No."; Rec."Production BOM No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Production BOM No. field.';
                }
                field("Qty. per BOM Line"; Rec."Qty. per BOM Line")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty. per BOM Line field.';
                }
                field("Qty. per Parent"; Rec."Qty. per Parent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty. per Parent field.';
                }
                field("Qty. per Top Item"; Rec."Qty. per Top Item")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty. per Top Item field.';
                }
                field("Replenishment System"; Rec."Replenishment System")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Replenishment System field.';
                }
                field("Resource Usage Type"; Rec."Resource Usage Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Resource Usage Type field.';
                }
                field("Rolled-up Capacity Cost"; Rec."Rolled-up Capacity Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rolled-up Capacity Cost field.';
                }
                field("Rolled-up Capacity Ovhd. Cost"; Rec."Rolled-up Capacity Ovhd. Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rolled-up Capacity Ovhd. Cost field.';
                }
                field("Rolled-up Lead-Time Offset"; Rec."Rolled-up Lead-Time Offset")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rolled-up Lead-Time Offset field.';
                }
                field("Rolled-up Material Cost"; Rec."Rolled-up Material Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rolled-up Material Cost field.';
                }
                field("Rolled-up Mfg. Ovhd Cost"; Rec."Rolled-up Mfg. Ovhd Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rolled-up Mfg. Ovhd Cost field.';
                }
                field("Rolled-up Scrap Cost"; Rec."Rolled-up Scrap Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rolled-up Scrap Cost field.';
                }
                field("Rolled-up Subcontracted Cost"; Rec."Rolled-up Subcontracted Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rolled-up Subcontracted Cost field.';
                }
                field("Rounding Precision"; Rec."Rounding Precision")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rounding Precision field.';
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Routing No. field.';
                }
                field("Safety Lead Time"; Rec."Safety Lead Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Safety Lead Time field.';
                }
                field("Scheduled Receipts"; Rec."Scheduled Receipts")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Scheduled Receipts field.';
                }
                field("Scrap %"; Rec."Scrap %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Scrap % field.';
                }
                field("Scrap Qty. per Parent"; Rec."Scrap Qty. per Parent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Scrap Qty. per Parent field.';
                }
                field("Scrap Qty. per Top Item"; Rec."Scrap Qty. per Top Item")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Scrap Qty. per Top Item field.';
                }
                field("Single-Level Cap. Ovhd Cost"; Rec."Single-Level Cap. Ovhd Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Single-Level Cap. Ovhd Cost field.';
                }
                field("Single-Level Capacity Cost"; Rec."Single-Level Capacity Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Single-Level Capacity Cost field.';
                }
                field("Single-Level Material Cost"; Rec."Single-Level Material Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Single-Level Material Cost field.';
                }
                field("Single-Level Mfg. Ovhd Cost"; Rec."Single-Level Mfg. Ovhd Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Single-Level Mfg. Ovhd Cost field.';
                }
                field("Single-Level Scrap Cost"; Rec."Single-Level Scrap Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Single-Level Scrap Cost field.';
                }
                field("Single-Level Subcontrd. Cost"; Rec."Single-Level Subcontrd. Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Single-Level Subcontrd. Cost field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Cost field.';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Cost field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                }
                field("Unused Quantity"; Rec."Unused Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unused Quantity field.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Variant Code field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Cost Share Report")
            {
                ApplicationArea = All;
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    CostShareReport: Report "Cost Share Reports";
                    BomCostShareRec: Record "Bom Cost Share Table";
                begin
                    Clear(CostShareReport);
                    BomCostShareRec.Reset();
                    BomCostShareRec.SetRange("No.", Rec."No.");
                    CostShareReport.SetTableView(BomCostShareRec);
                    CostShareReport.RunModal();
                    // Report.RunModal(Report::"Cost Share Reports", true, false, BomCostShareRec);
                end;
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        BomCodeUnit: Codeunit "Bom Cost Share";
    begin
        BomCodeUnit.DelBomCostShare();
    end;
}
