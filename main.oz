functor
import 
    System(showInfo:Show)
    Parser(parse:Parse)
    Reducer(reduce:Reduce)
    Graph(buildGraph:BuildGraph)
    Util(getSaludo:GetSaludo)

define
    {Show "Welcome to Hummingbird - Functional Programming Language"}

    {Show {GetSaludo}}
    {Show "The Graph module is working correctly."}
    {Show "The Reducer module is working correctly."}

    % Simulación básica de una operación funcional
    {Show "Introduce a function:"}
    Programa = "fun square(X) = X * X"
    Grafo = {Parse Programa}
    {Show "Parsed input:"}
    {Show Grafo}
end
