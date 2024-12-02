functor
import 
    System(showInfo:Show)

export 
    BuildGraph
    NodoConstante
    NodoVariable
    NodoAplicacion
    Saludo

define
    Saludo = "The Graph module is working correctly."

    % Definición de estructuras de nodos
    fun {NodoConstante N}
        constant(num:N)
    end

    fun {NodoVariable V}
        variable(var:V)
    end

    fun {NodoAplicacion F A}
        application(func:F arg:A)
    end

    % Construcción del grafo a partir de líneas del programa
    fun {BuildGraph Lineas}
        Grafo = []
    in
        for Linea in Lineas do
            NuevoNodo = {ProcesarLinea Linea}
            Grafo = NuevoNodo | Grafo
        end
        Grafo
    end

    % Procesa una línea de código y crea nodos
    fun {ProcesarLinea Linea}
        Tokens = {String.tokens Linea ' '}
    in
        case Tokens of
            ['fun' Name Param '=' Exp] then
                {NodoAplicacion Name {NodoVariable Param}}
            [Name Arg] then
                {NodoAplicacion Name {NodoConstante {String.toInt Arg}}}
            else
                fail
        end
    end
end
