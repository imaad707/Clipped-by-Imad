$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem
$bundle = Join-Path ([IO.Path]::GetTempPath()) ([guid]::NewGuid().ToString() + ".zip")
$outputDir = Join-Path $PSScriptRoot "dist"
New-Item -ItemType Directory -Force $outputDir | Out-Null
try {
    $zip = [IO.Compression.ZipFile]::Open($bundle, 'Create')
    try {
        $files = @(Get-ChildItem "$PSScriptRoot/app" -Recurse -File | Where-Object { $_.Extension -ne ".pyc" })
        $files += Get-Item "$PSScriptRoot/LICENSE","$PSScriptRoot/THIRD-PARTY-NOTICES.txt","$PSScriptRoot/requirements.txt"
        foreach ($item in $files) {
            $entry = $item.FullName.Substring($PSScriptRoot.Length + 1).Replace('\','/')
            [void][IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $item.FullName, $entry)
        }
    } finally { $zip.Dispose() }
    $compiler = "$env:WINDIR\Microsoft.NET\Framework64\v4.0.30319\csc.exe"
    & $compiler /nologo /target:winexe /platform:x64 "/win32icon:$PSScriptRoot\windows\clipped.ico" "/out:$outputDir\ClippedSetup.exe" /r:System.Windows.Forms.dll /r:System.Drawing.dll /r:System.IO.Compression.dll /r:System.IO.Compression.FileSystem.dll /r:Microsoft.CSharp.dll "/resource:$bundle,studio.zip" "$PSScriptRoot\windows\Studio.cs" "$PSScriptRoot\windows\SetupForm.cs"
    if ($LASTEXITCODE) { throw "Installer build failed" }
} finally { if (Test-Path $bundle) { Remove-Item -LiteralPath $bundle } }
