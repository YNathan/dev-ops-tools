setTerminalTitle() {
  if [[ -z "$ORIG" ]]; then
    ORIG=$PS1
  fi
  TITLE="\[\e]2;$*\a\]"
  PS1=${ORIG}${TITLE}
}
export -f setTerminalTitle

forwardPortFromPod(){
podName=$(getPodName $2 $3)
# checking if the pod exist
podNameLength=${#podName}
if [ $podNameLength \> 0 ];
then 
    echo ${podName} will run on port $5
    gnome-terminal -x bash -c "setTerminalTitle $3-service && echo $3-service && kubectl port-forward -n $1 ${podName} $5:$4; exec bash"
fi;
}

getPodName () {
if [[ "$1" == "$2"* ]]; then
echo "$1"
fi
}



IFS=$'\n' pods=($(kubectl -n $1 get pods | sed -n '1!p' | cut -d' ' -f1))
# iterating by for.
for index in "${!pods[@]}"; 
do echo $index')' ${pods[$index]};

# write your all your pod services here and uncomment only the thos you want to forward.
# format forwardPortFromPod $1 ${pods[$index]} name-of-the-pod the-port-number-on-the-env the-desire-port-number-on-your-local
# example: i am currently developoing for kube namespsace (env) hummus
#          i have 4 services on my env user, balagan, boom, and redis (the real one...) 
#          i want to work on balagan service on my local, but balagan service depend on user and on boom and need redis cach who of course run on my env hummus env
#          so i comment out only balagan service, i call this sh file ./forwarder.sh (i suggest to creat an alias suggest on pf) with the name of the env and then i can run my local pod balagan service
#          pod balagan service will be connected localy to the dependend online but he will connect to the localhost:4084 for user service then localhost:8107 you see what i mean
 
forwardPortFromPod $1 ${pods[$index]} user 4000 4084
# forwardPortFromPod $1 ${pods[$index]} balagan 4000 4019 this is 
forwardPortFromPod $1 ${pods[$index]} boom 80 8107

forwardPortFromPod $1 ${pods[$index]} redis 6379 6379

done;
