
%%%%%%%%%%% Codigo que nos dieron para el Proyecto

declare Env Str2Lst Parse ParseFun Infix2Prefix 

%% Split a string by spaces
fun {Str2Lst Data}
    {String.tokens Data & }
end

%% Data is a list of the form ["(", "X", "+", "Y", ")"] en returns id prefix form ["+" "X" "Y"]
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



%% /////////////////////////////////////////////////////////////////////////////
%%
%% It is necessary that every element in a program its separated by single space.  
%%
%% /////////////////////////////////////////////////////////////////////////////


{Show {Infix2Prefix {Str2Lst "fun hola X Y Z = var A = X * Y var B = A + 2 in A * B + Z"}}}

{Show {Infix2Prefix {Str2Lst "fun square x = x * x"}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





% CREAR EL ARBOL Y LOS NODOS

% Estructura base para nodos
fun {CrearNodo Tipo Valor Izq Der}

    nodo(

       tipo: Tipo
       valor: Valor
       izq: Izq
       der: Der

    )
 end
 
 fun {CrearAplicacion Izq Der}

    {CrearNodo aplicacion '@' Izq Der}
 end

 fun {CrearHoja Valor}
    {CrearNodo hoja Valor nil nil}
 end
 
 
 fun {CrearOperador Op Izq Der} 
    {CrearNodo operador Op Izq Der}
 end 
 


 % CONSTRUCCION DEL GRAFOO

 fun {ConstruirGrafo Programa}

    case Programa

    of nil then nil
    
    % Constantes 
    [] N|T andthen {IsNumber N} then
       {CrearHoja N}
    
    % Variables y nombres de funciones
    [] V|T andthen {IsAtom V} then
       {CrearHoja V}
    
   

    [] Op|Izq|Der|T andthen {Member Op ['+' '-' '*' '/']} then  %Operadores aritméticos 

       {CrearOperador Op {ConstruirGrafo Izq} {ConstruirGrafo Der}}
    
    %Aplicación de funciones
    [] '@'|Izq|Der|T then
       {CrearAplicacion {ConstruirGrafo Izq} {ConstruirGrafo Der}}
    
    %funciones
    [] 'fun'|Nombre|Args|'='|Cuerpo|T then
       {CrearNodo funcion Nombre {ConstruirGrafo Args} {ConstruirGrafo Cuerpo}}
    
    %Variables locales
    [] 'var'|Nombre|'='|Valor|'in'|Cuerpo|T then
       {CrearNodo variable Nombre {ConstruirGrafo Valor} {ConstruirGrafo Cuerpo}}
    
    else

       nil

    end
 end
 
 % COmo imprimir el grafoo
 fun {ImprimirGrafo Nodo}

    case Nodo

    of nil then ""

    [] nodo(tipo:Tipo valor:Valor izq:Izq der:Der) then
       "Nodo(" # Tipo # ":" # Valor # ")" #
       case Izq of nil then "" else " Izq:" # {ImprimirGrafo Izq} end #
       case Der of nil then "" else " Der:" # {ImprimirGrafo Der} end

    end

 end
 
 % PARA Probar el GRfo
 fun {Probar Entrada}

    local Tokens PrefixForm Grafo in

       Tokens = {Str2Lst Entrada}
       PrefixForm = {Infix2Prefix Tokens}
       Grafo = {ConstruirGrafo PrefixForm}
       {Show {ImprimirGrafo Grafo}}
       Grafo

    end

 end