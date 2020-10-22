# container-jumpsv
踏み台用SSHサーバーをコンテナ化したもの(クライアント側)です.


docke hub : https://hub.docker.com/repository/docker/tibineko923/sshsv

### Usage(docker)
```
1. sudo docker pull tibineko923/sshsv:v1.2
2. mkdir hostkeys
3. ssh-keygen -q -t rsa -f hostkeys/ssh_host_rsa_key -N "" -C ""
4. ssh-keygen -q -t dsa -f hostkeys/ssh_host_dsa_key -N "" -C ""
5. ssh-keygen -q -t ecdsa -f hostkeys/ssh_host_ecdsa_key -N "" -C ""
6. ssh-keygen -q -t ed25519 -f hostkeys/ssh_host_ed25519_key -N "" -C ""
7. sudo docker run -d -p 22000:22 -v $PWD/hostkeys:/etc/ssh/hostkeys tibineko923/sshsv:v1.2
8. ssh [username]@[your_hostname] -p 22000
```

### Usage(kubernetes)
```
1. kubectl create secret generic jumpsv-secret-config \
  --from-file=../hostkeys/ssh_host_dsa_key \
  --from-file=../hostkeys/ssh_host_dsa_key.pub \
  --from-file=../hostkeys/ssh_host_ecdsa_key \
  --from-file=../hostkeys/ssh_host_ecdsa_key.pub \
  --from-file=../hostkeys/ssh_host_ed25519_key \
  --from-file=../hostkeys/ssh_host_ed25519_key.pub \
  --from-file=../hostkeys/ssh_host_rsa_key \
  --from-file=../hostkeys/ssh_host_rsa_key.pub \
  --dry-run -o yaml | kubectl apply -f -
2. kubectl apply -f jumpsv-deployment.yaml -n [namespace_name]
3. kubectl apply -f jumpsv-service.yaml -n [namespace_name]
```
