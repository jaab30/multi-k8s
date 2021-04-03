docker build -t jaab30/multi-client:latest -t jaab30/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jaab30/multi-server:latest -t jaab30/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jaab30/multi-worker:latest -t jaab30/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jaab30/multi-client:latest
docker push jaab30/multi-client:$SHA
docker push jaab30/multi-server:latest
docker push jaab30/multi-server:$SHA
docker push jaab30/multi-worker:latest
docker push jaab30/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jaab30/multi-server:$SHA
kubectl set image deployments/client-deployment client=jaab30/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jaab30/multi-worker:$SHA