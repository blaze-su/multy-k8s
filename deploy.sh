docker build -t sidorov/multi-client:latest -t sidorov/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sidorov/multi-server:latest -t sidorov/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sidorov/multi-worker:latest -t sidorov/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sidorov/multi-client:latest
docker push sidorov/multi-server:latest
docker push sidorov/multi-worker:latest

docker push sidorov/multi-client:$SHA
docker push sidorov/multi-server:$SHA
docker push sidorov/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=sidorov/multi-client:$SHA
kubectl set image deployments/server-deployment server=sidorov/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=sidorov/multi-worker:$SHA