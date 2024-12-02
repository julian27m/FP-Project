functor

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

        meth getValue(Return)
            Return = @value
        end

        meth setRight(RightNode)
            right := RightNode
        end

        meth getRight(Return)
            Return = @right
        end

        meth setLeft(LeftNode)
            left := LeftNode
        end

        meth getLeft(Return)
            Return = @left
        end
    end

    proc {Test}
        local RootNode LeftNode RightNode LeftSubRightNode RightSubLeftNode in
            RootNode = {New Node init("@")}
            LeftNode = {New Node init("*")}
            RightNode = {New Node init("@")}
            LeftSubRightNode = {New Node init("2")}
            RightSubLeftNode = {New Node init("3")}

            {RootNode setLeft(LeftNode)}
            {RootNode setRight(RightNode)}
            {RightNode setLeft(LeftSubRightNode)}
            {RightNode setRight(RightSubLeftNode)}
            {PrintTree RootNode 0 ""}
        end
    end

    fun {MakeIndentation Level}
        if Level == 0 then
            ""
        else
            "    "#({MakeIndentation Level - 1})
        end
    end

    proc {PrintConnections Level}
        {Show {MakeIndentation Level}# " |"}
    end

    proc {PrintTree RootNode Level Prefix}
        if (RootNode == nil) == false then
            local Value RightNode LeftNode Indentation in
                {RootNode getValue(Value)}

                Indentation = {MakeIndentation Level}
                
                {Show Indentation#Prefix#"+--"#Value}

                {RootNode getLeft(LeftNode)}
                {RootNode getRight(RightNode)}

                if (LeftNode \= nil) orelse (RightNode \= nil) then
                    {PrintConnections Level}
                end

                {PrintTree LeftNode (Level+1) "|-- "}
                {PrintTree RightNode (Level+1) "    +--"}
            end
        end
    end

    {Test}
end
