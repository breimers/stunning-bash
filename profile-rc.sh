#aliases
alias python='python3'
alias docker-cycle='sudo docker-compose down; sudo docker-compose up -d'
alias docker-nuke='sudo docker kill $(sudo docker ps -q)'
alias venv='python3 -m venv env; source env/bin/activate; pip install -r requirements.txt;'
alias docker='sudo docker'
alias per='pipenv run'
alias gimme='sudo apt install -y'

#user defined functions
nuke(){
	pname=$1
	kill -9 $(pidof $pname)
}

force-del-ns(){
	mkdir -p .tmp
	NAMESPACE=$1
	kubectl delete ns $NAMESPACE
	kubectl proxy &
	kubectl get namespace $NAMESPACE -o json |jq '.spec = {"finalizers":[]}' >.tmp/temp.json
	curl -k -H "Content-Type: application/json" -X PUT --data-binary @.tmp/temp.json 127.0.0.1:8001/api/v1/namespaces/$NAMESPACE/finalize
	rm .tmp -rf
}

docker-bp(){
	tag=$1
	docker build -t $tag .
	docker push $tag
}

kube-token(){
	if [ "$1" == "-h" ] | [ "$1" == "--help" ]
	then
  		echo "Usage: kube-token  [NAMESPACE NAME]"
	else

		NAMESPACE=$1
		NAME=$2
		kubectl -n $NAMESPACE get secret $(kubectl get sa $NAME -o json | jq '.secrets'  | grep name | awk '{print $2}' | tr -d \") -o json | jq '.data.token' | tr -d \" | base64 -d
	fi
}

