#NoEnv
#Warn
SetWorkingDir %A_ScriptDir%

Gui Add, Tab2, x530 y400 w150 h35, Bot|Configuration
Gui Tab, 1
Gui Add, Button, x20 y400 w150 h35, Start
Gui Add, Button, x275 y400 w150 h35, Pause
Gui Add, Button, x530 y400 w150 h35, Reset
Gui Show, x986 y68 w700 h450, Window
Return

GuiEscape:
GuiClose:
    ExitApp

; End of the GUI section