$ErrorActionPreference = 'Stop'

$packagename  = 'pypy3'
$toolsdir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://downloads.python.org/pypy/pypy3.10-v7.3.19-win64.zip'
$checksum     = 'c0d07bba6c8fb4e5804f4a8b3f8ef07cc3d89f6ad1db42a45ffb9be60bbb7cc2'
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
