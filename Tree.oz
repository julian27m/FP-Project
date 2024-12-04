functor

export
    FullFillFromCallBack

import

    System(showInfo:Show)
    StringJ(join:Join split:Split)

define
    class Node
        attr value left right functionName
        meth init(Value)
            value := Value
            left := nil
            right := nil
            functionName := Value
        end

        meth getValue(ReturnValue)
            ReturnValue = @value
        end

        meth setValue(NewValue)
            value := NewValue
        end

        meth setLeft(Node)
            left := Node
        end

        meth setRight(Node)
            right := Node
        end

        meth getLeft(ReturnNode)
            ReturnNode = @left
        end

        meth getRight(ReturnRight)
            ReturnRight = @right
        end
        meth setFunctionName(FunctionName)
            functionName := FunctionName
        end

        meth getFunctionName(Return)
            Return = @functionName
        end
    end

    proc {Test}
        local RootNode LeftNode RightNode LeftSubRightNode RightSubLeftNode SubRightSubLeftNode SubRightSubRightNode LeftSubLeftNode in
            RootNode = {New Node init("@")}
            LeftNode = {New Node init("@")}
            RightNode = {New Node init("5")}
            RightSubLeftNode = {New Node init("@")}
            LeftSubLeftNode = {New Node init("*")}
            SubRightSubLeftNode = {New Node init("X")}
            SubRightSubRightNode = {New Node init("X")}

            {RootNode setLeft(LeftNode)}
            {RootNode setRight(RightNode)}
            {LeftNode setLeft(LeftSubLeftNode)}
            {LeftNode setRight(RightSubLeftNode)}
            {RightSubLeftNode setLeft(SubRightSubLeftNode)}
            {RightSubLeftNode setRight(SubRightSubRightNode)}
            {PrintTree RootNode}
            {Show "past from here"}
        end
    end
    

    fun {MultiString Character Acu Times}
        if {Length Acu} < Times then
            {MultiString Character {Join [Character Acu] ""} Times}
        else
            Acu
        end
    end

    proc {FullFillFromCallBack CallBack}
        local RootTree in
            if {Length {Split CallBack " "}} > 1 then Elements LNode RNode in
                Elements = {Split CallBack " "}
                RootTree = {New Node init("@")}
                LNode = {New Node init({Nth Elements 1})}
                {RootTree setLeft(LNode)}
                RNode = {New Node init({Nth Elements 2})}
                {RootTree setRight(RNode)}
            else
                RootTree = {New Node init(CallBack)}
            end
            
            {PrintTree RootTree}
        end
    end

    proc {PrintTree Root}    
        if Root == nil then
            {Show "There is nothing to print"}
        else
            {BuildTree2 Root 1 "" ""}
        end
    end

    proc {BuildTree2 Root Level Prefix Symbol}
        local Value RightNode LeftNode ValueLenght in
            {Root getValue(Value)}
            ValueLenght = {Length Value}
            {Root getLeft(LeftNode)}
            {Root getRight(RightNode)}
            
            if Level == 1 then
                {Show {Join [Symbol Value] ""}}
            else 
                if Prefix == nil then
                    {Show {Join [Symbol Value] ""}}
                else
                    {Show {Join [Prefix Symbol Value] ""}}
                end
            end

            if (LeftNode == nil) == false then
                if Level == 1 then
                    {BuildTree2 LeftNode (Level + 1) Prefix "|-"}  
                else
                    {BuildTree2 LeftNode (Level + 1) ({Join [Prefix " " {MultiString " " " " (ValueLenght)}] ""}) "|_"}  
                end                
            end
            if (RightNode == nil) == false then
                if Level == 1 then
                    {BuildTree2 RightNode (Level + 1) Prefix "|_"}
                else
                    {BuildTree2 RightNode (Level + 1) ({Join [Prefix " " {MultiString " " " " (ValueLenght)}] ""}) "|_"}  
                end
            end
        end
    end

   % {Test}
end
