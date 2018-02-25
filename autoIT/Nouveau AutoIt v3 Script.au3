#RequireAdmin
#include <ImageSearch.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=C:\Users\Said\Desktop\Tout\Koda autoit\Forms\SWbot.kxf
$Form1 = GUICreate("Summoners War - Bot by Oujdi", 439, 224, 776, 199)
$Btn_Start = GUICtrlCreateButton("Start", 8, 8, 97, 41)
$Btn_Pause = GUICtrlCreateButton("Pause", 8, 56, 97, 41)
$Btn_Reset = GUICtrlCreateButton("Reset", 8, 104, 97, 41)
$Btn_Quit = GUICtrlCreateButton("Quit", 8, 176, 97, 41)
$Txt_Timer = GUICtrlCreateLabel("Timer", 136, 16, 100, 17)
$Txt_Rep = GUICtrlCreateLabel("Répétitions réstantes :", 136, 192, 109, 17)
$Txt_Status = GUICtrlCreateLabel("Etapes", 136, 40, 37, 17)
;~ Global $counter = 0
;~ Global $Paused
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		 Case $GUI_EVENT_CLOSE
			Exit

		 Case $Btn_Start
			start()

		 Case $Btn_Pause
;~ 			TogglePause()
		 Case $Btn_Reset

		 Case $Btn_Quit
			Exit
	EndSwitch
WEnd


Func start()
   If WinExists("Bluestacks App Player", "Summoners War") Then
   MsgBox(0, "","Summoners War est bien ouvert")
Else
   MsgBox(0, "","Veuillez ouvrir Summoners War!")
EndIf
$x1=0
$y1=0
     $result = _ImageSearch("GO.bmp",0,$x1,$y1,0)
     if $result=1 Then
          MsgBox(0,"Trouvé","L'image a été trouvé" &@crlf& $x1 & " x " & $y1)
	   Else
		  MsgBox(0, "Ooops","L'image n'a pas été trouvé")
	   EndIf
;~    While 1
;~     $counter +=1
;~ 	GUICtrlSetData ($Txt_Timer, $counter)
;~     Sleep(700)
;~ WEnd
	EndFunc

;~ Func TogglePause()
;~     $Paused = NOT $Paused
;~     While $Paused
;~         sleep(100)
;~         WinSetTitle($Form1, "", "Summoners War - Bot | Script is Paused")
;~     WEnd
;~     WinSetTitle($Form1,"", "")
;~ EndFunc
