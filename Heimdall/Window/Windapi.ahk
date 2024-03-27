global SB_HORZ          := 0
global SB_VERT          := 1

global SIF_POS          := 4
global SIF_PAGE         := 2
global SIF_RANGE        := 1
global SIF_TRACKPOS     := 16
global SIF_ALL          := SIF_RANGE|SIF_PAGE|SIF_POS|SIF_TRACKPOS

global SB_LINELEFT      := 0
global SB_LINERIGHT     := 1
global SB_PAGELEFT      := 2
global SB_PAGERIGHT     := 3
; global SB_THUMBPOSITION := 4
global SB_THUMBTRACK    := 5
global SB_LINEDOWN      := 1
global SB_LINEUP        := 0
global SB_PAGEDOWN      := 3
global SB_PAGEUP        := 2
; global SB_SCROLLCARET   := 4
; global SB_TOP           := 6
; global SB_BOTTOM        := 7
global WM_HSCROLL := 0x114
global WM_VSCROLL := 0x115

GetScrollInfo(hwnd,nbar,lpsi){
    return DllCall("GetScrollInfo","ptr",hwnd,"int",nbar,"ptr",lpsi,"int")
}

ScrollWindow(hwnd,xamount,yamount,lprect,lpcliprect){
    return DllCall("ScrollWindow","ptr",hwnd,"int",xamount,"int",yamount,"ptr",lprect,"ptr",lpcliprect,"int")
}

SetScrollInfo(hwnd,nbar,lpsi,redraw){
    return DllCall("SetScrollInfo","ptr",hwnd,"int",nbar,"ptr",lpsi,"int",redraw,"int")
}

HiWord(iLong){
    Return (iLong >> 16)
}

LoWord(iLong){
   Return (iLong & 0xFFFF)
}

Scroll_Bar(HorzVert,wParam){
    GetScrollInfo Gui.hWnd,HorzVert,si.Ptr.Ptr
    oldPos := si.nPos
    Switch LoWord(wParam){
        Case SB_LineLeft,SB_LineUp:
            si.nPos := si.nPos - (HorzVert) ? hs : vs
        Case SB_PageLeft,SB_PageUp:
            si.nPos := si.nPos - si.nPage
        Case SB_LineRight,SB_LineDown:
            si.nPos := si.nPos + (HorzVert) ? hs : vs
        Case SB_PageRight,SB_PageDown:
            si.nPos := si.nPos + si.nPage
        Case SB_ThumbTrack:
            si.nPos := HiWord(wParam)
        Default:
            Return
    }
    si.nPos := Max(si.nMin,Min(si.nPos,si.nMax - si.nPage + HorzVert))
    SetScrollInfo Gui.hWnd,HorzVert,si.Ptr.Ptr,1
}

Scroll_Msg(wParam,lParam,umsg,hwnd){
    Switch umsg{
        Case WM_HScroll:
            Scroll_Bar SB_HORZ,wParam
            ScrollWindow hwnd,oldPos - si.nPos,0,0,0
        Case WM_VScroll:
            Scroll_Bar SB_VERT,wParam
            ScrollWindow hwnd,0,oldPos - si.nPos,0,0
    }
}

Class SCROLLINFO{
    ptr := BufferAlloc(28,0)
    __New(){
        NumPut "uint",this.ptr.size,this.ptr
    }
    cbSize[] => NumGet(this.ptr,"uint")
    fMask[]{
        get => NumGet(this.ptr,4,"uint")
        set => NumPut("uint",value,this.ptr,4)
    }
    nMin[]{
        get => NumGet(this.ptr,8,"int")
        set => NumPut("int",value,this.ptr,8)
    }
    nMax[]{
        get => NumGet(this.ptr,12,"int")
        set => NumPut("int",value,this.ptr,12)
    }
    nPage[]{
        get => NumGet(this.ptr,16,"uint")
        set => NumPut("uint",value,this.ptr,16)
    }
    nPos[]{
        get => NumGet(this.ptr,20,"int")
        set => NumPut("ptr",value,this.ptr,20)
    }
    nTrackPos[]{
        get => NumGet(this.ptr,24,"int")
        set => NumPut("ptr",value,this.ptr,24)
    }
}