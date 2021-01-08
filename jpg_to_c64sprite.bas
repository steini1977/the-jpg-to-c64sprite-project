      dim rc{l%,t%,r%,b%},map$(9),red(12,21),green(12,21),blue(12,21),c(12,21),m(12,21)
      map$()="","red","green","blue","cyan","pink","yellow","white","gray","black"
      rem rm=0:gm=0:bm=0
      sys "GetClientRect", @hwnd%, rc{}
      window_Width% = rc.r%
      window_Height% = rc.b%
      filename$=""
      ::rem windows filedialog i/o protocol
      dim fs{lStructSize%, hwndOwner%, hInstance%, lpstrFilter%, \
      \      lpstrCustomFilter%, nMaxCustFilter%, nFilterIndex%, \
      \      lpstrFile%, nMaxFile%, lpstrFileTitle%, \
      \      nMaxFileTitle%, lpstrInitialDir%, lpstrTitle%, \
      \      flags%, nFileOffset{l&,h&}, nFileExtension{l&,h&}, \
      \      lpstrDefExt%, lCustData%, lpfnHook%, lpTemplateName%}
      dim fp{t&(260)}
      ::
      ::rem displays at start
      colour 128+0
      colour 15
      cls:rem clear screen to white
      print "image to screen"
      print "chose image:"
      print "[1] get local image file"
      ::
      ::rem fetches keyboard choice
      keyb$="":while keyb$<>"1" :keyb$=inkey$(1) endwhile
      ::
      ::rem image part
      ::rem image place fetch from windows file-dialog
      ff$ = "image jpg,gif,tif,png"+chr$0+"*.jpg;*.png;*.tif;*.gif"+chr$0+chr$0
      fs.lStructSize% = dim(fs{})
      fs.hwndOwner% = @hwnd%
      fs.lpstrFilter% = ptr(ff$)
      fs.lpstrFile% = fp{}
      fs.nMaxFile% = 260
      fs.flags% =6
      sys "GetOpenFileName", fs{} to result%
      if result% filename$ = $$fp{}
      ::
      cls:rem clears screen to white
      if filename$<>"" then
      procdisplay(filename$,1,0,240,210):rem show image
      procdisplay(filename$,0,window_Height%-21,24,21):rem work space
      else
      run
      endif
      ::rem
      for y=0 to 20
      for x=0 to 11
      c=tint(x*4,y*2)
      redT=redT+(c and 255)
      greenT=greenT+(c >> 8 and 255)
      blueT=blueT+(c >> 16 and 255)
      next:next
      redT=int(redT/260)
      greenT=int(greenT/260)
      blueT=int(blueT/260)
      rem print redT
      rem print greenT
      rem print blueT
      for y=0 to 20
      for x=0 to 11
      c=tint(x*4,y*2)
      red(x,20-y) = c and 255
      green(x,20-y) = c >> 8 and 255
      blue(x,20-y) = c >> 16 and 255
      next:next
      ::
      proc_menu
      for y=0 to 20
      for x=0 to 11
      colour 128+0:c(x,y)=0
      test=false
      if test=false and red(x,y)>redT and green(x,y)<greenT and blue(x,y)<blueT then colour 128+1:test=true:c(x,y)=1
      if test=false and red(x,y)<redT and green(x,y)>greenT and blue(x,y)<blueT then colour 128+2:test=true:c(x,y)=2
      if test=false and red(x,y)<redT and green(x,y)<greenT and blue(x,y)>blueT then colour 128+4:test=true:c(x,y)=4

      if test=false and red(x,y)>redT and green(x,y)>greenT and blue(x,y)<blueT then colour 128+1:test=true:c(x,y)=1
      if test=false and red(x,y)>redT and green(x,y)<greenT and blue(x,y)>blueT then colour 128+4:test=true:c(x,y)=4
      if test=false and red(x,y)<redT and green(x,y)>greenT and blue(x,y)>blueT then colour 128+4:test=true:c(x,y)=4
      if test=false and red(x,y)>redT and green(x,y)>greenT and blue(x,y)>blueT then colour 128+2:test=true:c(x,y)=2


      print tab(40+x*3,y);"   ";
      m(x,y)=c(x,y)
      next:next
      colour 0
      keyb$="":while keyb$="" :keyb$=inkey$(1) endwhile
      if keyb$=" " then run
      colour 128+0
      cls
      for y=0 to 20
      for x=0 to 11
      colour 128+c(x,y)
      print tab(40+x*3,5+y);"   ";
      next:next
      for x=-1 to 12
      colour 128+15
      y=-1:print tab(40+x*3,5+y);"   ";
      y=21:print tab(40+x*3,5+y);"   ";
      next x
      for y=0 to 20
      x=-1:print tab(40+x*3,5+y);"   ";
      x=12:print tab(40+x*3,5+y);"   ";
      next
      proc_menu
      repeat
      keyb$=inkey$(0)
      if keyb$<>"" and keyb$<>" " and keyb$<>chr$(13) then
      for y=0 to 20
      for x=0 to 11
      if keyb$="1" and c(x,y)=1 then colour 128+1:m(x,y)=1
      if keyb$="1" and c(x,y)=2 then colour 128+2:m(x,y)=2
      if keyb$="1" and c(x,y)=4 then colour 128+4:m(x,y)=4
      if keyb$="1" and c(x,y)=0 then colour 128+0:m(x,y)=0
      ::
      if keyb$="2" and c(x,y)=1 then colour 128+0:m(x,y)=0
      if keyb$="2" and c(x,y)=2 then colour 128+1:m(x,y)=1
      if keyb$="2" and c(x,y)=4 then colour 128+2:m(x,y)=2
      if keyb$="2" and c(x,y)=0 then colour 128+4:m(x,y)=4
      ::
      if keyb$="3" and c(x,y)=1 then colour 128+4:m(x,y)=4
      if keyb$="3" and c(x,y)=2 then colour 128+0:m(x,y)=0
      if keyb$="3" and c(x,y)=4 then colour 128+1:m(x,y)=1
      if keyb$="3" and c(x,y)=0 then colour 128+2:m(x,y)=2
      ::
      if keyb$="4" and c(x,y)=1 then colour 128+2:m(x,y)=2
      if keyb$="4" and c(x,y)=2 then colour 128+4:m(x,y)=4
      if keyb$="4" and c(x,y)=4 then colour 128+0:m(x,y)=0
      if keyb$="4" and c(x,y)=0 then colour 128+1:m(x,y)=1
      ::
      if keyb$="5" and c(x,y)=1 then colour 128+1:m(x,y)=1
      if keyb$="5" and c(x,y)=2 then colour 128+4:m(x,y)=4
      if keyb$="5" and c(x,y)=4 then colour 128+2:m(x,y)=2
      if keyb$="5" and c(x,y)=0 then colour 128+0:m(x,y)=0
      ::
      if keyb$="6" and c(x,y)=1 then colour 128+1:m(x,y)=1
      if keyb$="6" and c(x,y)=2 then colour 128+4:m(x,y)=4
      if keyb$="6" and c(x,y)=4 then colour 128+0:m(x,y)=0
      if keyb$="6" and c(x,y)=0 then colour 128+2:m(x,y)=2
      ::
      if keyb$="7" and c(x,y)=1 then colour 128+2:m(x,y)=2
      if keyb$="7" and c(x,y)=2 then colour 128+4:m(x,y)=4
      if keyb$="7" and c(x,y)=4 then colour 128+1:m(x,y)=1
      if keyb$="7" and c(x,y)=0 then colour 128+0:m(x,y)=0
      print tab(40+x*3,5+y);"   ";
      next:next:
      endif
      until keyb$=" " or keyb$=chr$(13)
      if keyb$=" " then run
      colour 128+15
      colour 0
      input "start line nymber";sn%
      colour 128+15:cls:colour 0
      dim sprite(64)
      bit=7:cnt=0
      for y=0 to 20
      for x=0 to 11
      if m(x,y)=1 then sprite(cnt)=sprite(cnt)+2^bit
      if m(x,y)=2 then sprite(cnt)=sprite(cnt)+2^(bit-1)
      if m(x,y)=4 then sprite(cnt)=sprite(cnt)+(2^(bit-1))+(2^bit)
      bit=bit-2:if bit<0 then bit=7:cnt=cnt+1
      next x
      next y
      n=0
      for y=1 to 8
      for x=1 to 8
      if x=1 then print sn%+y;" data ";
      print;sprite(n);:n=n+1
      if x<8 then print;","; else print
      next x
      next y
      print "REM: Q to quit, R to run program again"
      repeat
      choice=0
      keyb$=inkey$(0)
      if keyb$="q" or keyb$="Q" then choice = 1
      if keyb$="r" or keyb$="R" then choice = 2
      until choice > 0
      if choice = 1 then quit
      if choice = 2 then run

      ::rem
      ::
      end:rem the end of program
      rem some protocol
      def proc_menu
      print tab(80,2)"| one and spacebar to collect the image |"
      print tab(80,3)"| numbers 1 til 9- shift color          |"
      print tab(80,4)"| return make data numbers from image   |"
      endproc
      def procdisplay(pic$, xpos%, ypos%, xsize%, ysize%)
      local tSI{}, pic%, gdip%, image%, ix%, iy%, gfx%, lGDIP%
      dim pic% local 513

      sys "MultiByteToWideChar", 0, 0, pic$, -1, pic%, 256

      sys "LoadLibrary", "GDIPLUS.DLL" to gdip%
      if gdip% = 0 error 100, "Couldn't load GDIPLUS.DLL"
      sys "GetProcAddress", gdip%, "GdiplusStartup" to `GdiplusStartup`
      sys "GetProcAddress", gdip%, "GdipLoadImageFromFile" to `GdipLoadImageFromFile`
      sys "GetProcAddress", gdip%, "GdipDrawImageRectRectI" to `GdipDrawImageRectRectI`
      sys "GetProcAddress", gdip%, "GdipGetImageHeight" to `GdipGetImageHeight`
      sys "GetProcAddress", gdip%, "GdipGetImageWidth" to `GdipGetImageWidth`
      sys "GetProcAddress", gdip%, "GdipCreateFromHDC" to `GdipCreateFromHDC`
      sys "GetProcAddress", gdip%, "GdipSetSmoothingMode" to `GdipSetSmoothingMode`
      sys "GetProcAddress", gdip%, "GdipDeleteGraphics" to `GdipDeleteGraphics`
      sys "GetProcAddress", gdip%, "GdipDisposeImage" to `GdipDisposeImage`
      sys "GetProcAddress", gdip%, "GdiplusShutdown" to `GdiplusShutdown`

      dim tSI{GdiplusVersion%, DebugEventCallback%, \
      \       SuppressBackgroundThread%, SuppressExternalCodecs%}
      tSI.GdiplusVersion% = 1

      sys `GdiplusStartup`, ^lGDIP%, tSI{}, 0
      sys `GdipLoadImageFromFile`, pic%, ^image%
      if image% = 0 then
      sys `GdiplusShutdown`, lGDIP%
      sys "FreeLibrary", gdip%
      error 90, "Couldn't load " + pic$
      endif

      sys `GdipGetImageWidth`, image%, ^ix%
      sys `GdipGetImageHeight`, image%, ^iy%

      sys `GdipCreateFromHDC`, @memhdc%, ^gfx%
      if gfx%=0 error 90, "GdipCreateFromHDC failed"
      sys `GdipSetSmoothingMode`, gfx%, 2

      sys `GdipDrawImageRectRectI`, gfx%, image%, xpos%, ypos%, xsize%, ysize%, \
      \                                           0, 0, ix%, iy%, 2, 0, 0, 0

      sys `GdipDeleteGraphics`, gfx%
      sys `GdipDisposeImage`, image%
      sys `GdiplusShutdown`, lGDIP%
      sys "FreeLibrary", gdip%
      sys "InvalidateRect", @hwnd%, 0, 0
      sys "UpdateWindow", @hwnd%
      endproc
      ::
