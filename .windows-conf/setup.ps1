# Link-Dotfiles.ps1
# Source of truth: ~/dotfiles

$ErrorActionPreference = "Stop"

$Dotfiles = Join-Path $HOME "dotfiles"

$Links = @(
    @{
        Name   = "PowerShell profile"
        Source = Join-Path $Dotfiles ".windows-conf\powershell\Microsoft.PowerShell_profile.ps1"
        Target = Join-Path $HOME "Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
    },
    @{
        Name   = "psmux config"
        Source = Join-Path $Dotfiles ".config\psmux\psmux.conf"
        Target = Join-Path $HOME ".config\psmux\psmux.conf"
    },
    @{
        Name   = "AutoHotkey rebinds"
        Source = Join-Path $Dotfiles ".windows-conf\ahk\Rebinds.ahk"
        Target = Join-Path $HOME "Documents\AutoHotkey\Rebinds.ahk"
    }
)

foreach ($Link in $Links) {
    Write-Host "`nLinking $($Link.Name)..."

    if (-not (Test-Path $Link.Source)) {
        throw "Source does not exist: $($Link.Source)"
    }

    $TargetDir = Split-Path $Link.Target -Parent
    New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null

    if (Test-Path $Link.Target) {
        $Existing = Get-Item $Link.Target

        if ($Existing.LinkType -eq "SymbolicLink" -and $Existing.Target -eq $Link.Source) {
            Write-Host "Already linked correctly: $($Link.Target)"
            continue
        }

        Write-Host "Removing existing target: $($Link.Target)"
        Remove-Item $Link.Target -Force
    }

    New-Item `
        -ItemType SymbolicLink `
        -Path $Link.Target `
        -Target $Link.Source `
    | Out-Null

    Write-Host "Created symlink:"
    Write-Host "  $($Link.Target) -> $($Link.Source)"
}

Write-Host "`nDone."