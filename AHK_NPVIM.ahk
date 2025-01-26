#Requires AutoHotkey v2.0+
Persistent
#SingleInstance

global vimMode := "insert" ; Default mode is Insert

; Monitor if Notepad is active
#HotIf WinActive("ahk_class Notepad")

; Reload the script with a binding
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
; Move cursor down
j:: 
{    
    global vimMode
        if (vimMode == "normal") {
            Send "{Enter}"
        } else {
            SendText "j"
        }
}

; Move cursor up
k:: 
{    
    global vimMode
        if (vimMode = "normal") {
            Send "{Up}"
        } else {
            SendText "k"
        }
}

; Move cursor left
h:: 
{
    global vimMode
        if (vimMode = "normal") {
            Send "{Left}"
        } else {
            SendText "h"
        }
}

; Move cursor right
l:: 
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

; Yank current line with 'Y'
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

; Paste yanked text above current line with 'p'
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

; go to top of the file (gg)
g::
{
    global vimMode
        if (vimMode = "normal") {
            Send "^{Home}"
        } else {
            Send "g"
        }
}

; go to end of the file (G)
+g::
{
    global vimMode
        if (vimMode = "normal") {
            Send "^{End}"
        } else {
            Send "+g"
        }
}

; select all content
a::
{
    global vimMode
        if (vimMode = "normal") {
            Send "^a"
        } else {
            Send "a"
        }
}

; Paste yanked text below current line with 'P'
^p::
{
    global vimMode
        if (vimMode = "normal") {
            Send "{Shift}{End}{Up}{Enter}"
                Send "^v" ; Paste clipboard content
        } else {
            Send "+p"
        }
}

; Delete current line with 'd'
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
