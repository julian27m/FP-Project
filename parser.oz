functor
import 
    System(showInfo:Show)
    Graph(buildGraph:BuildGraph)

export 
    Parse
    Saludo

define
    Saludo = "The Parser module is working correctly."

    fun {Parse ProgramaTexto}
        % Dividir el programa en líneas
        Lineas = {String.tokens ProgramaTexto '\n'}
        % Construir el grafo a partir de las líneas
        Grafo = {BuildGraph Lineas}
    in
        Grafo
    end
end
