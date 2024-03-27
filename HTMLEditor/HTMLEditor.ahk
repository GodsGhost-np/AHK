FileRead, Var1, Test.txt
StringReplace, Var2, Var1, cat, dog, All
var2 := RegExReplace(var2, "[color=red]^[/color].*?\R")
FileDelete, Test.txt
FileAppend, %Var2%, TestCompleted.txt