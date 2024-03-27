~RButton::
~MButton::
~LButton::
If HideToolTip = 0
    Return
If ToolTipVisible = 1
{
    ToolTip
    ToolTipVisible = 0
    Return
}
Return
^!c::
{
If ToolTipVisible = 1
{
    ToolTip
    ToolTipVisible = 0
    Return
}
CurrentCB = %Clipboard%
Clipboard =
SendInput, ^c
ClipWait, 5
If ErrorLevel
{
    MsgBox, 48, CRC Calculator, No text highlighted or problem copying text to clipboard.
    Return
}
Source = %Clipboard%
StringLen, SourceLength, Source
SourceLength := SourceLength * 5

ToolTip, Calculating... please wait ?., % A_CaretX-SourceLength, % A_CaretY+50
Target =
Target := CRCcalc(Source)

ToolTip, %Target%, % A_CaretX-SourceLength, % A_CaretY+50
ToolTipVisible = 1
If Paste2CB = 1
    Clipboard = %Target%
Else
    Clipboard = %CurrentCB%
Return

CRCcalc(Source)
{
	StringTrimRight, Source, Source, 2
    StringTrimLeft, ToCalculate, Source, 2
	var:=FF
	SetFormat, IntegerFast, hex
	Var += 0
	msgbox %Var%
    ;Result := Source
	
    
    Return Result
}
return
}