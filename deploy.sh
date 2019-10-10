docker build -t sshellien/multi-client:latest -t sshellien/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sshellien/multi-server:latest -t sshellien/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sshellien/multi-worker:latest -t sshellien/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sshellien/multi-client:latest
docker push sshellien/multi-server:latest
docker push sshellien/multi-worker:latest

docker push sshellien/multi-client:$SHA
docker push sshellien/multi-server:$SHA
docker push sshellien/multi-worker:$SHA

kubectl appl -f k8s
kubectl set image deployments/server-deployment server=sshellien/multi-server:$SHA
kubectl set image deployments/client-deployment client=sshellien/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sshellien/multi-worker:$SHA