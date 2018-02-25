SetTitleMatchMode, 2
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
 
wintitle := "Bluestacks App Player" ;Name of your window.
 
;First 3 are variable placeholders. 4th is the variable above
CreateContext(hDC, context, pixels, wintitle)
 
;Move your window offscreen (My screen is 1920x1200)
WinMove, %wintitle%,, 1920, 1080
 
;Grab the color on window at x/y (0,0)
color := DllCall("GetPixel", UInt, context, Int, 833, Int, 499)
	
;Convert the integer to RGB format, then convert to hex and show
Msgbox % DecToHex(ConvertColor(color))
 
;Move window back to viewable area
WinMove, %wintitle%,, 0, 0
 
;Cleanup to avoid memory leaks.
DeleteContext(hDC, context, pixels)
 
;Everything below here shouldn't be modified unless you know what you're doing
 
CreateContext(ByRef hDC, ByRef mDC, ByRef hBM, wintitle)
{
   WinGet, w_id, ID, %wintitle%
   hDC := DllCall("GetDC", UInt, w_id)
 
   IfWinExist, %wintitle%
   {
  WinGetPos, x, y, w, h
   }
 
   mDC := DllCall("gdi32.dll\CreateCompatibleDC", "UInt", hDC)
   hBM := DllCall("gdi32.dll\CreateCompatibleBitmap", "uint", hDC, "int", w, "int", h)
   DllCall("gdi32.dll\SelectObject", UInt, mDC, UInt, hBM)
   DllCall("PrintWindow", "UInt", w_id, UInt, mDC, UInt, 0)
}
 
DeleteContext(ByRef hDC, ByRef mDC, ByRef hBM)
{  
   DllCall("ReleaseDC", "UInt", 0, "UInt", hDC)
   DllCall("DeleteDC", "Uint", mDC)
   DllCall("DeleteObject", "Uint", hBM)
}
 
ConvertColor( BGRValue )
{
   BlueByte := ( BGRValue & 0xFF0000 ) >> 16
   GreenByte := BGRValue & 0x00FF00
   RedByte := ( BGRValue & 0x0000FF ) << 16
   return RedByte | GreenByte | BlueByte
}
 
DecToHex(dec)
{
   oldfrmt := A_FormatInteger
   hex := dec
   SetFormat, IntegerFast, hex
   hex += 0
   hex .= ""
   SetFormat, IntegerFast, %oldfrmt%
   return hex
}
If (color = "0xf7cd677")
{
	MsgBox, GG
}
	else
	{
		MsgBox, noob
	}