# pv.sh location geo
setTerminalTitle() {
  if [[ -z "$ORIG" ]]; then
    ORIG=$PS1
  fi
  TITLE="\[\e]2;$*\a\]"
  PS1=${ORIG}${TITLE}
}
export -f setTerminalTitle

getPodConfig(){
podName=$(getPodName $2 $3)
# checking if the pod exist
podNameLength=${#podName}
if [ $podNameLength \> 0 ];
then 
    echo ${podName} will revel his configs are you ready?

 
    gnome-terminal -x bash -c "setTerminalTitle $1 ${podName} && kubectl exec  '${podName}'  -n '$1' -it /bin/bash; exec bash"

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

getPodConfig $1 ${pods[$index]} $2

done;
