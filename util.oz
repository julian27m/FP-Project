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

    fun {Sumar X Y}
        X + Y
    end

    fun {Multiplicar X Y}
        X * Y
    end
end
