$ErrorActionPreference = 'Stop'

$packagename  = 'python.pypy'
$toolsdir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://downloads.python.org/pypy/pypy2.7-v7.3.19-win64.zip'
$checksum     = 'fbdcd4fe681981c020a25c1a35225209dc3d651f6117ebe9e4d212b66a2b46ec'
$checksumType = 'sha256'

$packageargs = @{
  packagename   = $packagename
  unzipLocation = $toolsdir
  url           = $url
}

Install-ChocolateyZipPackage @packageargs

$files = Get-ChildItem $toolsdir -include *.exe -recurse

foreach ($file in $files) {
    if ($file.Name.Contains("wininst")) {
      New-Item "$file.ignore" -type file -force | Out-Null
    }
}
