## is0m3tr1x Dice Default Configuration
## contact is0m3tr1x.2017@gmail.com
## repository https://github.com/is0m3tr1x/bitslerbot
## donate 1MN5MBKc7CvkXqsYpFrNmzxS6ZMCE6w4AG

## BASIC ARGUMENTS:
## -pay	--payout		## payout multiplier							##	"balance range=1.0102-9900","faucet range=1.0102-20"
## -bet	--basebet		## inital bet amount							##      (default 0.00000001 )
## -gtc	--gametype		## game type condition 							##	0=high 1=low 2=alternate (default=0)		
## -gtl	--gametypeloss		## game type condition after loss 					##	0=high 1=low 2=alternate (default=0)
## -gtw	--gametypewin		## game type condition after win 					##	0=high 1=low 2=alternate (default=0)
## -pol	--percentonloss		## increase or decrease percent on loss					##	"100=2 * last bet","-50=last bet / 2" (default null)
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

pay=2
bet=0.0000001
gtc=0
gtl=0
gtw=0
pol=125
pow=-50
max=100
end=win
slm=
swm=
sla=
swa=
slp=
swp=
