## is0m3tr1x Bitsler Bot v1.0
## contact is0m3tr1x.2017@gmail.com
## repository https://github.com/is0m3tr1x/bitslerbot
## donate 1MN5MBKc7CvkXqsYpFrNmzxS6ZMCE6w4AG

source "config.sh"

## check login & get balance
if [ $token ]; then
echo -e "$white ###############################"
echo -e "$white   is0m3tr1x Bitsler Bot $version"
echo -e "$white ###############################"
echo -e "$yellow   CHECK?$red $user$green token"

## post null bet for token auth and balance
infostring="access_token=$token&username=$user&type=dice&amount=0.00000001&condition=$gt&game=1.1&devise=btc"
curl $timeout -s 'https://www.bitsler.com/api/bet' -H 'origin: https://www.bitsler.com' -H 'accept-encoding: gzip, deflate, br' \
-H 'x-requested-with: XMLHttpRequest' -H 'accept-language: en-GB,en-US;q=0.8,en;q=0.6' -H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' \
-H 'accept: */*' -H 'referer: https://www.bitsler.com/play/dice' -H 'authority: www.bitsler.com' --data "$infostring" --compressed > "$resp1"

## parse bet response and get variables

if [ -s $resp1 ]; then
	test1=$(cat $resp1 | cut -d: -f3 | cut -d, -f1 | sed 's/"//g')
  if [ $test1 = true ]; then
	startbal=$(cat $resp1 | cut -d: -f19 | cut -d, -f1 | sed 's/"//g')
echo -e "$green SUCCESS!$green BALANCE is$blue $startbal"
echo -e "$white ###############################"
  elif [ $test1 = false ]; then
	test2=$(cat $resp1 | cut -d: -f4 | cut -d, -f1 | awk '{print $1}' | sed 's/"//g')
  if [ $test2 = "Insufficient" ]; then
	echo -e "$red BALANCE ERROR!$green NOT ENOUGH FUNDS"
  elif [ $test2 = "Access" ]; then
        echo -e "$red TOKEN ERROR!$green USER$blue $user"
  fi
echo -e "$white ############################### "
  fi
else
	echo -e "$red CANNOT CONNECT TO BITSLER API"
	exit 0
fi

## login confirmed now lets configure our game

if [ -r $settings ]; then
echo -en "$green LOAD PREVIOUSLY SAVED SETTINGS?: [y/n] "
read setting
if [ "$setting" = 'y' ]; then
	for line in $(tail -n $lines $settings); do
	echo " $line"
	done
	echo -en "$green GAME CONFIG LOADED CONFIRM SETTINGS: [y/n] "
	read confirm
	if [ "$confirm" = 'y' ]; then
		echo -e "$green GAME CONFIG CONFIRMED"
	else
		echo -e "$red GAME CONFIG NOT LOADED"
	fi

elif [ "$setting" = 'n' ]; then
echo -e	"$green GENERATING NEW SETTINGS?"
fi
else
echo -e "$green SETUP DESIRED CONFIG"
fi

fi


## get configuration and adjust next bet accordingly

modifybet() {

## log max streaks for this game to odds folder

if [ $streakloss -gt $(cat $oddsdb/$p.l) ]; then
	echo $streakloss > $odddb/$p.l
	echo "$date NEW HIGH LOSS STREAK MAX FOR ODDS $p" >> $syslog
elif [ $streakwin -gt $(cat $oddsdb/$p.w) ]; then
	echo $streakwin > $oddsdb/$p.w
	echo "$date NEW HIGH WIN STREAK FOR ODDS $p" >> $syslog

## streak threshold exceeded actions

elif [ $slm -gt 0 ] && [ $streakloss = $slm ]; then
	if [ $sla -gt 0 ]; then
		if [ $sla = 1 ] && [ $slp ]; then
		newbet=$(echo "$date scale=8;$lastbet + ( $lastbet * ( $slp / 100 ))" | bc)
		echo "$date STREAK LOSS REACHED $streakloss INCREASING BET ON LOSS BY $slp ONCE" >> $syslog
		elif [ $sla = 2 ] && [ $slp ]; then
		newbet=$(echo "$date scale=8;$lastbet - ( $lastbet * ( $slp / 100 ))" | bc)
		echo "$date STREAK LOSS REACHED $streakloss DECREASING BET ON WIN BY $slp ONCE" >> $syslog
		elif [ $sla = 3 ] && [ $slp ]; then
		newbet=$(echo "$date scale=8;$lastbet + ( $lastbet * ( $slp / 100 ))" | bc)
		echo "$date STREAK LOSS REACHED $streakloss INCREASING BET ON LOSS BY $slp FROM NOW ON" >> $syslog
		elif [ $sla = 4 ] && [ $slp ]; then
		newbet=$(echo "$date scale=8;$lastbet + ( $lastbet * ( $slp / 100 ))" | bc)
		echo "$date STREAK LOSS REACHED $streakloss INCREASING BET ON WIN BY $slp FROM NOW ON" >> $syslog
		elif [ $sla ] && [ !-a $slp ]; then
		newbet=$base
		echo "$date STREAK LOSS THRESHOLD OF $streakloss REACHED NO RATE DEFINED RESETTING TO BASE" >> $syslog
		fi
	else
	echo "$date STREAK LOSS THRESHOLD OF $streakloss REACHED ACTION NOT DEFINED RESETTING TO BASE" >> $syslog
	newbet=$base
elif [ $swm -gt 0 ] && [ $streakwin = $swm ]; then
	if [ $swa -gt 0 ]; then
		if [ $swa = 1 ] && [ $swp ]; then
		newbet=$(echo "$date scale=8;$lastbet + ( $lastbet * ( $swp / 100 ))" | bc)
		echo "$date STREAK WIN REACHED $streakwin INCREASING BET ON LOSS BY $swp ONCE" >> $syslog
		elif [ $swa = 2 ] && [ $swp ]; then
		newbet=$(echo "$date scale=8;$lastbet - ( $lastbet * ( $swp / 100 ))" | bc)
		echo "$date STREAK WIN REACHED $streakwin DECREASING BET ON WIN BY $swp ONCE" >> $syslog
		elif [ $swa = 3 ] && [ $swp ]; then
		newbet=$(echo "$date scale=8;$lastbet + ( $lastbet * ( $swp / 100 ))" | bc)
		echo "$date STREAK WIN REACHED $streakwin INCREASING BET ON LOSS BY $swp FROM NOW ON" >> $syslog
		elif [ $swa = 4 ] && [ $swp ]; then
		newbet=$(echo "$date scale=8;$lastbet + ( $lastbet * ( $swp / 100 ))" | bc)
		echo "$date STREAK WIN REACHED $streakwin INCREASING BET ON WIN BY $swp FROM NOW ON" >> $syslog
		elif [ $swa ] && [ !-a $swp ]; then
		newbet=$base
		echo "$date STREAK WIN THRESHOLD OF $streakwin REACHED NO RATE DEFINED RESETTING TO BASE" >> $syslog
		fi
	else
	echo "$date STREAK WIN THRESHOLD OF $streakwin REACHED ACTION NOT DEFINED RESETTING TO BASE" >> $syslog
	newbet=$base
fi

## hi or lo condition implementation

if [ $gt ]; then
	if [ $gt = 0 ]; then
	hilo=0
	echo "$date HI/LO SET TO HIGH" >> $syslog
	elif [ $gt = 1 ]; then
	hilo=1
	echo "$date HI/LO SET TO LOW" >> $syslog
	elif [ $gt = 2 ]; then
		if [ $hilo = true ]; then
		hilo=1
		echo "$date HI/LO SET TO ALTERNATE NOW LOW" >> $syslog
		else
		hilo=0
		echo "$date HI/LO SET TO ALTERNATE NOW HIGH" >> $syslog
		fi
	else
	echo "$date HI/LO SETTINGS NOT SET WILL DEFAULT TO HI" >> $syslog
	fi
fi
if [ $gtl ] && [ $wol = 0 ]; then
	if [ $gtl = 0 ]; then
	hilo=0
	echo "$date HI/LO SET TO HIGH ON LOSS" >> $syslog
	elif [ $gtl = 1 ]; then
	hilo=1
	echo "$date HI/LO SET TO LOW ON LOSS" >> $syslog
	elif [ $gtl = 2 ]; then
		if [ $hilo = true ]; then
		hilo=1
		echo "$date HI/LO SET TO ALTERNATE ON LOSS NOW LOW" >> $syslog
		else
		hilo=0
		echo "$date HI/LO SET TO ALTERNATE ON LOSS NOW HIGH" >> $syslog
		fi
	else
	echo "$date HI/LO SETTINGS ON LOSS NOT SET" >> $syslog
	fi
fi

if [ $gtw ] && [ $wol = 1 ]; then
	if [ $gtw = 0 ]; then
	hilo=0
	echo "$date HI/LO SET TO HIGH ON WIN" >> $syslog
	elif [ $gtw = 1 ]; then
	hilo=1
	echo "$date HI/LO SET TO LOW ON WIN" >> $syslog
	elif [ $gtw = 2 ]; then
		if [ $hilo = true ]; then
		hilo=1
		echo "$date HI/LO SET TO ALTERNATE ON WIN NOW LOW" >> $syslog
		else
		hilo=0
		echo "$date HI/LO SET TO ALTERNATE ON WIN NOW HIGH" >> $syslog
		fi
	else
	echo "$date HI/LO SETTINGS ON WIN NOT SET" >> $syslog
	fi
fi

if [ $hilo = 1 ]; then
con="$gt&game=$p"
sign='>'
elif [ $hilo = 1 ]; then
con="$lt&game=$p"]
sign='<'
fi

## adjust bet on win or loss

if [ $pol ] && [ $wol = 0 ]; then
	if [[ $pol =~ "-" ]]; then
	pol=$(echo $pol | sed 's/-//g')
	newbet=$(echo "scale=8; $lastbet - (($lastbet / 100) * $pol" | bc)
	echo "$date DECREASING $lastbet ON LOSS BY $pol" >> $syslog
	elif [[ $pol -gt 0 ]]; then
	newbet=$(echo "scale=8; $lastbet + (($lastbet / 100) * $pol" | bc)
	echo "$date INCREASING $lastbet ON LOSS BY $pol" >> $syslog
	else
	echo "$date CANT ALTER $lastbet ON LOSS AS $pol is UNDEFINED" >> $syslog
	fi
fi
if [ $pow ] && [ $wol = 1 ]; then
	if [[ $pow =~ "-" ]]; then
	pow=$(echo $pow | sed 's/-//g')
	newbet=$(echo "scale=8; $lastbet - (($lastbet / 100) * $pow" | bc)
	echo "$date DECREASING $lastbet ON WIN BY $pow" >> $syslog
	elif [[ $pow -gt 0 ]]; then
	newbet=$(echo "scale=8; $lastbet + (($lastbet / 100) * $pow" | bc)
	echo "$date INCREASING $lastbet ON LOSS BY $pow" >> $syslog
	else
	echo "$date CANT ALTER $lastbet ON WIN AS $pow is UNDEFINED" >> $syslog
	fi
fi

infostring="access_token=$token&username=$user&type=dice&amount=$newbet&condition=$gt&game=2&devise=btc"

## check max rolls is honoured

if [ $max -gt 0 ]; then
placebet
elif [ $max -le 0 ] && [ $end = 0 ]; then
        if [ $strkwin = 1 ]; then
        echo "$date MAX BETS REACHED STOPPING BETS ON WIN" >> $syslog
        else
        placebet
        fi
echo "$date MAX BETS REACHED STOPPING BETS ON WIN" >> $syslog
elif [ $max -le 0 ] && [ $end = 1 ]; then
	if [ $strkloss = 1 ]; then
	echo "$date MAX BETS REACHED STOPPING BETS ON WIN" >> $syslog
	else
	placebet
	fi
else
placebet
fi
}

## post the bet
placebet() {
curl $timeout -s 'https://www.bitsler.com/api/bet' -H 'origin: https://www.bitsler.com' -H 'accept-encoding: gzip, deflate, br' -H 'x-requested-with: XMLHttpRequest' \
-H 'accept-language: en-GB,en-US;q=0.8,en;q=0.6' -H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' -H 'accept: */*' \
-H 'referer: https://www.bitsler.com/play/dice' -H 'authority: www.bitsler.com' --data "$infostring" --compressed > $resp1

response
}

## parse the response, get relevant info into strings and determine win/loss
response() {
if [ -s $resp1 ]; then
  test1=$(cat $resp1 | cut -d: -f3 | cut -d, -f1 | sed 's/"//g')
  if [ $test1 = true ]; then
  cat $resp1 | grep -Po '".*?":".*?"' | tail -n 4 | sed 's/".*?":".*?"/\'$'\n/g' > $resp2
  lastbet=$(cat $resp2 | head -n 1 | cut -d: -f2 | sed 's/"//g')
  result=$(cat $resp2 | head -n 2 | tail -n 1 | cut -d: -f2 | cut -d, -f1)
  gametype=$(cat $resp2 | head -n 3 | tail -n 1 | cut -d: -f2 | cut -d, -f1)
  outcome=`printf "%.8f\n" $(cat $resp2 | head -n 3 | tail -n 1 | cut -d: -f5 | sed 's/"//g')`
  newbal=$(cat $resp2 | tail -n 1 | cut -d: -f2 | sed 's/"//g')
  wagered=`printf "%.8f\n" $(echo "$lastbet + $wagered" | bc )`
    if [[ "$outcome" =~ "-" ]]; then
    outcome=$(echo "$outcome" | sed 's/-//g')
    profitloss=`printf "%.8f\n" $(echo "$profitloss - $outcome" | bc )`
    wol=0
    else
    profitloss=`printf "%.8f\n" $(echo "$profitloss + $outcome" | bc )`
    wol=1
    fi
  cp $resp1 $resp3
  stats
  elif [ $test1 = false ]; then
  test2=$(cat $resp1 | cut -d: -f4 | cut -d, -f1 | awk '{print $1}' | sed 's/"//g')
  fi
if [ $test2 = "Insufficient" ]; then
  echo -e "$red BALANCE ERROR!$green NOT ENOUGH FUNDS"
elif [ $test2 = "Bet" ]; then
  echo -e "$red BET AMOUNT INVALID ERROR"
fi
stat
}

## statistics and announce
stat() {

if [ $max ]; then
max=$(echo "$max - 1" | bc)
fi
bets=$(echo "$bets + 1" | bc)
odds=$(echo "99 / $p")
if [ $wins -gt "0" ]; then
totalluck=$(echo "scale=2;(($p  * 101) / $bets) * $wins)" | bc)
fi

if [[ "$profitloss" =~ "-" ]]; then
pnl="$redLOSS $profitloss"
else
pnl="$greenPROFIT +$profitloss"
fi

if [ $wol = 0 ]; then
	loss=$(echo "$loss + 1" | bc)
	strkwins=0
	strkloss=$(echo "$strkloss + 1" | bc)
	echo -n "$red -LOSS-[ $result $sign $gametype ]-BET-[ $lastbet -> +$outcome -> $newbal ]-STAT-[ B:$bets W:$wins L:$loss ]-LUCK-[ T:$totalluck C:$curluck ]-WAGERED-[ W:$wagered $pnl $red]"
elif [ $wol = 1 ]; then
	wins=$(echo "$wins + 1" | bc)
	strkwins=$(echo "$strkwins + 1" | bc)
	if [ $strkwins = 1 ]; then
	curluck=$(echo "scale=2;(($p  * 101) / $strkloss) * 1)" | bc)
	fi
	strkloss=0
	echo -n "$green-WiN-[ $result $sign $gametype ]-BET-[ $lastbet -> +$outcome -> $newbal ]-STAT-[ B:$bets W:$wins L:$loss ]-LUCK-[ T:$totalluck C:$curluck ]-WAGERED-[ W:$wagered $pnl $green]"
fi
wol=2
modifybet
}
