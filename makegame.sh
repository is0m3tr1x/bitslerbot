#!/bin/bash

source config.sh

## is0m3tr1x Dice Configuration Script $version
## contact is0m3tr1x.2017@gmail.com
## repository https://github.com/is0m3tr1x/bitslerbot
## donate 1MN5MBKc7CvkXqsYpFrNmzxS6ZMCE6w4AG

## BASIC ARGUMENTS:
## -pay	--payout		## payout multiplier							##	"balance range=1.0102-9900","faucet range=1.0102-20"
## -bet	--basebet		## inital bet amount							##      (default 0.00000001 )
## -gtc	--gametype		## game type condition 							##	0=high 1=low 2=alternate (default=0)		
## -gtl	--gametypeloss		## game type condition after loss 					##	0=high 1=low 2=alternate (default=0)
## -gtw	--gametypewin		## game type condition after win 					##	0=high 1=low 2=alternate (default=0)
## -pol	--percentonloss		## increase or decrease percent on loss					##	"100=2 * last bet","-50=last bet / 2" (default)
## -pow	--percentonwin		## increase or decrease percent on win					##	"100=2 * last bet","-50=last bet / 2" (default null)
## -max	--maxbets to place	## maximum number of bets 						##	(default infinate)
## -end	--end			## once maximum number of bets is complete finish on 			##	win=0 loss=1 (default 0)
##
## ADVANCED ARGUMENTS REQUIRE GROUPED ARGUMENTS:
## "-slm -sla -slp","-swm -swa -swp"
## -slm	--streaklossmax		## max threshold for streak loss					##	(default null)
## -swm	--streakwinmax		## max threshold for streak win						##	(default null)
## -slp	--streaklosspercent	## increase or decrease percent once max streak loss threshold exceeded ##	requires argument -slm to be defined (default null)
## -swp	--streakwinpercent	## increase or decrease percent once max streak wins threshold exceeded ##	requires argument -swm to be defined (default null)
## -sla	--streaklossaction	## action after max streak loss threshold exceeded			##	(default null)
## -swa	--streakwinaction	## action after max streak win threshold exceeded 			##	(default null)
## DEFINABLE OPTIONS FOR -sla/-swa									##
## 1=increase last bet by % on next loss once then honour %pol						##
## 2=decrease last bet by % on next win once then honour %pow						##
## 3=increase last bet by % on each loss continuosly							##
## 4=decrease last bet by % on each win continuously							##
## example: "./makegame.sh -pay 2 -bet 0.00000001 -gtc 1 -gtl 2 -gtw 2 -pol 100 -max 30"		##
## minimum arguments are -pay -bet otherwise script will throw error					##

if [[ $# -lt 1 ]]; then
echo "No arguments given"
echo "example: ./makegame.sh -pay 2 -bet 0.00000001 -gtc 1 -gtl 2 -gtw 2 -pol 100 -max 30"
echo "Refer to README"
exit 0
else

while [[ $# -gt 1 ]]
do
key="$1"
 
case $key in
    -pay|--payout)
    pay="$2"
    shift # past argument
    ;;
    -bet|--basebet)
    bet="$2"
    shift # past argument
    ;;
    -gtc|--gametype)
    gtc="$2"
    shift # past argument
    ;;
    -gtl|--gametypeloss)
    gtl="$2"
    shift # past argument
    ;;
    -gtw|--gametypewin)
    gtw="$2"
    shift # past argument
    ;;
    -pol|--percentonloss)
    pol="$2"
    shift # past argument
    ;;
    -pow|--percentonwin)
    pow="$2"
    shift # past argument
    ;;
    -slm|--streaklossmax)
    slm="$2"
    shift # past argument
    ;;
    -swm|--streakwinmax)
    swm="$2"
    shift # past argument
    ;;
    -sla|--streaklossaction)
    sla="$2"
    shift # past argument
    ;;
    -swa|--streakwinaction)
    swa="$2"
    shift # past argument
    ;;
    -slp|--streaklosspercent)
    slp="$2"
    shift # past argument
    ;;
    -swp|--streakwinpercent)
    swp="$2"
    shift # past argument
    ;;
    -max|--maxbets)
    max="$2"
    shift # past argument
    ;;
    -end|--end)
    end="$2"
    shift # past argument
    ;;
    *)
    ;;
esac
shift # past argument or value
done
if [ ! -a "$pay" ] && [ ! -a "$bet" ]; then
echo "Exiting not enough arguments"
echo "Requires atleast -pay -bet to be set"
exit 0
fi
echo "Configuration successful"
echo -en "Export configuration to strategy folder? [y/n]"
read -r yn1
if [ "$yn1" = 'y' ]; then
echo -en "Save strategy as... :"
read -r name
echo "Saving strategy as $name in ./strategies/"
echo "pay=$pay" >  "./strategies/$name"
echo "bet=$bet" >> "./strategies/$name"
echo "gtc=$gtc" >> "./strategies/$name"
echo "gtl=$gtl" >> "./strategies/$name"
echo "gtw=$gtw" >> "./strategies/$name"
echo "pol=$pol" >> "./strategies/$name"
echo "pow=$pow" >> "./strategies/$name"
echo "slm=$slm" >> "./strategies/$name"
echo "swm=$swm" >> "./strategies/$name"
echo "sla=$sla" >> "./strategies/$name"
echo "swa=$swa" >> "./strategies/$name"
echo "slp=$slp" >> "./strategies/$name"
echo "swp=$swp" >> "./strategies/$name"
echo "max=$max" >> "./strategies/$name"
echo "end=$end" >> "./strategies/$name"
else
echo "Exiting without saving strategy"
exit 0
fi
fi
