$ErrorActionPreference = 'Stop'

$packagename  = 'python.pypy'
$toolsdir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://downloads.python.org/pypy/pypy2.7-v7.3.1-win32.zip'
$checksum     = 'e3c0dfb385d9825dd7723f26576d55d43ed92f1178f2399ab39e9fa11621a47b'
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
