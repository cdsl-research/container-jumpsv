# Usage for docker

Create ssh secret

```
ssh-keygen -q -t rsa -f hostkeys/ssh_host_rsa_key -N "" -C ""
ssh-keygen -q -t dsa -f hostkeys/ssh_host_dsa_key -N "" -C ""
ssh-keygen -q -t ecdsa -f hostkeys/ssh_host_ecdsa_key -N "" -C ""
ssh-keygen -q -t ed25519 -f hostkeys/ssh_host_ed25519_key -N "" -C ""
```

Create a container

```
docker run -d -p 22000:22 -v $PWD/hostkeys:/etc/ssh/hostkeys ghcr.io/tomoyk/stns-container/container-jumpsv:v0.1.4
```

# Usage for k8s

Create namespace

```
kubectl create ns ssh-jump
```

Deploy deployment and service

```
kubectl apply -n ssh-jump -f svc.yml -f deploy.yml
```

Create ssh secret

```
ssh-keygen -q -t rsa -f hostkeys/ssh_host_rsa_key -N "" -C ""
ssh-keygen -q -t dsa -f hostkeys/ssh_host_dsa_key -N "" -C ""
ssh-keygen -q -t ecdsa -f hostkeys/ssh_host_ecdsa_key -N "" -C ""
ssh-keygen -q -t ed25519 -f hostkeys/ssh_host_ed25519_key -N "" -C ""
```

Deploy secrets

```
kubectl create secret generic jump-secret-config \
  --from-file=hostkeys/ssh_host_dsa_key \
  --from-file=hostkeys/ssh_host_dsa_key.pub \
  --from-file=hostkeys/ssh_host_ecdsa_key \
  --from-file=hostkeys/ssh_host_ecdsa_key.pub \
  --from-file=hostkeys/ssh_host_ed25519_key \
  --from-file=hostkeys/ssh_host_ed25519_key.pub \
  --from-file=hostkeys/ssh_host_rsa_key \
  --from-file=hostkeys/ssh_host_rsa_key.pub \
  --dry-run=client -o yaml | kubectl apply -f - -n ssh-jump
```
