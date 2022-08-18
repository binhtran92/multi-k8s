docker build -t binhtc/multi-client:latest -t binhtc/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t binhtc/multi-server:latest -t binhtc/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t binhtc/multi-worker:latest -t binhtc/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push binhtc/multi-client:latest
docker push binhtc/multi-server:latest
docker push binhtc/multi-worker:latest

docker push binhtc/multi-client:$SHA
docker push binhtc/multi-server:$SHA
docker push binhtc/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=binhtc/multi-server:$SHA
kubectl set image deployments/client-deployment client=binhtc/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=binhtc/multi-worker:$SHA