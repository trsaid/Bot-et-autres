#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <ImageSearch.au3>

$x1=0
$y1=0

While 1

     $result = _ImageSearch("test.jpg",0,$x1,$y1,0)
     if $result=1 Then
          MsgBox(0,"Trouvé","L'image a été trouvé")
     EndIf

Wend