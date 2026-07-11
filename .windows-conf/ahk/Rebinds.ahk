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

*CapsLock::
{
    Send "{LControl down}"
}

*CapsLock up::
{
    Send "{LControl Up}"

    if (A_PriorKey=="CapsLock"){
	if (A_TimeSincePriorHotkey < 1000)
		Suspend "1"
		Send "{Esc}"
		Suspend "0"
	}
}

!q::Send "!{F4}"
