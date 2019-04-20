
$global:outputstring = $null
$global:TAB = "`t"
$global:header = 0

$global:outputstring = $null

function wr ($toscreen){write-output $toscreen}

# M A S S  functions
# todo:--------------
# -help
# implement backup
# implement comments
# get X block form the TOP
# get X block from the BOTTOM
# return block array with the GET functions
# implement error recognition
# rendere il tutto piu flessibile e dare la possibilità di definire il numero di elementi su ogni linea, separati da TAB
# possibilità di addressare uno specifico block, e uno specifico elemento al suo interno. first block from the top = block[0]
# -------------------

function mass-backup ($filename){} #backs up a file in a timestamped copy

function mass-initBlock (){ # inizializza un block
  $global:header = 1 # il prossimo elemento che viene scritto sarà un block header
}
function mass-addToTOP ($file, $attribute, $value){ # adds an element to the top of the file
  $filecontents = Get-Content -path $file
  Clear-Content -path $file
  if($global:header -eq 1){add-content -path $file -value "$attribute$global:TAB$value"; Add-Content -Path $file -Value ($filecontents); $global:header = 0} # makes an header if the header flag has been set, then resets the flag to 0
  else{ # element will be appended to the first block found from the top
    $i = 0
    $currentline = $filecontents[$i]
    while(($currentline.StartsWith($global:TAB))){$i++; $currentline = $filecontents[$i]}
    add-content -path $file -value $filecontents[0..$i]
    $i++
    $currentline = $filecontents[$i]
    while(($currentline.StartsWith($global:TAB))){add-content -path $file -value $currentline; $i++; $currentline = $filecontents[$i]}
    add-content -path $file -value "$global:TAB$attribute$global:TAB$value"
    add-content -path $file -value $filecontents[$i..($filecontents.count)]
  }
}

function mass-getBlock ($file, $blockNum){}
function mass-deleteBlock ($file, $blockNum){}
function mass-deleteElement ($file, $blockNum, ){}
function mass-swapBlock ($file, $blockNum, $newBlockArray){}

$global:massElement = $null
function mass-getLastBlock ($file){
  $filecontents = Get-Content -path $file
  $currentline = $global:TAB
  $i = 0
  while($currentline.StartsWith($global:TAB)){$i++; $currentline = ($filecontents[($filecontents.count - $i)])}
  $elementfirstline = $filecontents[($filecontents.count - $i)]
  wr("Last block's first element: $elementfirstline")
  $i--
  $currentline = ($filecontents[($filecontents.count - $i)])
  while($currentline.StartsWith($global:TAB) -AND ($filecontents[($filecontents.count - $i)])){$currentline = ($filecontents[($filecontents.count - $i)]); $toprint = $currentLine.trim(); wr($toprint); $i--}
}

function mass-getTopBlock ($file){
  $topBlock = @() # empty array init
  $filecontents = Get-Content -path $file
  $i = 0
  $currentline = $filecontents[$i]
  while(!($currentline.StartsWith($global:TAB))){
    $temp = $currentline.Split($global:TAB)[0]
    $topBlock += $temp
    $temp = $currentline.Split($global:TAB)[1]
    $topBlock += $temp
    $i++
    $currentline = ($filecontents[$i])
  }
  while($currentline.StartsWith($global:TAB)){
    $currentLine = $currentLine.trim() # gets rid of the TAB at the beginning of the line
    $temp = $currentline.Split($global:TAB)[0]
    $topBlock += $temp
    $temp = $currentline.Split($global:TAB)[1]
    $topBlock += $temp
    $i++
    $currentline = ($filecontents[$i])
  }
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
    if($currentline.StartsWith("$global:TAB")){wr("tab found!")}
    if($currentline.StartsWith("  ")){wr("space found!")}
  }
}
$global:outputstring = $null
function mass-1tab ($inputstring){ # prepends a TAB to the input string
  $global:outputstring = "$TAB$inputstring"
}
function mass-2tab ($inputstring){ # prepends a TAB to the input string
  $global:outputstring = "$TAB$TAB$inputstring"
}
function mass-3tab ($inputstring){ # prepends a TAB to the input string
  $global:outputstring = "$TAB$TAB$TAB$inputstring"
}
# M A S S  functions END.

function file-kill-lastline ($file){
  $filecontents = Get-Content -path $file
  Clear-Content -path $file
  $filecontents = $filecontents[0..($filecontents.count - 2)]
  Add-Content -Path $file -Value ($filecontents)
}
