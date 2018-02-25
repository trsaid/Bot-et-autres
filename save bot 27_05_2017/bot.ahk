#Include fonctions.ahk
;~ ====================================
Gui Add, Picture, x136 y15 w212 h122, C:\Users\trsai\Desktop\Code\images\Summoners-war.png
;~ ====================================
Gui Add, Button, x8 y328 w80 h23 gStart, Start
Gui Add, Button, x96 y330 w80 h23 gPause, Pause
Gui Add, Button, x96 y330 w80 h23 gResume, Resume
Gui Add, Button, x300 y330 w80 h23 gStop, Stop
Gui Add, Button, x390 y330 w80 h23 gReset, Reset
;~ ====================================
Gui Add, Text, x10 y185 w130 h25 +0x200, Runs Type :
Gui Add, DropDownList, x10 y210 w130 vMap, Niveau Actuel||Géant|Dragon|Necro|Hall Magie|Secret Dangeon
;~ ====================================
Gui Add, Text, x150 y185 w130 h25 +0x200, Nombre de run :
Gui Add, DropDownList, x150 y210 w130 vRuns, Run infini||Personalisé|Stop level max slot 2/3/4
;~ ====================================
Gui Add, Text, x10 y235 w130 h25 +0x200, Refill :
Gui Add, DropDownList, x10 y260 w130 vRefillStatus, Non||Oui
;~ ====================================
Gui Add, GroupBox, x155 y235 w130 h70, Autre
Gui Add, CheckBox, x160 y250 w120 h25 vstopDefeat, Stop si défaite
Gui Add, CheckBox, x160 y275 w120 h25 vnextArea, Etage suivant
;~ ====================================
Gui Add, Text, vListChoix x10 y150 w400 h25 +0x200, Choix : Aucun
;~ ====================================
Gui Add, GroupBox, x300 y190 w170 h115, Statistiques
Gui Add, Text, vType x310 y215 w145 h25 +0x200, Type :
Gui Add, Text, vBattle x310 y240 w145 h25 +0x200, Battle : W : 0 | L : 0
Gui Add, Text, vRunes x310 y265 w145 h25 +0x200, Runes : V : 0 | 5* : 0 | 6* : 0
;~ ====================================
Gui Show, w481 h381, Summoners War BOT
GuiControl, disable, Stop
GuiControl, disable, Pause
GuiControl, hide, Resume
Gui Add, StatusBar, x0 y358 w481 h23 vStatus, Status : A l'arret
Return
;~ global Coor

;~ WinGetPos, X1, Y1, Width, Height, compte 2


Start:
Gui, Submit, nohide
Option()
GuiControl,,ListChoix,  Conditions : Run : %Runs% | Map : %Map% | Refill : %RefillStatus%
GuiControl, disable, Start
GuiControl, enable, Stop
GuiControl, enable, Pause
While 1 {
	if (stopscript = 1){
		break
	}
	;GuiControl,,Status,  Status : En combat... (%test%)
	;sleep 200
	if (imgs("start", 50)){
		start()
	}
	if (imgs("noRevive", 80)){
		LoseCount += 1
		RunLimit -= 1
		GuiControl,,Battle,  Battle : W : %winCount% L : %LoseCount%
		if not stopDefeat{
			defeated()
			if (isMaxLevel){
				GuiControl,,status,  Status : Un ou plusieurs mob niveau max. | Fin de tache.
				break
			}
			GuiControl,,status,  Status : Défaite!
			start()
		}
		else{
			GuiControl,,status,  Status : Défaite! Fin de la partie
			break
		}
	}
	if (imgs("CristalVictory", 50)){
		winCount += 1
		RunLimit -= 1
		GuiControl,,status,  Status : Victoire!
		ControlClick, x%FoundX% y%FoundY%, compte 2
		;~ MouseMove, %FoundX%, %FoundY%
		GuiControl,,Battle,  Battle : W : %winCount% L : %LoseCount%
		sleep 200
		victory()
		if (isMaxLevel){
				GuiControl,,status,  Status : Un ou plusieurs mob niveau max. | Fin de tache.
				break
		}
		ReplayOrNext()
		start()
		;~ break
	}
	if (imgs("sell", 50)){
		SellGetRune()
		start()
	}
	if (imgs("replay", 50)){
		ReplayOrNext()
		start()
	}
	if (imgs("noEnergy", 50)){
		GuiControl,,status,  Status : Energie insuffisante
		refill()
		replayOrNext()
		start()
	}
	if (imgs("play", 50)){
		GuiControl,,status,  Status : Activation du mode auto
		ControlClick, x%FoundX% y%FoundY%, compte 2
	}
	;test += 1
}
return



Pause:
GuiControl,,status,  Status : En Pause.
Pause,, 1
GuiControl, Hide, Pause
GuiControl, Show, Resume
return

Resume:
Pause,, 0
GuiControl,,status,  Status : En cours d'execution.
GuiControl, Show, Pause
GuiControl, Hide, Resume
return

Stop:
stopscript = 1
winCount = 0
LoseCount = 0
GuiControl, Enable, Start
GuiControl, disable, Pause
GuiControl,,status,  Status : Arret
ControlClick, x%FoundX% y%FoundY%, %WindowsName%
return

Reset:
Reload
return

F10::
Reload
return

F9::
imgRegion("max", slot2MaxLevelRegion, 80)
return

imgs(imgname, Var){
		WinMove, compte 2,, 0, 0
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *%Var% images/%imgname%.PNG
		CoordMode Pixel
		if (ErrorLevel = 1) {
			GuiControl,,status,  Status : Rien!
			sleep 200
		}
		else if (ErrorLevel = 2) {
			GuiControl,,status,  Status : Image introuvable.
		}
		else{
			return FoundX FoundY
			Sleep 200
		}
	
}

imgRegion(imgname, Coor, Var){
	WinMove, %WindowsName%,, 0, 0
	WinGetPos, PosX, PosY, PosW, PosH, %WindowsName%
	
	ImgX1 = % Coor.1
	ImgY1 = % Coor.2
	ImgX2 = % Coor.3 + Coor.1
	ImgY2 = % Coor.4 + Coor.2
	
	;~ MsgBox, % ImgX1 "|" ImgY1 "|" ImgX2 "|" ImgY2
	ImageSearch, FoundX, FoundY, % ImgX1, ImgY1, ImgX2, ImgY2 , *%Var% images/%imgname%.PNG
	CoordMode Pixel
	
	if (ErrorLevel = 1) {
		GuiControl,,status,  Status : Rien!
		sleep 200
	}
	else if (ErrorLevel = 2) {
		GuiControl,,status,  Status : Image introuvable.
	}
	else{
		return FoundX FoundY
		Sleep 200
	}
}
start(){
	if (imgs("start", 50)){
		GuiControl,,status,  Status : Start battle.
		
		ControlClick, x%FoundX% y%FoundY%, compte 2
		sleep 500
		if (imgs("NoLeaderSkill", 50)){
			GuiControl,,status,  Status : Auncun leader skill.
			sleep 500
			if (imgs("yes", 50)){
				GuiControl,,status,  Status : Continuer sans leader skill.
				ControlClick, x%FoundX% y%FoundY%, compte 2
				sleep 200
				
			}
		}
	}
}

SellGetRune(){
	if (imgs("sell", 50)){
		GuiControl,,status,  Status : Vente rune.
		ControlClick, x%FoundX% y%FoundY%, compte 2
		RuneSold += 1
		;~ MouseMove, %FoundX%, %FoundY%
	}
}

ReplayOrNext(){
	if nextArea {
		if (imgs("next", 50)){
			GuiControl,,status,  Status : Etage suivant.
			ControlClick, x%FoundX% y%FoundY%, compte 2
			;~ MouseMove, %FoundX%, %FoundY%
		}
	}
	else if not imgs("replay", 50){
		if (imgs("next", 50)){
			GuiControl,,status,  Status : Etage suivant.
			ControlClick, x%FoundX% y%FoundY%, compte 2
		}
	}
	else if (imgs("replay", 50)){
		GuiControl,,status,  Status : Rejouer.
		ControlClick, x%FoundX% y%FoundY%, compte 2
	}

}

refill(){
	if RefillEnergy{
		GuiControl,,status,  Status : Achat d'energie en cours...
		if (imgs("yesRecharge", 50)){
			ControlClick, x%FoundX% y%FoundY%, compte 2
			sleep 200
		}
		if (imgs("recharge", 50)){
			ControlClick, x%FoundX% y%FoundY%, compte 2
			sleep 200
		}
		if (imgs("yesPurchase", 50)){
			ControlClick, x%FoundX% y%FoundY%, compte 2
			sleep 200
		}
		if (imgs("yesPurchase", 50)){
			ControlClick, x%FoundX% y%FoundY%, compte 2
			sleep 200
		}
		if (imgs("okPurchase", 50)){
			ControlClick, x%FoundX% y%FoundY%, compte 2
			sleep 200
		}
		if (imgs("closePurchase", 50)){
			ControlClick, x%FoundX% y%FoundY%, compte 2
			sleep 200
		}
	}
	else{
		if (imgs("noPurchase", 50)){
			ControlClick, x%FoundX% y%FoundY%, compte 2
			sleep 200
		}
		while waitTimer > 0 {
			GuiControl,,status,  Status : Energie insuffisante. Lancement dans %waitTimer% minutes.
			sleep 60000
			waitTimer -= 1
		}
		waitTimer = 30
	}
}
victory(){
	CheckMaxLevel()
	if (imgs("CristalVictory", 50)){
		GuiControl,,status,  Status : Ouverture du coffre.
		ControlClick, x%FoundX% y%FoundY%, compte 2
		sleep 200
	}
	if (imgs("CristalVictory", 50)){
		GuiControl,,status,  Status : Ouverture du coffre.
		ControlClick, x%FoundX% y%FoundY%, compte 2
		sleep 200
	}
	sleep 200
	if (imgs("ok", 50)){
		GuiControl,,status,  Status : Recuperation item.
		ControlClick, x%FoundX% y%FoundY%, compte 2
		sleep 200
	}
	else{
		SellGetRune()
	}
	
}
defeated(){
	if (imgs("noRevive", 50)){
			ControlClick, x%FoundX% y%FoundY%, compte 2
			sleep 500
			CheckMaxLevel()
		}
	if (imgs("CristalVictory", 50)){
		GuiControl,,status,  Status : Défaite click.
		ControlClick, x%FoundX% y%FoundY%, compte 2
		sleep 200
	}
	if (imgs("replay", 50)){
		GuiControl,,status,  Status : Rejouer.
		ControlClick, x%FoundX% y%FoundY%, compte 2
		sleep 200
	}
}
CheckMaxLevel(){
	if stopMaxLevel{
		if(imgRegion("max", slot2MaxLevelRegion, 80)){
			isMaxLevel = true
		}
		else if(imgRegion("max", slot3MaxLevelRegion, 80)){
			isMaxLevel = true
		}
		else if(imgRegion("max", slot4MaxLevelRegion, 80)){
			isMaxLevel = true
		}
	}
}
RunLimCheck(){
	if runLim <= 0 and runNum
		return true
	else
		return false
}
Option(){
	if (RefillStatus = "Oui") {
		RefillEnergy = true
	}
	else if (RefillStatus = "Non") {
		RefillEnergy = false
	}
	
	if (Runs = "infini"){
		runNum = false
	}
	else if (Runs = "Personalisé"){
		runNum = true
		runLim = customLim
	}
	else if (Runs = "Stop level max slot 2/3/4"){
		stopMaxLevel = true
	}
	if nextArea
		return true
	else
		return false
	
	if stopDefeat
		return true
	else
		return false

}