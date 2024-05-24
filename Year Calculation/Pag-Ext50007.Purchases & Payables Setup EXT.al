pageextension 50007 "Purchases & Payables Setup EXT" extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Discount Posting")
        {
            field(Year; Rec.Year)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Vendor Posting Groups")
        {
            action("Year Calculation")
            {
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                var
                    intval: Integer;
                    MYName: Text;
                    Year: Integer;
                begin
                    Evaluate(intval, DelChr(Format(Rec.Year), '=', 'Y,M,D'));
                    MYName := DelChr(Format(Rec.Year), '=', Format(intval));
                    if MYName = 'Y' then begin
                        Year := Date2DMY(Today, 3);
                        Year += intval;
                        Message('%1 Years', Year);
                    end else if MYName = 'M' then begin
                        Year := Date2DMY(Today, 2);
                        Year += intval;
                        Message('%1 Months', Year);
                    end else begin
                        Year := Date2DMY(Today, 1);
                        Year += intval;
                        Message('%1 Days', Year);
                    end;
                    Evaluate(intval, DelChr(Format(Rec.Year), '=', 'Y,M'));
                    MYName := DelChr(Format(Rec.Year), '=', Format(intval));
                    if MYName = 'Y' then begin
                        intval += 1;
                        Message('%1', GetNum(intval) + ' Year');
                    end else begin
                        Message('One Year and %1', GetNum(intval) + ' Month');
                    end;
                end;
            }
        }
    }
    procedure GetNum(Value: Integer): Text
    begin
        case Value of
            1:
                exit('One');
            2:
                exit('Two');
            3:
                exit('Three');
            4:
                exit('Four');
            5:
                exit('Five');
            6:
                exit('Six');
            7:
                exit('Seven');
            8:
                exit('Eight');
            9:
                exit('Nine');
            10:
                exit('Ten')
        end;
    end;
}
