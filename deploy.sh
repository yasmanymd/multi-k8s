docker build -t yasmanymd/multi-client:latest -t yasmanymd/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yasmanymd/multi-server:latest -t yasmanymd/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yasmanymd/multi-worker:latest -t yasmanymd/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push yasmanymd/multi-client:latest
docker push yasmanymd/multi-server:latest
docker push yasmanymd/multi-worker:latest
docker push yasmanymd/multi-client:$SHA
docker push yasmanymd/multi-server:$SHA
docker push yasmanymd/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=yasmanymd/multi-client:$SHA
kubectl set image deployments/server-deployment server=yasmanymd/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=yasmanymd/multi-worker:$SHA