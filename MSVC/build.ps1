$visualStudioInstallation = & "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe" -latest -prerelease -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath
$configuration = 'Release'
$platform = 'x64'

$msbuild = Join-Path $visualStudioInstallation 'MSBuild\Current\Bin\MSBuild.exe'
if (-not (test-path $msbuild)) {
    $msbuild = Join-Path $visualStudioInstallation 'MSBuild\15.0\Bin\MSBuild.exe'
    if (-not (test-path $msbuild)) { throw 'Failed to find MSBuild' }
}

& $msbuild fdkaac.vcxproj /p:Configuration=$configuration /p:Platform=$platform /v:minimal
