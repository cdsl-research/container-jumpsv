# container-jumpsv

踏み台用SSHサーバーをコンテナ化したもの(クライアント側)です.

## Usage for K8s

1. Create ssh keys

```
mkdir hostkeys
ssh-keygen -q -t rsa -f hostkeys/ssh_host_rsa_key -N "" -C ""
ssh-keygen -q -t dsa -f hostkeys/ssh_host_dsa_key -N "" -C ""
ssh-keygen -q -t ecdsa -f hostkeys/ssh_host_ecdsa_key -N "" -C ""
ssh-keygen -q -t ed25519 -f hostkeys/ssh_host_ed25519_key -N "" -C ""

tree
.
├── hostkeys
│   ├── ssh_host_dsa_key
│   ├── ssh_host_dsa_key.pub
│   ├── ssh_host_ecdsa_key
│   ├── ssh_host_ecdsa_key.pub
│   ├── ssh_host_ed25519_key
│   ├── ssh_host_ed25519_key.pub
│   ├── ssh_host_rsa_key
│   └── ssh_host_rsa_key.pub
```

2. Deploy to Kubernetes

```
cd kubernetes

# Create namespace
kubectl create namespace prod-ssh-jump

# Set namespace
alias k='kubectl -n prod-ssh-jump'

# Create secret
k create secret generic jumpsv-secret-config \
  --from-file=../hostkeys/ssh_host_dsa_key \
  --from-file=../hostkeys/ssh_host_dsa_key.pub \
  --from-file=../hostkeys/ssh_host_ecdsa_key \
  --from-file=../hostkeys/ssh_host_ecdsa_key.pub \
  --from-file=../hostkeys/ssh_host_ed25519_key \
  --from-file=../hostkeys/ssh_host_ed25519_key.pub \
  --from-file=../hostkeys/ssh_host_rsa_key \
  --from-file=../hostkeys/ssh_host_rsa_key.pub

# Deploy
k apply -f jumpsv-deployment.yaml
k apply -f jumpsv-service.yaml
```

## Development

Pull container image

```
docker pull ghcr.io/cdsl-research/container-jumpsv:master
```

Start container

```
docker run -d -p 22000:22 -v $PWD/hostkeys:/etc/ssh/hostkeys ghcr.io/cdsl-research/container-jumpsv:master
```

Connect to ssh server 

```
ssh [username]@[your_hostname] -p 22000
```
