docker build -t jzaburunov/multi-client:latest -t jzaburunov/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jzaburunov/multi-server:latest -t jzaburunov/multi-server:$SHA -f ./server/Dockerfile ./server
docker built -t jzaburunov/multi-worker:latest -t jzaburunov/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jzaburunov/multi-client:latest 
docker push jzaburunov/multi-server:latest 
docker push jzaburunov/multi-worker:latest 

docker push jzaburunov/multi-client:$SHA
docker push jzaburunov/multi-server:$SHA
docker push jzaburunov/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jzaburunov/multi-server:$SHA
kubectl set image deployments/client-deployment client=jzaburunov/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jzaburunov/multi-worker:$SHA
