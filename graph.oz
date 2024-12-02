functor
import 
    System(showInfo:Show)

export 
    BuildGraph
    Saludo

define
    Saludo = "The Graph module is working correctly."

    fun {BuildGraph Lineas}
        Grafo = nil
    in
        for Linea in Lineas do
            Grafo = {ProcesarLinea Linea Grafo}
        end
        Grafo
    end

    fun {ProcesarLinea Linea Grafo}
        Grafo
    end
end
