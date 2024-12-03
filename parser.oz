functor
import 
    System(showInfo:Show)

export 
    Parse
    Saludo

define
    Saludo = "The Parser module is working correctly."

    %% Split a string by spaces
    fun {Str2Lst Data}
        {String.tokens Data ' '}
    end

    %% Función para convertir la lista de tokens a una cadena adecuada
    fun {TokensToString Tokens}
        case Tokens of
            nil then ""
        [] [H] then H
        [] H|T then
            H ^ " " ^ {TokensToString T}
        end
    end

    %% Función Parse
    fun {Parse ProgramaTexto}
        % Declarar la variable Tokens
        local Tokens TokenString in

            % Mostrar el input recibido
            {Show "Received function:" # ProgramaTexto}

            % Convertir el input en una lista de tokens
            Tokens = {Str2Lst ProgramaTexto}

            % Convertir la lista de tokens a una cadena adecuada
            TokenString = {TokensToString Tokens}

            % Mostrar los tokens generados como cadena
            {Show "Generated tokens:" # TokenString}

            % Devolver los tokens como cadena para evitar el error de tipo
            TokenString
        end
    end
end
