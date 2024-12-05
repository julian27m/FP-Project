functor
export
   Make Length
   Split Join Strip Replace Contains
define
   Make = VirtualString.toString
   Length = List.length

   fun {Split S Sep}
      case S
      of nil then nil
      else 
         case Sep
         of nil then [S]
         else
            local
               fun {SplitLoop S Acc}
                  case S
                  of nil then [Acc]
                  [] H|T then
                     if H == Sep then
                        Acc|{SplitLoop T nil}
                     else
                        {SplitLoop T {Append Acc [H]}}
                     end
                  end
               end
            in
               {SplitLoop S nil}
            end
         end
      end
   end

   fun {Join L Sep}
      case L
      of nil then nil
      [] [H] then H
      [] H|T then
         {Append {Append H Sep} {Join T Sep}}
      end
   end

   fun {Strip S Char}
      case S
      of nil then nil
      [] H|T then
         if H == Char then
            {Strip T Char}
         else
            H|{Strip T Char}
         end
      end
   end

   fun {Replace S Old New}
      {Join {Split S Old} New}
   end

   fun {Contains S SubS}
      {Length {Split S SubS}} > 1
   end
end