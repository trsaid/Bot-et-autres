/*
ImageSearchc - alternative to ImageSearch (uses GDI+; requires Gdip.ahk by Tic and Gdip_ImageSearch (put inside Gdip.ahk) by MasterFocus)
    Param1 - found x-coord
    Param2 - found y-coord
    Param3 - top x corner of area to search
    Param4 - top y corner of area to search
    Param5 - bottom x corner of area to search
    Param6 - bottom y corner of area to search
    Param7 - file of image to search for
    Param8 - variation (see doc for ImageSearch)
        Default: 0
    Param9 - transcolor (see doc for ImageSearch)
        Default: ""
    Param10 - relative (base coords off active window) (boolean)
        Default: 0
    Param11 - Search direction
        Vertical preference:
           1 = top->left->right->bottom
           2 = bottom->left->right->top
           3 = bottom->right->left->top
           4 = top->right->left->bottom
         Horizontal preference:
           5 = left->top->bottom->right
           6 = left->bottom->top->right
           7 = right->bottom->top->left
           8 = right->top->bottom->left
        Default: 5
    Param12 - save captured screen to active directory for debugging (boolean)
        Default: 0
*/
 #Include GDIP.ahk
ImageSearchc(ByRef out1, ByRef out2, x1, y1, x2, y2, image, vari=0, trans="", rela=0, direction=5, debug=0){
    dxoff:=0
    dyoff:=0
    if(rela)
    {
        WinGetPos,xoff,yoff,woff,hoff,A
        x2=x2 > woff ? woff : x2
        y2=y2 > hoff ? hoff : y2
        x1+=xoff,x2+=xoff
        y1+=yoff,y2+=yoff
    }
    
    ptok:=Gdip_Startup()
    imageB:=Gdip_CreateBitmapFromFile(image)
    Scrn:=Gdip_Bitmapfromscreen(x1 "|" y1 "|" x2 - x1 "|" y2 - y1)
    if(debug)
        Gdip_SaveBitmapToFile(Scrn, a_now ".png")
    Errorlev:=Gdip_ImageSearch(Scrn,imageB,tempxy,0,0,0,0,vari,trans,direction)
    Gdip_DisposeImage(Scrn)
    Gdip_DisposeImage(imageB)
    Gdip_Shutdown(ptok)
    if(Errorlev > 0)
    {
        out:=StrSplit(tempxy,"`,")
        out1:=out[1] + x1 - dxoff
        out2:=out[2] + y1 - dyoff
        return % Errorlev
    }
    return 0
}