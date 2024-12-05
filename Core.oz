functor
import
   System(showInfo:Show)
   StringTools(split:Split join:Join strip:Strip replace:Replace contains:Contains)
export
   Evaluator

define
   fun {MakeIndent Level Space}
      if Level == 0 then
         ""
      else
         {MakeIndent Level-1 Space}#Space
      end
   end

   proc {PrintIndentedNode Value Level}
      local Indent Space="  " in
         Indent = {MakeIndent Level Space}
         if Level == 0 then
            {Show Indent#{ListToString Value}}
         else
            {Show Indent#"|__"#{ListToString Value}}
         end
      end
   end

   proc {DisplayTree Tree Level}
      if Tree == nil then skip
      else 
         local Value Left Right in
            {Tree getValue(Value)}
            {Tree getLeft(Left)}
            {Tree getRight(Right)}
            {PrintIndentedNode {VirtualString.toString Value} Level}
            if Left \= nil then
               {DisplayTree Left Level+1}
            end
            if Right \= nil then
               {DisplayTree Right Level+1}
            end
         end
      end
   end

   fun {ListToString List}
      if {IsVirtualString List} then
         {VirtualString.toString List}
      else
         {VirtualString.toString {List.map List fun {$ C} [C] end}}
      end
   end

   fun {GetTreeValue Tree}
      if Tree == nil then
         ""
      else
         local Value Left Right in
            {Tree getValue(Value)}
            if Value == "@" then
               {Tree getLeft(Left)}
               {Tree getRight(Right)}
               if Left == nil andthen Right == nil then
                  ""
               else
                  local LeftVal RightVal in
                     LeftVal = {GetTreeValue Left}
                     RightVal = {GetTreeValue Right}
                     if LeftVal == "" then
                        RightVal
                     else
                        Value#" ["#LeftVal#" "#RightVal#"]"
                     end
                  end
               end
            else
               Value
            end
         end
      end
   end

   class Node
      attr value left right
      
      meth init(Value)
         value := Value
         left := nil
         right := nil
      end

      meth getValue(?RetVal) 
         RetVal = @value 
      end
      
      meth setValue(V) 
         value := V 
      end
      
      meth getLeft(?RetVal) 
         RetVal = @left 
      end
      
      meth getRight(?RetVal) 
         RetVal = @right 
      end
      
      meth setLeft(N) 
         left := N 
      end
      
      meth setRight(N) 
         right := N 
      end
   end

   class Evaluator
      attr functions currentTree

      meth init(Program)
         functions := {Dictionary.new}
         currentTree := nil
         {Show "\n=== Starting Hummingbird Execution ===\n"}
         {self parseProgram(Program)}
      end

      meth parseProgram(Program)
         for Line in Program do
            local CleanLine in
               CleanLine = {VirtualString.toString {Strip Line " "}}
               if {Length CleanLine} > 0 then
                  local LineType in
                     {self getLineType(CleanLine LineType)}
                     {Show "Processing line: "#{VirtualString.toString CleanLine}#" as "#{VirtualString.toString LineType}}
                     case LineType
                     of func then
                        {self parseFunction(CleanLine)}
                     [] app then
                        local NewTree in
                           {self parseApplication(CleanLine NewTree)}
                           currentTree := NewTree
                           {self evaluate}
                        end
                     end
                  end
               end
            end
         end
      end

      meth getLineType(Line ?Type)
         if {Contains {VirtualString.toString Line} "fun "} then 
            Type = func
         else 
            Type = app 
         end
      end

      meth parseFunction(Line)
         local Name Args Body in
            {self extractFunction(Line Name Args Body)}
            % Convert the name to an atom before using as dictionary key
            local FuncName in
               FuncName = {VirtualString.toAtom Name}
               {Dictionary.put @functions FuncName 
                  o(args:Args
                    body:Body)}
               {Show "Added function: "#{VirtualString.toString Name}#" to dictionary"}
            end
         end
      end

      meth extractFunction(Line ?Name ?Args ?Body)
         local Parts RawDefPart in
            % Split into definition and body parts around '='
            Parts = {Split Line "="}
            RawDefPart = {Nth Parts 1}
            
            % Process definition part (remove 'fun' and split into name/args)
            local DefStr DefParts in
               DefStr = {Strip {Replace RawDefPart "fun" ""} " "}
               DefParts = {Split DefStr " "}
               Name = {VirtualString.toString {Nth DefParts 1}}
               Args = {Map {List.drop DefParts 1} VirtualString.toString}
               Body = {Strip {Nth Parts 2} " "}
               
               % Debug output with proper string conversion
               {Show "Function Definition:"}
               {Show "  Name: "#{VirtualString.toString Name}}
               {Show "  Args: "#{VirtualString.toString {Join Args " "}}}
               {Show "  Body: "#{VirtualString.toString Body}}
            end
         end
      end
      
      meth parseApplication(Line ?Root)
         Root = {New Node init("@")}
         local Parts in
            Parts = {Filter {Split Line " "} fun {$ P} {Length P} > 0 end}
            if {Length Parts} == 2 then  % Simple function application
               local Name Arg in
                  Name = {Nth Parts 1}
                  Arg = {Nth Parts 2}
                  {Root setLeft({New Node init(Name)})}
                  {Root setRight({New Node init(Arg)})}
               end
            else
               {self buildApplicationTree(Root Parts)}
            end
         end
      end

      meth parseFunctionBody(Parts Root)
         % Parse function body into appropriate tree structure
         case Parts
         of ["fun" Name Arg "=" Op Arg1 Arg2] then
            local OpNode in
               OpNode = {New Node init("@")}
               {OpNode setLeft({New Node init(Op)})}
               local ArgsNode in
                  ArgsNode = {New Node init("@")}
                  {ArgsNode setLeft({New Node init(Arg1)})}
                  {ArgsNode setRight({New Node init(Arg2)})}
                  {OpNode setRight(ArgsNode)}
               end
               {Root setLeft({New Node init(Name)})}
               {Root setRight(OpNode)}
            end
         end
      end
      
      meth buildApplicationTree(Root Parts)
         case Parts
         of nil then skip
         [] [Value] then
            local IsNum in
               {self isNumeric(Value IsNum)}
               if IsNum then
                  {Root setRight({New Node init(Value)})}
               else
                  {Root setLeft({New Node init({VirtualString.toString Value})})}
               end
            end
         [] Name|Args then
            {Root setLeft({New Node init({VirtualString.toString Name})})}
            if Args \= nil then
               local RightNode in
                  RightNode = {New Node init("@")}
                  {Root setRight(RightNode)}
                  {self buildApplicationTree(RightNode Args)}
               end
            end
         end
      end

      meth debug(Msg)
         {Show Msg}
      end

      meth isNumeric(Str ?Result)
         try
            _ = {String.toInt {VirtualString.toString Str}}
            Result = true
         catch _ then
            Result = false
         end
      end
      
      


      meth evaluate()
         local Redex in
            {Show "\nCurrent Expression Tree:"}
            {DisplayTree @currentTree 0}
            {self findOutermostRedex(@currentTree Redex)}
            if Redex \= nil then
               {self reduceExpression(Redex)}
               {self evaluate}
            else
               local Value in
                  {Show "\nFinal Tree:"}
                  {DisplayTree @currentTree 0}
                  {@currentTree getValue(Value)}
                  if Value \= "@" then
                     {Show "\nFinal Result: "#Value#"\n"}
                  end
               end
            end
         end
      end

      meth findOutermostRedex(Tree ?Result)
         if Tree == nil then
            Result = nil
         else
            local Left Value IsBuiltin in
               {Tree getLeft(Left)}
               if Left == nil then
                  Result = nil
               else
                  {Left getValue(Value)}
                  % Convert value to atom for dictionary lookup
                  Value = {VirtualString.toAtom {VirtualString.toString Value}}
                  {self isBuiltinOperation(Value IsBuiltin)}
                  if IsBuiltin orelse {Dictionary.member @functions Value} then
                     Result = Tree
                  else
                     local Right in
                        {Tree getRight(Right)}
                        {self findOutermostRedex(Right Result)}
                     end
                  end
               end
            end
         end
      end
      
      

      meth isBuiltinOperation(Op ?Result)
         Result = {Member Op ['+' '-' '*' '/']}
      end

      meth reduceExpression(Tree)
         local Left Right Value IsBuiltin in
            {Tree getLeft(Left)}
            {Tree getRight(Right)}
            {Left getValue(Value)}
            {self isBuiltinOperation(Value IsBuiltin)}
            if IsBuiltin then
               {self evaluateBuiltin(Tree Value)}
            else
               {self instantiateTemplate(Tree Value)}
            end
         end
      end

      meth instantiateTemplate(Tree FuncName)
         local Func Right Args in
            Func = {Dictionary.condGet @functions FuncName nil}
            {Tree getRight(Right)}
            case Func
            of nil then skip
            else
               {self collectArgs(Right Args)}
               local NewTree in
                  {self instantiateBody(Func.body Args Func.args NewTree)}
                  {self replaceNode(Tree NewTree)}
               end
            end
         end
      end

      meth collectArgs(Tree ?Args)
         if Tree == nil then 
            Args = nil
         else 
            local Value Right NewAcc in
               {Tree getValue(Value)}
               {Tree getRight(Right)}
               if Value == "@" then
                  {self collectArgs(Right Args)}
               else
                  {self collectArgs(Right NewAcc)}
                  Args = {Append NewAcc [Value]}
               end
            end
         end
      end
      
      meth instantiateBody(BodyTree Args FormalArgs ?Result)
         if BodyTree == nil then 
            Result = nil
         else
            local NewNode Value Left Right in
               {BodyTree getValue(Value)}
               NewNode = {New Node init(Value)}
               
               % Substitute arguments
               if {Member Value FormalArgs} then
                  local Index in
                     Index = {List.position FormalArgs Value}
                     {NewNode setValue({Nth Args Index})}
                  end
               end
               
               % Recursively instantiate children
               {BodyTree getLeft(Left)}
               {BodyTree getRight(Right)}
               local LeftResult RightResult in
                  {self instantiateBody(Left Args FormalArgs LeftResult)}
                  {self instantiateBody(Right Args FormalArgs RightResult)}
                  {NewNode setLeft(LeftResult)}
                  {NewNode setRight(RightResult)}
               end
               Result = NewNode
            end
         end
      end

      meth evaluateBuiltin(Tree Op)
         local Right LeftArg RightArg Result in
            {Tree getRight(Right)}
            % Get argument values
            {Right getLeft(LeftArg)}
            {Right getRight(RightArg)}
            
            if LeftArg == nil orelse RightArg == nil then
               skip % Not enough arguments
            else
               local LeftVal RightVal in
                  {LeftArg getValue(LeftVal)}
                  {RightArg getValue(RightVal)}
                  if {String.isInt LeftVal} andthen {String.isInt RightVal} then
                     {self calculate(Op LeftVal RightVal Result)}
                     % Update tree with result
                     {Tree setValue({Int.toString Result})}
                     {Tree setLeft(nil)}
                     {Tree setRight(nil)}
                  end
               end
            end
         end
      end


      meth calculate(Op Left Right ?Result)
         case Op
         of "+" then Result = {String.toInt Left} + {String.toInt Right}
         [] "-" then Result = {String.toInt Left} - {String.toInt Right} 
         [] "*" then Result = {String.toInt Left} * {String.toInt Right}
         [] "/" then Result = {String.toInt Left} div {String.toInt Right}
         else Result = 0
         end
      end

      meth replaceNode(Old New)
         if New == nil then skip
         else
            local Value Left Right in
               {New getValue(Value)}
               {New getLeft(Left)}
               {New getRight(Right)}
               {Old setValue(Value)}
               {Old setLeft(Left)}
               {Old setRight(Right)}
            end
         end
      end

      meth buildBodyTree(Body ?Root)
         local Parts in
            Parts = {Split Body " "}
            case Parts
            of [Single] then
               Root = {New Node init(Single)}
            [] Op|Rest then
               Root = {New Node init("@")}
               {Root setLeft({New Node init(Op)})}
               local SubTree in
                  {self buildBodyTree({Join Rest " "} SubTree)}
                  {Root setRight(SubTree)}
               end
            else
               Root = nil
            end
         end
      end
   end
end