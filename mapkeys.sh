#!/bin/bash

# https://apple.stackexchange.com/questions/4813/changing-modifier-keys-from-the-command-line/277544#277544
# https://apple.stackexchange.com/questions/13598/updating-modifier-key-mappings-through-defaults-command-tool

lctrl=30064771296
rctrl=30064771300
lcmd=30064771299
rcmd=30064771303
loption=30064771298
roption=30064771302

appleidVendor=1133
appleidProduct=50475
logitechidVendor=1133
logitechidProduct=50475
drewidVendor=1452
drewidProduct=544

function map_these {
    idVendor=$1
    idProduct=$2
    mappingplist=com.apple.keyboard.modifiermapping.$idVendor-$idProduct-0

    mapping=""
    while (( $# > 2 )); do
	shift 2
	mapping="$mapping <dict><key>HIDKeyboardModifierMappingSrc</key><integer>$1</integer><key>HIDKeyboardModifierMappingDst</key><integer>$2</integer></dict>"
    done
    
    defaults -currentHost write -g "$mappingplist" -array $mapping
}

map_these $appleidVendor $appleidProduct \
	  $lcmd $lctrl \
	  $rcmd $roption \
	  $loption $lcmd \
	  $roption $rcmd

map_these $logitechidVendor $logitechidProduct \
	  $loption $lctrl

map_these $drewidVendor $drewidProduct \
	  $lcmd $lctrl \
	  $rcmd $roption \
	  $loption $lcmd \
	  $roption $rcmd

defaults -currentHost read -g "$mappingplist"
echo Keys set, reboot or relogin required.
