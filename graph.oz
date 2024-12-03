functor
import 
    System(showInfo:Show)

export 
    BuildGraph
    Saludo

define
    Saludo = "The Graph module is working correctly."

    % Construcción del grafo (simple confirmación)
    fun {BuildGraph ParsedData}
        local Name Variables Operation Parameters in
            % Extraer datos de la tupla recibida
            Name = ParsedData.name
            Variables = ParsedData.variables
            Operation = ParsedData.operation
            Parameters = ParsedData.parameters

            % Confirmar recepción
            {Show "Graph Received:"}
            {Show "Name:"#Name}
            {Show "Variables:"#Variables}
            {Show "Operation:"#Operation}
            {Show "Parameters:"#Parameters}

            "Graph Construction Complete"
        end
    end
end
