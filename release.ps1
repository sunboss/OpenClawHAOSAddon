param(
    [string]$Date = ""
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Versioning rule: YYYY.MM.DD.N
# - First release of a day uses N=1
# - Later releases on the same day increment N
# The script updates both config.yaml and CHANGELOG.md together.
$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$configPath = Join-Path $repoRoot "openclaw_assistant\config.yaml"
$changelogPath = Join-Path $repoRoot "openclaw_assistant\CHANGELOG.md"

if (!(Test-Path $configPath)) {
    throw "Missing file: $configPath"
}
if (!(Test-Path $changelogPath)) {
    throw "Missing file: $changelogPath"
}

$targetDate = if ([string]::IsNullOrWhiteSpace($Date)) {
    Get-Date
} else {
    [datetime]::ParseExact($Date, "yyyy-MM-dd", $null)
}

$datePrefix = $targetDate.ToString("yyyy.MM.dd")
$releaseDate = $targetDate.ToString("yyyy-MM-dd")

$configRaw = Get-Content -Raw $configPath
$versionMatch = [regex]::Match($configRaw, '(?m)^version:\s*"(?<ver>\d{4}\.\d{2}\.\d{2}\.\d+)"\s*$')
if (!$versionMatch.Success) {
    throw "Cannot find version in config.yaml with format YYYY.MM.DD.N"
}

$currentVersion = $versionMatch.Groups["ver"].Value
$parts = $currentVersion.Split(".")
if ($parts.Count -ne 4) {
    throw "Invalid current version format: $currentVersion"
}

$currentPrefix = "{0}.{1}.{2}" -f $parts[0], $parts[1], $parts[2]
$currentN = [int]$parts[3]
$nextN = if ($currentPrefix -eq $datePrefix) { $currentN + 1 } else { 1 }
$newVersion = "$datePrefix.$nextN"

$newConfigRaw = [regex]::Replace(
    $configRaw,
    '(?m)^(version:\s*")\d{4}\.\d{2}\.\d{2}\.\d+("\s*)$',
    ('$1' + $newVersion + '$2'),
    1
)
Set-Content -Path $configPath -Value $newConfigRaw -Encoding UTF8

$changelogRaw = Get-Content -Raw $changelogPath
$sectionHeader = "## [$newVersion] - $releaseDate"
$alreadyExists = [regex]::IsMatch($changelogRaw, "(?m)^## \[$([regex]::Escape($newVersion))\] - ")

if (-not $alreadyExists) {
    $newSection = @"
## [$newVersion] - $releaseDate

### Changed
- Pending release notes.

"@

    $firstVersionHeader = [regex]::Match($changelogRaw, '(?m)^## \[')
    if ($firstVersionHeader.Success) {
        $updatedChangelog =
            $changelogRaw.Substring(0, $firstVersionHeader.Index) +
            $newSection +
            $changelogRaw.Substring($firstVersionHeader.Index)
    } else {
        $updatedChangelog = $changelogRaw.TrimEnd() + "`r`n`r`n" + $newSection
    }

    Set-Content -Path $changelogPath -Value $updatedChangelog -Encoding UTF8
}

Write-Host "Version updated: $currentVersion -> $newVersion"
Write-Host "Updated: $configPath"
Write-Host "Updated: $changelogPath"
