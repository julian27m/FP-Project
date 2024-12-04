functor
import 
    System(showInfo:Show print:Print)
    Parser(parse:Parse)
    Reducer(reduce:Reduce)
    Graph(buildGraph:BuildGraph)
    Util(getSaludo:GetSaludo)
    Open
    StringJ(split:Split strip:Strip)
    Tree(node:Node printTree:PrintTree fullFillFromCallBack:FullFillFromCallBack)

define

    class Program
        attr functions callbacks

        meth init()
            functions := nil
            callbacks := nil
        end

        meth addFunction(Line)
            if (@functions == nil) then
                functions := [{Strip Line " "}]
            else
                functions := {Append @functions [{Strip Line " "}]}
            end
        end

        meth getFunctions(Return)
            Return = @functions
        end

        meth addCallBack(Line)
            if (@callbacks == nil) then
                callbacks := [{Strip Line " "}]
            else
                callbacks := {Append @callbacks [{Strip Line " "}]}
            end
        end

        meth getCallBacks(Return)
            Return = @callbacks
        end

        meth execute()
            {Show "Starting execution"}
            local CallBackList in
                {self getCallBacks(CallBackList)}
                for CallBack in CallBackList do
                    {Show "This is a call back <" # CallBack # ">"}
                    {FullFillFromCallBack CallBack}
                end
            end
        end
    end   
    

    local Lines MyProgram in
        File = {New Open.file init(name:'input.txt' flags:[read])}
        {File read(list:Lines)}

        MyProgram = {New Program init()}
        for Line in {Split Lines "\n"} do
            if {Nth {Split Line " "} 1} == "fun" then
                {MyProgram addFunction(Line)}
            else
                {MyProgram addCallBack(Line)}
            end
        end

        {MyProgram execute()}

    end
end
