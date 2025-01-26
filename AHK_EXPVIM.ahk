#Requires AutoHotkey v2.0+
Persistent
#SingleInstance

global vimMode := "insert" ; Default mode is Insert


Sleep 5600
Run '"explorer.exe" "C:\Users\rajay\Downloads\"'
Sleep 1600
Run '"explorer.exe" "C:\Users\rajay\Pictures\Screenshots\Screenshots"'
Sleep 1600
Run '"explorer.exe" A_Desktop'
Sleep 1600
Run "explorer.exe"
Sleep 1600

; Monitor if Notepad is active
#HotIf WinActive("ahk_exe explorer.exe")

~!r::Reload

; Switch to Normal mode with Esc
~Esc::
{    
    global vimMode
    vimMode := "normal"
    Tooltip vimMode, 1740, 966
}

; Switch to Insert mode with 'i'
i::
{
    global vimMode
        if (vimMode == "normal") {
            vimMode := "insert"
            Tooltip vimMode, 1740, 966
            } else {
                SendText "i" ; Let 'i' work as usual in Insert mode
        }
}   

; Implement Vim keybindings in Normal mode
j:: ; Move cursor down
{    
    global vimMode
        if (vimMode == "normal") {
            Send "+{Down}"
        } else {
            SendText "j"
        }
}

k:: ; Move cursor up
{    
    global vimMode
        if (vimMode = "normal") {
            Send "+{Up}"
        } else {
            SendText "k"
        }
}

f::
{
    global vimMode
        if (vimMode = "normal") {
            Send "^f"
        } else {
            Send "f"
        }
}

; Delete character with 'x' in Normal mode
x::
{
    global vimMode
        if (vimMode = "normal") {
            Send "^x"
        } else {
            SendText "x"
        }
}

; Yank current line with 'yy'
c::
{
    global vimMode
        if (vimMode = "normal") {
            Send "^c" ; Copy to clipboard
        } else {
            Send "c"
        }
}

v::
{
    global vimMode
        if (vimMode = "normal") {
            Sleep 100
            Send "^v" 
        } else {
            Send "v"
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

d::
{
    global vimMode
        if (vimMode = "normal") {
            Send "+{Del}" 
        } else {
            send "d"
        }
}


n::
{
    global vimMode
        if (vimMode = "normal") {
            Send "^+n"
        } else {
            Send "n"
        }
}

#HotIf ; End of context-sensitive hotkeys
