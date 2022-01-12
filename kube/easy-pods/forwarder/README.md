# Port Forwarder
## _How to_

write your all your pod services in the lower section of the file only the those you want to forward.
format forwardPortFromPod $1 ${pods[$index]} name-of-the-pod the-port-number-on-the-env the-desire-port-number-on-your-local.

##### Example:
- i am currently developing for kube namespace (env) hummus
- i have 4 services on my env user, balagan, boom, and redis (the real one...) 
- i want to work on balagan service on my local, but balagan service depend on user and on boom and need redis cache who of course run on my env hummus env
- so i comment out only balagan service, i call this sh file ./forwarder.sh (i suggest to create an alias suggest on pf) with the name of the env
- i can run my local pod balagan service
- pod balagan service will be connected locally to the dependent online but he will connect to the localhost:4084 for user service then localhost:8107 


 ## ✨Magic ✨
