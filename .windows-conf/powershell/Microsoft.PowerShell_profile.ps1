Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
refreshenv

$env:Path += ";C:\ProgramData\chocolatey\bin"

Set-PSReadlineKeyHandler -Key Tab -Function Complete

# Basic aliases
Set-Alias touch ni
Set-Alias ll  Get-ChildItem
function la {Get-ChildItem -Force}

# Custom commands
Set-Alias vim nvim
function zz { nvim $PROFILE }

# git-aliases
Import-Module git-aliases -DisableNameChecking

oh-my-posh init pwsh --config 'spaceship' | Invoke-Expression
