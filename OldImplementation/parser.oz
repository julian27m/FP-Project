functor
import 
    System(showInfo:Show)
    StringJ(split:Split)

export 
    Parse
    Saludo

define
    Saludo = "The Parser module is working correctly."

    %% Function to parse the program text
    fun {Parse ProgramText}
        {StringJ.split ProgramText " "}
    end
end