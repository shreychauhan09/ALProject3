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
                    ChangedDate: Date;
                    Month: Integer;
                    Day: Integer;
                begin
                    Evaluate(intval, DelChr(Format(Rec.Year), '=', 'Y,M,D'));
                    MYName := DelChr(Format(Rec.Year), '=', Format(intval));
                    if MYName = 'Y' then begin
                        Year := Date2DMY(Today, 3);
                        Year += intval;
                        Evaluate(ChangedDate, Format((DMY2Date(Date2DMY(Today, 1), Date2DMY(Today, 2), Year))));
                        Message('%1', ChangedDate);
                    end else if MYName = 'M' then begin
                        // Year := Date2DMY(Today, 2);
                        // Year += intval;
                        // Evaluate(ChangedDate, Format((DMY2Date(Date2DMY(Today, 1), Year, Date2DMY(Today, 3)))));
                        // Message('%1', Format(ChangedDate, 0, '<Day,2> / <Month Text> / <Year>'));
                        // Month := Date2DMY(Today, 2);
                        // Month += intval;
                        // if Month > 12 then begin
                        //     Year := Date2DMY(Today, 3);
                        //     Year += Month div 12;
                        //     Month := Month mod 12;
                        //     if Month = 0 then begin
                        //         Month := 12;
                        //         Year -= 1;
                        //     end;
                        // end;
                        // ChangedDate := AddMonths(Today, intval);
                        Month := Date2DMY(Today, 2) + intval;
                        Year := Date2DMY(Today, 3);
                        while Month > 12 do begin
                            Month -= 12;
                            Year += 1;
                        end;
                        while Month < 1 do begin
                            Month += 12;
                            Year -= 1;
                        end;
                        ChangedDate := DMY2Date(Date2DMY(Today, 1), Month, Year);
                        Message('%1', Format(ChangedDate, 0, '<Day,2> / <Month Text> / <Year>'));
                    end else begin
                        // Year := Date2DMY(Today, 1);
                        // Year += intval;
                        // Day := Date2DMY(Today, 1);
                        // Day += intval;
                        // ChangedDate := IncDay(Today, Day);                        
                        // Evaluate(ChangedDate, Format((DMY2Date(Year, Date2DMY(Today, 2), Date2DMY(Today, 3)))));
                        // Message('%1', ChangedDate);
                        // Day := Date2DMY(Today, 1) + intval;
                        // Month := Date2DMY(Today, 2);
                        // Year := Date2DMY(Today, 3);
                        // while Day > 28 do begin
                        //     if (Month = 2) and ((Year mod 4 = 0) and ((Year mod 100 <> 0) or (Year mod 400 = 0))) then begin
                        //         if Day > 29 then begin
                        //             Day -= 29;
                        //             Month += 1;
                        //         end;
                        //     end else if ((Month = 4) or (Month = 6) or (Month = 9) or (Month = 11)) and (Day > 30) then begin
                        //         Day -= 30;
                        //         Month += 1;
                        //     end else if Day > 31 then begin
                        //         Day -= 31;
                        //         Month += 1;
                        //     end;
                        //     while Month > 12 do begin
                        //         Month -= 12;
                        //         Year += 1;
                        //     end;
                        //     while Month < 1 do begin
                        //         Month += 12;
                        //         Year -= 1;
                        //     end;
                        // end;
                        // ChangedDate := DMY2Date(Day, Month, Year);
                        // Message('%1', Format(ChangedDate));
                        ChangedDate := CalcDate('<-' + Format(Abs(intval)) + 'D', Today);
                        Message('%1', Format(ChangedDate));
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
