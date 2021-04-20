docker build -t pakkocool/multi-client:latest -t pakkocool/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pakkocool/multi-server:latest -t pakkocool/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pakkocool/multi-worker:latest -t pakkocool/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pakkocool/multi-client:latest
docker push pakkocool/multi-server:latest
docker push pakkocool/multi-worker:latest

docker push pakkocool/multi-client:$SHA
docker push pakkocool/multi-server:$SHA
docker push pakkocool/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pakkocool/multi-server:$SHA
kubectl set image deployments/client-deployment client=pakkocool/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pakkocool/multi-worker:$SHA