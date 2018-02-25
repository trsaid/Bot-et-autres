;~ w: 804	h: 638
^T::

while(!imgss("Go_Normal")){
	if imgss("Victory"){
	}
	else if imgss("replay"){
	}
	else if imgss("chest"){
	}
	else if (imgss("ok_drop")){
	}
}

return

^Y::
imgss("attack")
return

imgss(imgname)
{
	ImageSearch, X, Y, 0, 0, A_ScreenWidth, A_ScreenHeight, *80 %imgname%.png
	If (ErrorLevel){
		MsgBox, Image %imgname% introuvable.
		Sleep 1000
	}
	else{
		;~ MouseMove %X%, %Y%
		ControlClick, x%X% y%Y%,Nox App Player
		;~ MsgBox x%X% y%Y%
	}
}

^R::
Reload
return