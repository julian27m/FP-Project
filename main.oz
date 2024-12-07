functor 
import 
   System(showInfo:Show)
   Open
   StringTools(split:Split join:Join strip:Strip replace:Replace contains:Contains)
   Core(evaluator:Evaluator)
   
define 
   fun {ReadProgram Path}
      {Show "\nReading program from: "#Path}
      local File Program in
         File = {New Open.file init(name:Path flags:[read])}
         {File read(list:Program)}
         {Filter {Split Program "\n"} 
          fun {$ Line} 
             {Length Line} > 0 andthen 
             {Nth Line 1} \= '#'
          end}
      end
   end

   proc {RunProgram Path}
      local Program Eval in
         Program = {ReadProgram Path}
         {Show "\nProgram contents:"}
         for Line in Program do
            {Show "  "#Line}
         end
         {Show "\n=== Beginning Evaluation ===\n"}
         Eval = {New Core.evaluator init(Program)}
      end
   end

   {RunProgram "Example1_square.hb"}
   %{RunProgram "Example2_twice.hb"}
   %{RunProgram "Example3_substraction.hb"}
   %{RunProgram "Example4_div.hb"}
end