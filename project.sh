## max potential loss calculator
## progressive compounded wagered calculations
## payout @ nth iterations for preceeding wagered amount
## this calculator takes the following 4 arguments
## $1 = odds
## $2 = multiplier
## $3 = the odds or game type
## $4 = the initial bet amount to calculate from


odds="$1"
mult="$2"
iter="$3"
base="$4"
bal="$5"
bet=1

if [ ! $@ ]; then
echo "Usage......"
echo '$1 = odds'
echo '$2 = multiplier'
echo '$3 = amount of consecutive losses to factor'
echo '$4 = the initial bet amount to calculate from'
echo '$5 = balance to stop on'
echo 'example ./project.sh 2 205 16 0.0000100'
exit 0
else
echo "is0lvlEtr1x..."
echo "INiTiAL BET = $base"
echo "WAGERED AMOUNT ~ PAYOUT ~ PROFIT"
#while [ "$bal" -gt "$base" ]; do
until [ $iter = "0" ]; do
base=$(echo "scale=10; $base + ($base * ($mult / 100))" | bc)
iter=$(echo "$iter - 1" | bc)
bet=$(echo "$bet + 1" | bc)
return=$(echo "scale=10; $base * $odds" | bc)
profit=$(echo "scale=10; $return - $base" | bc)
echo "$bet $base -> $return -> $profit"
done
#done
echo "TOTAL BALANCE REQUIRED FOR $bet CONSECUTIVE LOSSES @ ODDS=$odds LOSS MULTIPLIER=$mult BALANCE:$base"
fi
