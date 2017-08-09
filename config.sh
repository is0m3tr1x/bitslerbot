## is0m3tr1x Bitsler Bot
## contact is0m3tr1x.2017@gmail.com
## repository https://github.com/is0m3tr1x/bitslerbot
## donate 1MN5MBKc7CvkXqsYpFrNmzxS6ZMCE6w4AG

## set bitsler username
user="is0lvlEtr1x"

token="ea45fcbed13b7c41a653e0f8bccf78311a3a25053c75919cf29529035d5424174d1e663fa8994d78925b28039ab2f0933955d388858d019736c527eead92183d"

## set bitsler auth token

##----------------------------##
## DONT TOUCH BELOW THIS LINE ##
##----------------------------##

version="1.034"

## initialize variables

bets=0
wins=0
loss=0
strkwins=0
strkloss=0
wagered=0
profitloss=0
gt='%3E'
lt='%3C'
lines=13

## curl arguments
timeout="--connect-timeout 3 --max-time 4 --retry 3 --retry-delay 0 --retry-max-time 3"

## web response files
resp1="./web/resp1"
resp2="./web/resp2"
resp3="./web/resp3"
resp4="./web/resp4"

## date var for logs
date=$(date +'%D %T')

## odds db
oddsdb=./odds

## system log
syslog=./log/sys.log

## activity log
log=./log/result.log

## colours for output
white="\033[1;37m"
grey="\033[0;37m"
purple="\033[0;35m"
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
purple="\033[0;35m"
cyan="\033[0;36m"
cafe="\033[0;33m"
fiuscha="\033[0;35m"
blue="\033[1;34m"
transparent="\e[0m"

## settings file
settings="./settings.sh"
