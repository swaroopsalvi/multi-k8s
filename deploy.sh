docker build -t swaroopsalvi/multi-client:latest -t swaroopsalvi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t swaroopsalvi/multi-server:latest -t swaroopsalvi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t swaroopsalvi/multi-worker:latest -t swaroopsalvi/multi-worker:$SHA -f ./worker.Dockerfile ./worker

docker push swaroopsalvi/multi-client:latest
docker push swaroopsalvi/multi-server:latest
docker push swaroopsalvi/multi-worker:latest

docker push swaroopsalvi/multi-client:$SHA
docker push swaroopsalvi/multi-server:$SHA
docker push swaroopsalvi/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=swaroopsalvi/multi-server:$SHA
kubectl set image deployments/client-deployment server=swaroopsalvi/multi-client:$SHA
kubectl set image deployments/worker-deployment server=swaroopsalvi/multi-worker:$SHA