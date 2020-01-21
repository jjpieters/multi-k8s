docker build -t jjpieters/multi-client:latest -t jjpieters/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jjpieters/multi-server:latest -t jjpieters/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jjpieters/multi-worker:latest -t jjpieters/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jjpieters/multi-client:latest
docker push jjpieters/multi-server:latest
docker push jjpieters/multi-worker:latest

docker push jjpieters/multi-client:$SHA
docker push jjpieters/multi-server:$SHA
docker push jjpieters/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jjpieters/multi-server:$SHA
kubectl set image deployments/client-deployment client=jjpieters/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jjpieters/multi-worker:$SHA
