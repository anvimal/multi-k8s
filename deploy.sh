docker build -t anvimal/multi-client:latest -t anvimal/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t anvimal/multi-server:latest -t anvimal/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t anvimal/multi-worker:latest -t anvimal/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push anvimal/multi-client:latest
docker push anvimal/multi-server:latest
docker push anvimal/multi-worker:latest
docker push anvimal/multi-client:$SHA
docker push anvimal/multi-server:$SHA
docker push anvimal/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment sever=anvimal/multi-server:$SHA
kubectl set image deployments/client-deployment client=anvimal/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=anvimal/multi-worker:$SHA