$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Resolve-Path (Join-Path $ScriptDir "..")
$Readme = Join-Path $RepoRoot "README.md"

$checks = @(
  @{ Package = "next"; Label = "Next.js"; Expected = "16.1" },
  @{ Package = "typescript"; Label = "TypeScript"; Expected = "5.9" },
  @{ Package = "tailwindcss"; Label = "Tailwind CSS"; Expected = "4.1" }
)

$pass = 0
$fail = 0

Write-Host "Checking stack versions in README against npm..."
Write-Host ""

foreach ($check in $checks) {
  $live = ""
  try {
    $live = (npm show $check.Package version).Trim()
  }
  catch {
    Write-Host "⚠️  $($check.Label) ($($check.Package)): unable to fetch npm version"
    $fail++
    continue
  }

  $readmeText = Get-Content $Readme -Raw

  if ($readmeText -match [regex]::Escape("$($check.Label) $live")) {
    Write-Host "✅ $($check.Label): README has exact latest ($live)"
    $pass++
  }
  elseif ($readmeText -match [regex]::Escape("$($check.Label) $($check.Expected)")) {
    if ($live.StartsWith($check.Expected)) {
      Write-Host "✅ $($check.Label): README has $($check.Expected) and npm is $live"
      $pass++
    }
    else {
      Write-Host "⚠️  $($check.Label): README has $($check.Expected), npm is $live"
      $fail++
    }
  }
  else {
    Write-Host "❌ $($check.Label): README version not found in expected format; npm is $live"
    $fail++
  }
}

Write-Host ""
if ($fail -eq 0) {
  Write-Host "All checks passed."
  exit 0
}
else {
  Write-Host "$pass passed, $fail need attention."
  exit 1
}
