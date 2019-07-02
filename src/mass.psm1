
$global:outputstring = $null
$global:TAB = "`t"
$global:DELIM = "` ` "
$global:header = 0

$global:outputstring = $null

function wr ($toscreen){write-output $toscreen}

# M A S S  functions
# TODO:--------------
# -help
# implement backup
# implement comments
# get X block from the TOP
# get X block from the BOTTOM
# return block array with the GET functions
# implement error recognition
# rendere il tutto piu flessibile e dare la possibilità di definire il numero di elementi su ogni linea, separati da TAB
# possibilità di addressare uno specifico block, e uno specifico elemento al suo interno. first block from the top = block[0]
# piu flessibilità, tipo possibilità di creare separatori ulteriori nella parte "value", che vengono hardcodati nel file stesso. supermodular!
# mettere ignore per javascript header
# -------------------



function mass-initBlock (){ # block initialization - might be rendered useless in future development
  $global:header = 1 # with the HEADER flag = 1, the first element that will be written after this instruction will be an header
}
function mass-addToTOP ($file, $attribute, $value){ # adds an element to the top of the file
  $filecontents = Get-Content -path $file
  Clear-Content -path $file
  if($global:header -eq 1){add-content -path $file -value "$attribute$global:TAB$value"; Add-Content -Path $file -Value ($filecontents); $global:header = 0} # makes an header if the header flag has been set, then resets the flag to 0
  else{ # element will be appended to the first block found from the top
    $i = 0
    $currentline = $filecontents[$i]
    while(($currentline.StartsWith($global:DELIM))){$i++; $currentline = $filecontents[$i]}
    add-content -path $file -value $filecontents[0..$i]
    $i++
    $currentline = $filecontents[$i]
    while(($currentline.StartsWith($global:DELIM))){add-content -path $file -value $currentline; $i++; $currentline = $filecontents[$i]}
    add-content -path $file -value "$global:DELIM$attribute$global:DELIM$value"
    add-content -path $file -value $filecontents[$i..($filecontents.count)]
  }
}

# -------------------------------------- TO MAKE!!!!
function mass-backup ($filename){} #backs up a .MASS file in a timestamped copy

function mass-makeElement {
  Param(
    [Parameter(Mandatory=$True)]
    $attributeName,
    [Parameter(Mandatory=$False)]
    $blockNum
  )
}

function mass-getBlock {
  Param(
    [Parameter(Mandatory=$True)]
    $file, $blockNum
    )
}
function mass-deleteBlock {
  Param(
    [Parameter(Mandatory=$True)]
    $file, $blockNum
    )
}
function mass-deleteElement {
  Param(
    [Parameter(Mandatory=$True)]
    $file, $blockNum, $elemNum
    )
}
function mass-swapBlock {
 Param(
   [Parameter(Mandatory=$True)]
   $file, $blockNum, $elemNum, $newBlockArray
   )
}
# -------------------------------------- TO MAKE!!!! END. (See also "todo")


$global:massElement = $null
function mass-getLastBlock ($file){
  $filecontents = Get-Content -path $file
  $currentline = $global:DELIM
  $i = 0
  while($currentline.StartsWith($global:DELIM)){$i++; $currentline = ($filecontents[($filecontents.count - $i)])}
  $elementfirstline = $filecontents[($filecontents.count - $i)]
  wr("Last block's first element: $elementfirstline")
  $i--
  $currentline = ($filecontents[($filecontents.count - $i)])
  while($currentline.StartsWith($global:DELIM) -AND ($filecontents[($filecontents.count - $i)])){$currentline = ($filecontents[($filecontents.count - $i)]); $toprint = $currentLine.trim(); wr($toprint); $i--}
}

function mass-getTopBlock ($file, $debug){
  $topBlock = @() # empty array init
  $filecontents = Get-Content -path $file
  $i = 0
  $currentline = $filecontents[$i]
  while(!($currentline.StartsWith($global:DELIM))){
    if($debug){wr("Header: $i - $currentline"); wr("")} # debug
    $temp = $currentline.Split($global:DELIM)[0]
    $topBlock += $temp
    $temp = $currentline.Split($global:DELIM)[1]
    $topBlock += $temp
    $i++
    $currentline = ($filecontents[$i])
  }
  while($currentline.StartsWith($global:DELIM)){
    if($debug){wr("Non-header: $i - $currentline"); wr("")} # debug
    $currentLine = $currentLine.trim() # gets rid of the DELIM at the beginning of the line
    $temp = $currentline.Split($global:DELIM)[0]
    $topBlock += $temp
    $temp = $currentline.Split($global:DELIM)[1]
    $topBlock += $temp
    $i++
    $currentline = ($filecontents[$i])
  }
  if($debug){wr("-------------<<< end of DEBUG <<<"); wr("")}
  return $topBlock
}

function mass-test (){
  $testfile = "R:\scripts\gaia\bho.MASS"
  $filecontents = Get-Content -path $testfile
  $currentline = $null
  $roba = "blabla"
  mass-2tab ($roba)
  add-content -path $testfile -value $global:outputstring
  foreach ($currentline in $filecontents) # looping on array
  {
    if($currentline.StartsWith("$global:DELIM")){wr("DELIM found!")}
    if($currentline.StartsWith("  ")){wr("space found!")}
  }
}
$global:outputstring = $null
function mass-1tab ($inputstring){ # prepends a DELIM to the input string
  $global:outputstring = "$DELIM$inputstring"
}
function mass-2tab ($inputstring){ # prepends 2 DELIMs to the input string
  $global:outputstring = "$DELIM$DELIM$inputstring"
}
function mass-3tab ($inputstring){ # prepends 3 DELIMs to the input string
  $global:outputstring = "$DELIM$DELIM$DELIM$inputstring"
}
# M A S S  functions END.

function file-kill-lastline ($file){
  $filecontents = Get-Content -path $file
  Clear-Content -path $file
  $filecontents = $filecontents[0..($filecontents.count - 2)]
  Add-Content -Path $file -Value ($filecontents)
}
