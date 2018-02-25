Started = 0
Gui, add, button, x5 y5 h20 w70 gstart, Start
Gui, add, button, x5 y30 h20 w70 gPause, Pause
Gui, add, button, x5 y30 h20 w70 gResume, Resume
Gui, add, button, x5 y55 h20 w70 greset, Reset
Gui, add, button, x5 y85 h20 w70 gexit, Quit

Gui,add, Text,x85 y5 h20 w120 vStatus, Etapes
Gui,add, Text,x85 y30 h20 w70 vTimer, 0/0 Sec

Gui, add, Checkbox, x330 y85 h20 w70 vBox, TEST


;~ ############################
;~ # ENERGIE AND  COST CHOISE #
;~ ############################

Gui, Add, Text, x245 y3 h20 w180 vTxT_NbrRep, Energie réstante :
Gui, Add, Edit, x330 y0 w70 h21 vEdit_NbrRep gSubmit
Gui, Add, UpDown, vNbrRep gSubmit Range1-999, 1

Gui, Add, Text, x245 y28 h20 w180 vTxT_Prix, Prix en énérgie   :
Gui, Add, Edit, x330 y25 w70 h21 vEdit_Prix gSubmit
Gui, Add, UpDown, vPrix gSubmit Range1-999, 1

Gui, Add, Text, x245 y53 h20 w180 vTxT_Temps, Temps (sec) :
Gui, Add, Edit, x330 y50 w70 h21 vEdit_Temps gSubmit
Gui, Add, UpDown, vTemps gSubmit Range1-999, 1


;~ ############################

Gui,add, Text,x85 y55 h20 w180 vRep, Nombre de répétitions :
Gui,add, Text,x85 y85 h20 w180 vTps, Temps d'execution :
gui, show, w400
GuiControl, disable, Pause
GuiControl, Hide, Resume
return

start:
repe = 0
Gui, Submit, NoHide

IfWinExist, Nox1
{
    GuiControl, Enable, Pause
    GuiControl, disable, Start
	If Box = 1
	{
		MsgBox, Checkbox is checked
	}
    
	If Box = 0
	{
		 Started = 1 ; 1 si le bot est ON, autre si OFF
         NbrRep:=NbrRep//Prix
    ;~ WinActivate  ; Automatically uses the window found above.
    WinMove, 0, 0  ; Move it to a new position.
    Sleep, 500
    
    ;~ loop,
    ;~ {
    loop, %NbrRep%
    {
    repe++
    GuiControl,,Rep , Répétitions effectuer : %repe%/%NbrRep%
    ControlClick , x675 y455 ; Go click
    GuiControl,,Status , Etape 1 : Effectuer
    Sleep, 1500
    while counter < Temps
    {
        counter +=1
        GuiControl,,Timer , %counter%/%Temps% Sec
        sleep, 1000
    }
    ControlClick , x400 y330 ; Show chest
    GuiControl,,Status , Etape 2 : Effectuer
    sleep, 2000
    ControlClick , x400 y300 ; Open chest
    GuiControl,,Status , Etape 3 : Effectuer
    Sleep, 2000
    ControlClick , x375 y476 ; Sell Rune/OK
    GuiControl,,Status , Etape 4 : Effectuer
    Sleep, 2000
    ControlClick , x240 y357 ; Replay Click
    GuiControl,,Status , Etape 5 : Effectuer
    Sleep, 2000
    counter = 0
    
    }
    MsgBox, FINI!
    Started = 0
    GuiControl, Enable, Start
    ;~ sleep, 2000
    ;~ NbrRep := NbrRep+1
		}
}
return

Submit:
If (Started == 0)
{
Gui, Submit, NoHide
NbrRep:=NbrRep//Prix
Tpsx:=(Temps*NbrRep//60)
GuiControl,,Tps , Temps d'execution : %Tpsx% Minutes
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

exit:
 {
   exitapp
 }
return