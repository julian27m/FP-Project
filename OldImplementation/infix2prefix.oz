functor

import 
    System(showInfo:Show)

export 
    Str2Lst
    Infix2Prefix
define
    %% Split a string by spaces
    fun {Str2Lst Data}
        {String.tokens Data & }
    end

    %% Data is a list of the form ["(", "X", "+", "Y", ")"] and returns it in prefix form ["+" "X" "Y"]
    fun {Infix2Prefix Data}
        local Reverse Infix2Postfix in
            fun {Reverse Data Ans}
                case Data of H|T then
                    case H of "(" then
                        {Reverse T ")"|Ans}
                    []  ")" then
                        {Reverse T "("|Ans}
                    else
                        {Reverse T H|Ans}
                    end
                else
                    Ans
                end
            end
            fun {Infix2Postfix Data Stack Res}
                local PopWhile in
                    fun {PopWhile Stack Res Cond}
                        case Stack of H|T then
                            if {Cond H} then
                                {PopWhile T H|Res Cond}
                            else
                                [Res Stack]
                            end
                        else
                            [Res Stack]
                        end
                    end
                    case Data of H|T then
                        case H of "(" then
                            {Infix2Postfix T H|Stack Res}
                        [] ")" then
                            local H2 T2 T3 in
                                H2|T2|nil = {PopWhile Stack Res fun {$ X} {Not X=="("} end}
                                _|T3 = T2
                                {Infix2Postfix T T3 H2}
                            end 
                        [] "+" then
                            local H2 T2 in
                                H2|T2|nil = {PopWhile Stack Res fun {$ X} {List.member X ["*" "/"]} end}
                                {Infix2Postfix T H|T2 H2}
                            end
                        [] "-" then
                            local H2 T2 in
                                H2|T2|nil = {PopWhile Stack Res fun {$ X} {List.member X ["*" "/"]} end}
                                {Infix2Postfix T H|T2 H2}
                            end
                        [] "*" then
                            local H2 T2 in
                                H2|T2|nil = {PopWhile Stack Res fun {$ X} {List.member X nil} end}
                                {Infix2Postfix T H|T2 H2}
                            end
                        [] "/" then
                            local H2 T2 in
                                H2|T2|nil = {PopWhile Stack Res fun {$ X} {List.member X nil} end}
                                {Infix2Postfix T H|T2 H2}
                            end
                        else
                            {Infix2Postfix T Stack H|Res}
                        end
                    else 
                        Res
                    end
                end
            end
            {Infix2Postfix "("|{Reverse "("|Data nil} nil nil}
        end
    end
    %{Show {Infix2Prefix {Str2Lst "fun hola X Y Z = var A = X * Y var B = A + 2 in A * B + Z"}}}
    %    for Value in  {Infix2Prefix {Str2Lst "fun hola X Y Z = var A = X * Y var B = A + 2 in A * B + Z"}} do
    %        {Show Value}
    %    end

    %    {Show "\n\n\n"}
    %for Value2 in {Infix2Prefix {Str2Lst "( x * x + x )"}} do
    %    {Show Value2}
    %end


end

% x + x * 3 * 4
% 2 + 2 * 3 * 4


