functor
import 
    System(showInfo:Show)

export 
    GetSaludo
    Sumar
    Multiplicar

define
    fun {GetSaludo}
        "The Util module is working correctly."
    end

    % Función de suma simulada
    fun {Sumar X Y}
        X + Y
    end

    % Función de multiplicación simulada
    fun {Multiplicar X Y}
        X * Y
    end
end
