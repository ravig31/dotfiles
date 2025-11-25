#Requires AutoHotkey v2.0
#SingleInstance Force
Persistent

capslock_on := false

<+RShift::
>+LShift::
{
    global capslock_on
    capslock_on := !capslock_on
    if (capslock_on)
    {
        SetCapsLockState "On"
    }
    else
    {
        SetCapsLockState "Off"
    }
    Return
}
