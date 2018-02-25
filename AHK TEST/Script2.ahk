gui, add, button, x5 y5 h20 w70 gstart, Start
gui, add, button, x5 y30 h20 w70 gPause, Pause
gui, add, button, x5 y55 h20 w70 greset, Reset
gui, add, button, x5 y85 h20 w70 gexit, Quit
Gui,add, Text,x85 y5 h20 w180 vStatus, Etapes
Gui,add, Text,x85 y30 h20 w70 vTimer, time

;~ ############################
;~ # ENERGIE AND  COST CHOISE #
;~ ############################

Gui,add, Text, x195 y5 w100 h21 vTxT_NbrRep, Energie réstante :
Gui, Add, Edit, x280 y0 w70 h21, vEdit_NbrRep
Gui, Add, UpDown, vNbrRep

Gui,add, Text,x195 y25 h20 w180 vTxT_Prix, Prix en énérgie   :
Gui, Add, Edit, x280 y25 w70 h21, R1 vEdit_Prix
Gui, Add, UpDown, vPrix

Gui, Add, Button, x280 y50 w70 h21, Submit

;~ ############################

Gui,add, Text,x85 y85 h20 w180 vRep, Nombre de répétitions :
gui, show, w350
return

;~ T = 65 ; time to clean
ButtonSubmit:
 Gui, Submit, NoHide
 NbrRep:=NbrRep//Prix
 GuiControl,, Rep, Nombre de répétitions : %NbrRep%
 MsgBox,% NbrRep
return
start:


;~ IfWinExist, Bluestacks App Player, Summoners War
;~ {
    ;~ WinActivate  ; Automatically uses the window found above.
    ;~ WinMove, 66, 0  ; Move it to a new position.
    ;~ Sleep, 500
    
    ;~ loop,
    ;~ {
    ;~ loop, %NbrRep%
    ;~ {
    ;~ repe++
    GuiControl,,Rep , Répétitions effectuer : %repe%/%NbrRep%
    ;~ ControlClick , x850 y500 ; Go click
    ;~ GuiControl,,Status , Etape 1 : Effectuer
    ;~ Sleep, 1500
    ;~ while counter < 110
    ;~ {
        ;~ counter +=1
        ;~ GuiControl,,Timer , %counter% secondes
        ;~ sleep, 1000
    ;~ }
    ;~ ControlClick , x520 y400 ; Show chest
    ;~ GuiControl,,Status , Etape 2 : Effectuer
    ;~ sleep, 1000
    ;~ ControlClick , x520 y400 ; Open chest
    ;~ GuiControl,,Status , Etape 3 : Effectuer
    ;~ Sleep, 2000
    ;~ ControlClick , x471 y557 ; Sell Rune/OK
    ;~ ControlClick , x675 y266 ; Click X
    ;~ GuiControl,,Status , Etape 4 : Effectuer
    ;~ Sleep, 1000
    ;~ ControlClick , x305 y424 ; Replay Click
    ;~ GuiControl,,Status , Etape 5 : Effectuer
    ;~ Sleep, 2000
    ;~ counter = 0
    
    ;~ }
    ;~ MsgBox, FINI!
    ;~ sleep, 2000
    ;~ NbrRep := NbrRep+1
;~ }
;~ }
return

Pause:
Pause,Toggle
return

reset:
Reload
return

exit:
 {
   exitapp
 }
return