<#
Created:    2015-02-03
Updated:    2020-01-21
Version:    1.1
Author :    Peter Lofgren
Twitter:    @LofgrenPeter
Blog   :    http://syscenramblings.wordpress.com

Disclaimer:
This script is provided "AS IS" with no warranties, confers no rights and
is not supported by the author

Updates
1.0 - Initial release
1.1 - Update to not includ manifest.xml

License:

The MIT License (MIT)

Copyright (c) 2015 Peter Lofgren

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

.Synopsis
   Import GPOs
.DESCRIPTION
   Import all GPOs from a backup source.
.EXAMPLE
   Import-GPO -Source C:\GpoBackup
#>

[CmdletBinding()]
Param (
  [Parameter(Mandatory=$true)]
  $Source
)

Try {
  Write-Host "Verifying Source"
  $Policys = Get-ChildItem $Source | Where-Object Name -NE "manifest.xml"
}
Catch {
  $ErrorMsg = $_.Exception.Message
  Write-Host "Error: $ErrorMsg"
  Break
}

Try{ 
  Write-Host "Importing Policys"
  Foreach ($Policy in $Policys) {
    Write-Output $Policy.FullName
    $Name = (([xml]$xml = Get-Content "$($Policy.FullName)\gpreport.xml").GPO).Name
    Import-GPO -BackupGpoName $Name -TargetName $Name -Path $(Split-Path $Policy.FullName) -CreateIfNeeded
  }
}
Catch {
  $ErrorMsg = $_.Exception.Message
  Write-Host "Error: $ErrorMsg"
  Break
}

