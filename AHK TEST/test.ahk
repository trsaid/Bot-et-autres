^!r::
IfWinExist, Bluestacks App Player, Summoners War
{
	DetectHiddenWindows, on
PixelSearch, Px, Py, 840, 487, 972, 548, 0x67CFF8, 3, Fast
if ErrorLevel
    MsgBox, That color was not found in the specified region.
else
    MsgBox, A color within 3 shades of variation was found at X%Px% Y%Py%.
	MouseMove, %Px%, %Py%
}
;~ ^!z::  ; Control+Alt+Z hotkey.
;~ MouseGetPos, MouseX, MouseY
;~ PixelGetColor, color, %MouseX%, %MouseY%
;~ MsgBox The color at the current cursor position is %color%.
;~ return
;~ ^!e::
;~ IfWinExist, Bluestacks App Player, Summoners War
;~ {
;~ MouseMove, 886, 159
;~ }
;~ MouseGetPos, xpos, ypos 
;~ Msgbox, The cursor is at X%xpos% Y%ypos%. 