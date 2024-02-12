!s::
InputBox, UserInput, SRAV, `n Hello Naveen....Tell me, , 300,150, , , ,30
StringSplit, Words, UserInput,%a_space%
MsgBox, ,SRAV , %UserInput%, 30