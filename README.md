# container-jumpsv
踏み台用SSHサーバーをコンテナ化したもの(クライアント側)です.


[Usage]
1. sudo docker pull tibineko923/sshsv:[tag]
2. mkdir hostkeys
3. ssh-keygen -q -t rsa -f hostkeys/ssh_host_rsa_key -N "" -C ""
4. ssh-keygen -q -t dsa -f hostkeys/ssh_host_dsa_key -N "" -C ""
5. ssh-keygen -q -t ecdsa -f hostkeys/ssh_host_ecdsa_key -N "" -C ""
6. ssh-keygen -q -t ed25519 -f hostkeys/ssh_host_ed25519_key -N "" -C ""
7. sudo docker run -d -p 22000:22 -v $PWD/hostkeys:/etc/ssh/hostkeys tibineko923/sshsv:[tag]
8. ssh [username]@[your_hostname] -p 22000

