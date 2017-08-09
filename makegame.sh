
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
    -max|--maxbets)
    max="$2"
    shift # past argument
    ;;
    -end|--end)
    end="$2"
    shift # past argument
    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done
echo $pay
echo $bet
echo $gtc
echo $gtl
echo $gtw
echo $pol
echo $pow
echo $slm
echo $swm
echo $sla
echo $swa
echo $slp
echo $swp
echo $max
echo $end
