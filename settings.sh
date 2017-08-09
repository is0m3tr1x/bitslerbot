## is0m3tr1x Bitsler Bot Game Settings File
## -p gametype multiplier
## -b basebet
## -gt bet hi/lo/alt
## -gtl hi/lo/alt
## -gtw hi/lo/alt
## -pol % to increase decrease bet on loss
## -pow % to increase decrease bet on win
## -swm 0-9 set max win streak then reset to base
## -slm 0-9 set max loss streak then reset to base
## -max 1-999999 set max bets
## -end win/loss

p="2" 			## odds + win multiplier
b="0.00000002"		## base bet (initial + return to base)
gt="hi"			## game type higher then number
gtl="hi"		## on loss switch to this game type
gtw="hi"		## on win switch to this game type
pol="0"			## % to increase/decrease on loss -20
pow="0"			## % to increase/decrease on win 30
slm="0"			## max streak loss threshold
swm="0"			## max streak wins threshhold
sla="0"			## action once max loss threshold exceeded
swa="0"			## action once max win threshold exceeded
max="100"		## maximum number of bets
end="win"		## continue past maximum number of bets until win/lose
