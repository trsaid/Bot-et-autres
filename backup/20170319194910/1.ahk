Started = 0
Gui, add, button, x5 y5 h20 w70 gstart, Start
Gui, add, button, x5 y30 h20 w70 gPause, Pause
Gui, add, button, x5 y30 h20 w70 gResume, Resume
Gui, add, button, x5 y55 h20 w70 greset, Reset

Gui,add, Text,x85 y5 h20 w120 vStatus, Etapes
Gui,add, Text,x85 y30 h20 w70 vTimer, 0/0 Sec

Gui, add, Checkbox, x450 y85 h20 w70 vBox, TEST


;~ ############################
;~ # ENERGIE AND  COST CHOISE #
;~ ############################

Gui, Add, Text, x345 y3 h20 w180 vTxT_NbrRep, Energie réstante :
Gui, Add, Edit, x430 y0 w70 h21 vEdit_NbrRep gSubmit
Gui, Add, UpDown, vNbrRep gSubmit Range0-999, 0

Gui, Add, Text, x345 y28 h20 w180 vTxT_Prix, Prix en énérgie   :
Gui, Add, Edit, x430 y25 w70 h21 vEdit_Prix gSubmit
Gui, Add, UpDown, vPrix gSubmit Range0-999, 0

Gui, Add, Text, x345 y53 h20 w180 vTxT_Temps, Temps (sec) :
Gui, Add, Edit, x430 y50 w70 h21 vEdit_Temps gSubmit
Gui, Add, UpDown, vTemps gSubmit Range0-999, 0


;~ ############################

Gui,add, Text,x85 y55 h20 w180 vRep, Nombre de répétitions :
Gui,add, Text,x85 y85 h20 w180 vTps, Temps d'execution :
gui, show, w500
GuiControl, disable, Pause
GuiControl, Hide, Resume
return

SecToHHMMSS(Sec) {
	OldFormat := A_FormatFloat
	SetFormat, Float, 02.0
	Hrs  := Sec//3600/1
	Min := Mod(Sec//60, 60)/1
	Sec := Mod(Sec,60)/1
	SetFormat, Float, %OldFormat%
	Return (Hrs ? Hrs "h " : "") (Min ? Min "min " : "") (Sec ? Sec "sec " : "")
}
WinGetPos, X, Y, Width, Height, Mobizen Mirroring
Temps = Temps +7
start:
repe = 0
Gui, Submit, NoHide

IfWinExist, Mobizen Mirroring
{
    GuiControl, Enable, Pause
    GuiControl, disable, Start
	
	If Box = 0
	{
		Started = 1 ; 1 si le bot est ON, autre si OFF
		NbrRep:=NbrRep//Prix
		WinMove, 0, 0  ; Move it to a new position.
		Sleep, 500

		loop, %NbrRep%
		{
			repe++
			GuiControl,,Rep , Répétitions effectuer : %repe%/%NbrRep%
			A := X
			B := Y
			X += 816
			Y += -14
			ControlClick , x%X% y%Y% ; Go click
			MouseMove, %X%, %Y%
			GuiControl,,Status , Etape 1 : Effectuer
			Sleep, 1500
			
			while counter < Temps
			{
				counter +=1
				GuiControl,,Timer , %counter%/%Temps% Sec
				sleep, 1000
			}
			X := A
			Y := B
			A += 400
			B += 330
			ControlClick , x%A% y%B% ; Show chest
			GuiControl,,Status , Etape 2 : Effectuer
			sleep, 1000
			ControlClick , x%A% y%B% ; Open chest
			GuiControl,,Status , Etape 3 : Effectuer
			Sleep, 1500
			A := X
			B := Y
			X += 375
			Y += 476
			ControlClick , x%X% y%Y% ; Sell Rune/OK
			GuiControl,,Status , Etape 4 : Effectuer
			Sleep, 1500
			X := A
			Y := B
			A += 240
			B += 357
			ControlClick , x%A% y%B% ; Replay Click
			GuiControl,,Status , Etape 5 : Effectuer
			Sleep, 2000

			counter = 0
			;~ Tpsx := SecToHHMMSS(Temps*NbrRep)
			;~ GuiControl,,Tps , Temps d'execution Total : %Tpsx%

		}

		MsgBox, FINI!
		Started = 0
		GuiControl, Enable, Start
	}

	If Box = 1
	{
		Started = 1 ; 1 si le bot est ON, autre si OFF
		NbrRep:=NbrRep//Prix
		WinMove, 0, 0  ; Move it to a new position.
		Sleep, 500

		loop, %NbrRep%
		{
			repe++
			GuiControl,,Rep , Répétitions effectuer : %repe%/%NbrRep%
			;~ ControlClick , x675 y455 ; Go click
			GuiControl,,Status , Etape 1 : Effectuer
			Sleep, 1500
			
			while counter < (Temps+7)
			{
				counter +=1
				GuiControl,,Timer , %counter%/%Temps% Sec
				sleep, 1000
			}


			;~ ControlClick , x400 y330 ; Show chest
			GuiControl,,Status , Etape 2 : Effectuer
			sleep, 500
			;~ ControlClick , x400 y300 ; Open chest
			GuiControl,,Status , Etape 3 : Effectuer
			Sleep, 1000
			;~ ControlClick , x375 y476 ; Sell Rune/OK
			GuiControl,,Status , Etape 4 : Effectuer
			Sleep, 1000
			;~ ControlClick , x240 y357 ; Replay Click
			GuiControl,,Status , Etape 5 : Effectuer
			Sleep, 2000

			counter = 0
			;~ Tpsx := SecToHHMMSS(Temps*NbrRep)
			;~ GuiControl,,Tps , Temps d'execution : %Tpsx%

		}

		MsgBox, FINI!
		Started = 0
		GuiControl, Enable, Start
	}
}
else
	MsgBox, mobizen n'est pas ouvert!
return

Submit:

If (Started == 0)
{
	Gui, Submit, NoHide
	NbrRep:=NbrRep//Prix
	Tpsx := SecToHHMMSS((Temps+7)*NbrRep)

	GuiControl,,Tps , Temps d'execution : %Tpsx%
	GuiControl,, Rep, Nombre de répétitions : %NbrRep%
	GuiControl,, Timer, 0/%Temps% Sec

	return
}

else
{
    MsgBox, Impossible lorsque le bot est actif!
    return
}

Pause:

Pause,, 1
GuiControl, Hide, Pause
GuiControl, Show, Resume
return

Resume:

Pause,, 0
GuiControl, Show, Pause
GuiControl, Hide, Resume
return

reset:

Reload
return