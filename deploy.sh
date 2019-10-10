docker build -t sshellien/multi-client:latest -t sshellien/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sshellien/multi-server:latest -t sshellien/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sshellien/multi-worker:latest -t sshellien/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sshellien/multi-client
docker push sshellien/multi-server
docker push sshellien/multi-worker

kubectl appl -f k8s
kubectl set image deployments/server-deployment server=sshellien/multi-server