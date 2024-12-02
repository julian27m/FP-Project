functor
import 
    System(showInfo:Show)
    Parser(parse:Parse)
    Reducer(reduce:Reduce)

define
    {Show "Welcome to Hummingbird - Functional Programming Language"}

    Programa = "fun twice x = x + x\n twice 5"
    Grafo = {Parse Programa}
    {Show Grafo}
end
