IfWinExist, Nox1
{
	X := 0
	Y := 0
WinGetPos, X, Y, Width, Height, Nox1
			A := X
			B := Y
			MsgBox, %X% %Y%
			X += 675 
			Y += 455
			MsgBox, %X% %Y%
			WinActivate
			;~ ControlClick , x%X% y%Y% ; Sell Rune/OK
			MouseMove , %X% ,%Y% ; Sell Rune/OK
			X := A
			Y := B
			MsgBox, %X% %Y%
			;~ MouseMove, %X%, %Y%, 50 ; Go click
			
}

;~ F::
;~ ClickPos(675, 455)

;~ Esc::ExitApp