[CmdletBinding()]
param(
    [string]$Root = ''
)

$ErrorActionPreference = 'Stop'

if ([string]::IsNullOrWhiteSpace($Root)) {
    $scriptDir = Split-Path -Parent $PSCommandPath
    $Root = Join-Path $scriptDir '..'
}

$resolvedRoot = Resolve-Path -LiteralPath $Root -ErrorAction Stop
if (-not (Test-Path -LiteralPath $resolvedRoot.Path -PathType Container)) {
    Write-Error "Root is not a directory: $($resolvedRoot.Path)"
    exit 1
}
$rootPath = $resolvedRoot.Path.TrimEnd('\', '/')

$files = New-Object System.Collections.Generic.List[string]
foreach ($item in @(Get-ChildItem -LiteralPath $rootPath -Filter '*.md' -File -ErrorAction SilentlyContinue)) {
    $files.Add($item.FullName)
}
$docsPath = Join-Path $rootPath 'docs'
if (Test-Path -LiteralPath $docsPath -PathType Container) {
    foreach ($item in @(Get-ChildItem -LiteralPath $docsPath -Filter '*.md' -File -Recurse -ErrorAction SilentlyContinue)) {
        $files.Add($item.FullName)
    }
}

$unique = New-Object System.Collections.Generic.List[string]
$seen = New-Object 'System.Collections.Generic.HashSet[string]' ([System.StringComparer]::OrdinalIgnoreCase)
foreach ($f in $files) {
    if ($seen.Add($f)) { $unique.Add($f) }
}

$linkPattern = [regex]'!?\[[^\]]*\]\(([^)]+)\)'
$checked = 0
$missing = New-Object System.Collections.Generic.List[string]

foreach ($file in $unique) {
    $text = Get-Content -LiteralPath $file -Encoding UTF8
    $inFence = $false
    $lineNumber = 0
    foreach ($line in $text) {
        $lineNumber++
        $trimmed = $line.TrimStart()
        if ($trimmed.StartsWith('```')) {
            $inFence = -not $inFence
            continue
        }
        if ($inFence) { continue }

        foreach ($match in $linkPattern.Matches($line)) {
            $raw = $match.Groups[1].Value.Trim()
            if ($raw.StartsWith('<') -and $raw.EndsWith('>')) {
                $raw = $raw.Substring(1, $raw.Length - 2).Trim()
            }
            if ($raw -match '^(?i)(https?://|mailto:)') { continue }
            if ($raw.StartsWith('#')) { continue }

            $target = $raw
            $hashIndex = $target.IndexOf('#')
            if ($hashIndex -ge 0) { $target = $target.Substring(0, $hashIndex) }
            $queryIndex = $target.IndexOf('?')
            if ($queryIndex -ge 0) { $target = $target.Substring(0, $queryIndex) }
            $target = $target.Trim()
            if ([string]::IsNullOrWhiteSpace($target)) { continue }
            if ($target -match '^<.*>$') { continue }

            $checked++
            if ([System.IO.Path]::IsPathRooted($target)) {
                $candidate = $target
            } else {
                $candidate = Join-Path (Split-Path -Parent $file) $target
            }
            try {
                $full = [System.IO.Path]::GetFullPath($candidate)
            } catch {
                $missing.Add("$file : line $lineNumber : $raw")
                continue
            }
            if (-not (Test-Path -LiteralPath $full)) {
                $missing.Add("$file : line $lineNumber : $raw")
            }
        }
    }
}

if ($checked -eq 0) {
    Write-Output "Documentation links check failed: no links found in $($unique.Count) files"
    exit 1
}

if ($missing.Count -gt 0) {
    Write-Output "Documentation links check failed: $($missing.Count) missing target(s)"
    foreach ($m in $missing) {
        Write-Output "MISSING $m"
    }
    exit 1
}

Write-Output "Documentation links OK: $($unique.Count) files, $checked links"
exit 0