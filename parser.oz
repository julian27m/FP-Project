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
 
        Lineas = {String.tokens ProgramaTexto '\n'}
        Grafo = {BuildGraph Lineas}
    in
        Grafo
    end
end
