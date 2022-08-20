docker build -t jsfreitas/multi-client:latest -t jsfreitas/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jsfreitas/multi-worker:latest -t jsfreitas/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t jsfreitas/multi-server:latest -t jsfreitas/multi-server:$SHA -f ./server/Dockerfile ./server

docker push jsfreitas/multi-client:latest
docker push jsfreitas/multi-worker:latest
docker push jsfreitas/multi-server:latest
docker push jsfreitas/multi-client:$SHA
docker push jsfreitas/multi-worker:$SHA
docker push jsfreitas/multi-server:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jsfreitas/multi-server:$SHA
kubectl set image deployments/client-deployment client=jsfreitas/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jsfreitas/multi-worker:$SHA
