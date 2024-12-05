functor

export
    FullFillFromCallBack

import

    System(showInfo:Show)

define
    class Node
        attr value left right
        meth init(Value)
            value := Value
            left := nil
            right := nil
        end

        meth getValue(ReturnValue)
            ReturnValue = @value
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
    end

    proc {FullFillFromCallBack CallBack}
        local RootTree Elements in
            Elements = {String.tokens CallBack " "}
            RootTree = {New Node init(Elements[1])}
            if {Length Elements} > 1 then
                {RootTree setLeft({New Node init(Elements[2])})}
                {RootTree setRight({New Node init(Elements[3])})}
            end
            
            {PrintTree RootTree}
        end
    end

    proc {PrintTree Root}
        if Root == nil then
            {Show "There is nothing to print"}
        else
            {BuildTree2 Root "" ""}
        end
    end

    proc {BuildTree2 Root Prefix Symbol}
        local Value RightNode LeftNode in
            {Root getValue(Value)}
            {Root getLeft(LeftNode)}
            {Root getRight(RightNode)}
            
            {Show Prefix ++ Symbol ++ Value}

            if (LeftNode == nil) == false then
                {BuildTree2 LeftNode Prefix ++ " " "|-"}  
            end
            if (RightNode == nil) == false then
                {BuildTree2 RightNode Prefix ++ " " "|_"}  
            end
        end
    end
end