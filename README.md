# Comparison

- setup namespace

```bash
kubectl create ns comparison
kubectl config set-context --current --namespace=comparison
```

- setup secrets

```bash
kubectl apply -f nim-secret.yaml
kubectl apply -f rh-registry-secret.yaml
kubectl apply -f hf-secret.yaml

# NGC API key from https://ngc.nvidia.com/setup/api-key
export NGC_API_KEY=...
export EMAIL=robertgshaw2@gmail.com

kubectl create secret docker-registry nvcr-secret \
  --docker-server=nvcr.io \
  --docker-username='$oauthtoken' \
  --docker-password="$NGC_API_KEY" \
  --docker-email=$EMAIL \
  -n comparison
```

- deploy

```bash
# note: update the NIM_MODEL_PROFILE to whatever is needed - e.g. 
kubectl apply -f manifest-nim.yaml
kubectl apply -f manifest-rhaiis.yaml
kubeclt apply -f guidellm.yaml
```

- get the URLs of the services

```bash
kubectl get services

>> NAME     TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)    AGE
>> nim      ClusterIP   10.16.0.233   <none>        8000/TCP   11m
>> rhaiis   ClusterIP   10.16.3.8     <none>        8000/TCP   50s
```

- launch interactive pod

```bash
kubectl cp sweep-nim.sh comparison/interactive-pod:/opt/app-root/src
kubectl cp sweep-vllm.sh comparison/interactive-pod:/opt/app-root/src
kubectl exec -it interactive-pod -- /bin/bash
```

- inside the interactive pod, launch the benchmark
```bash
cd /opt/app-root/src
URL=http://10.16.3.8:8000 ./sweep-vllm.sh
URL=http://10.16.0.233:8000 ./sweep-nim.sh
```


