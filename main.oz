functor
import 
    System(showInfo:Show)
    Parser(parse:Parse)
    Reducer(reduce:Reduce)
    Graph(buildGraph:BuildGraph)
    Util(getSaludo:GetSaludo)

define
    {Show "Welcome to Hummingbird - Functional Programming Language"}

    Programa = "fun twice x = x + x\n twice 5"
    Grafo = {Parse Programa}
    Resultado = {Reduce Grafo}
    {Show Grafo}
    {Show Resultado}
end
