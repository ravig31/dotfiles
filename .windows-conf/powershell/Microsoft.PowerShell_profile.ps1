Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
refreshenv

# new symlink
function New-SymbolicLink ($Path, $Target) { 
    New-Item -Path $Path -ItemType SymbolicLink -Value $Target 
}
Set-Alias -Name ln -Value New-SymbolicLink

#psmux
function pmuxconf(){
	vim "~/.config/psmux/psmux.conf"
}

function pyini() {
	vim "~/AppData/Local/py.ini"
}

function shellagain() {
	.$PROFILE
}

$env:Path += ";C:\ProgramData\chocolatey\bin"

# # kubectl 
# . "$(Split-Path -Path $PROFILE)\kubectl_aliases.ps1"
# function kalias() { cat "$(Split-Path -Path $PROFILE)\kubectl_aliases.ps1"}
# kubectl completion powershell | Out-String | Invoke-Expression
#

function klon() {
    param(
        [string]$ns = "default",
        [Parameter(ValueFromRemainingArguments = $true)]
        $args
    )

    $pod = kgpon $ns --no-headers -o custom-columns=":metadata.name" | fzf

    kubectl logs -n $ns $pod @args -f
}

function kcuc() {
		kubectl config get-contexts --no-headers -o name |
				fzf | 
				ForEach-Object { kubectl config use-context $_ }
}

function kpfn() {
	param([string]$ns = "default")
	kubectl port-forward -n $ns $args
}

function kcgc() {
	kubectl config get-contexts
}

# New vs user prompt
function nuserprompt {
    param([string]$Name = "default")
    
    $Path = "$env:APPDATA\Code\User\prompts\$Name.prompt.md"
    
    $null = New-Item -Path $Path -ItemType File -Force
    code $Path
}

# Basic aliases
Set-Alias touch ni
Set-Alias ll  Get-ChildItem
function la {Get-ChildItem -Force}

# Custom commands
Set-Alias vim nvim
function zz { nvim $PROFILE }

# git-aliases
Import-Module git-aliases -DisableNameChecking
function galias(){
	Get-Git-Aliases | fzf
}

# poshgit 
Import-Module posh-git

# PSReadLine
Set-PSReadlineKeyHandler -Key Tab -Function Complete

# omp
oh-my-posh init pwsh --config "~\dotfiles\.windows-conf\spaceship_custom.omp.json" | Invoke-Expression

# #poetry
# if (-not (Get-Command poetry -ErrorAction Ignore)) { $env:Path += ";C:\Users\A30024524\AppData\Roaming\Python\Scripts" }
#
# #uv
# if (!(Test-Path -Path $PROFILE)) {
#   New-Item -ItemType File -Path $PROFILE -Force
# }
# (& uv generate-shell-completion powershell) | Out-String | Invoke-Expression
#
# remove aliases
Remove-Item Alias:diff -Force -ErrorAction SilentlyContinue
Remove-Item Alias:rm -Force -ErrorAction SilentlyContinue
Remove-Item Alias:tree -Force -ErrorAction SilentlyContinue

