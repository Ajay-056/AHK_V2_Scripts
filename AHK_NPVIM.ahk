#Requires AutoHotkey v2.0+
Persistent
#SingleInstance

global vimMode := "insert" ; Default mode is Insert


; Monitor if Notepad is active
#HotIf WinActive("ahk_class Notepad")

~!r::Reload
; Switch to Normal mode with Esc
Esc::
{    
    global vimMode
    vimMode := "normal"
    Tooltip vimMode, 850, 960
    SetTimer () => ToolTip(), -15000
}

; Switch to Insert mode with 'i'
i::
{
    global vimMode
        if (vimMode == "normal") {
            vimMode := "insert"
            Tooltip vimMode, 850, 960
            SetTimer () => ToolTip(), -15000
            } else {
                SendText "i" ; Let 'i' work as usual in Insert mode
        }
}   

; Implement Vim keybindings in Normal mode
j:: ; Move cursor down
{    
    global vimMode
        if (vimMode == "normal") {
            Send "{Enter}"
        } else {
            SendText "j"
        }
}

k:: ; Move cursor up
{    
    global vimMode
        if (vimMode = "normal") {
            Send "{Up}"
        } else {
            SendText "k"
        }
}

h:: ; Move cursor left
{
    global vimMode
        if (vimMode = "normal") {
            Send "{Left}"
        } else {
            SendText "h"
        }
}

l:: ; Move cursor right
{
    if (vimMode = "normal") {
        Send "{Right}"
    } else {
        Send "l"
    }
}

; Delete character with 'x' in Normal mode
x::
{
    global vimMode
        if (vimMode = "normal") {
            Send "{Del}"
        } else {
            SendText "x"
        }
}

; Yank current line with 'yy'
+y::
{
    global vimMode
        if (vimMode = "normal") {
            ; Send "^a" ; Select all
                Send "{Home}+{End}^c"
                Send "^c" ; Copy to clipboard
                Send "{End}"
        } else {
            Send "+y"
        }
}

; Paste yanked text with 'p'
p::
{
    global vimMode
        if (vimMode = "normal") {
            Send "{Enter}"
                Sleep 100
                Send "^v" ; Paste clipboard content
        } else {
            Send "p"
        }
}

g::
{
    global vimMode
        if (vimMode = "normal") {
            Send "^{Home}"
        } else {
            Send "g"
        }
}


+g::
{
    global vimMode
        if (vimMode = "normal") {
            Send "^{End}"
        } else {
            Send "+g"
        }
}

a::
{
    global vimMode
        if (vimMode = "normal") {
            Send "^a"
        } else {
            Send "a"
        }
}


; Paste yanked text with 'p'
^p::
{
    global vimMode
        if (vimMode = "normal") {
            Send "{Shift}{End}{Up}{Enter}"
                Send "^v" ; Paste clipboard content
        } else {
            Send "p"
        }
}

; Delete current line with 'dd'
d::
{
    global vimMode
        if (vimMode = "normal") {
            Send "{Home}+{End}{Del}" ; Select the current line and delete it
        } else {
            send "d"
        }
}


#HotIf ; End of context-sensitive hotkeys
