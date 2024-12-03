functor
import 
    System(showInfo:Show)

export 
    Parse
    Saludo

define
    Saludo = "The Parser module is working correctly."

    fun {Parse ProgramaTexto}
        % Mostrar el input recibido
        {Show "Received function:" # ProgramaTexto}
        ProgramaTexto
    end
end
