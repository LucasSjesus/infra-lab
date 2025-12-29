#!/usr/bin/env bash

#Criando os grupos:
# groupadd admins
# groupadd devops


#Criando os usuários não root e adicionando aos grupos:

# useradd -m -s /bin/bash devuser
# passwd devuser

# usermod -aG admins,devops devuser

#Crontando o #ers para os grupos:
#echo "%admins ALL=(ALL) ALL" | # tee /etc/#ers.d/admins

#Hardening do SSH
# sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
# sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
# sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config
# systemctl restart sshd

#Firewall configuration
# apt install ufw -y
# ufw default deny incoming
# ufw default allow outgoing
# ufw allow 2222/tcp
# ufw enable
# ufw status verbose

### Script revisado

set -e 

#Verificando se está como root:
if [[ $EUID -ne 0 ]]; then
   echo "Este script deve ser executado como root (sudo ./script.sh)" 
   exit 1
fi

USER_NAME="devuser"
SSH_PORT=2222

echo "Criando grupos 'admins' e 'devops'..."
groupadd -f admins
groupadd -f devops

echo "Criando usuário '$USER_NAME' e adicionando aos grupos..."
if ! id -u "$USER_NAME" >/dev/null 2>&1; then
    useradd -m -s /bin/bash "$USER_NAME"
    echo "Defina a senha para o usuário '$USER_NAME':"
    passwd "$USER_NAME"
else

echo "adicionando usuário '$USER_NAME' aos grupos..."
fi
usermod -aG admins,devops "$USER_NAME"

echo "Configurando sudoers para o grupo 'admins'..."
echo "%admins ALL=(ALL) ALL" > /etc/sudoers.d/admins
chmod 440 /etc/sudoers.d/admins

echo "Realizando hardening do SSH..."
SSHD_CONFIG="/etc/ssh/sshd_config"
sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' "$SSHD_CONFIG"
sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' "$SSHD_CONFIG"
sed -i "s/^#*Port.*/Port $SSH_PORT/" "$SSHD_CONFIG"
systemctl restart sshd  

echo "Configurando firewall com UFW..."
apt-get install ufw -y
ufw default deny incoming
ufw default allow outgoing
ufw allow "${SSH_PORT}/tcp"
ufw --force enable
ufw status verbose

echo "realizando o PAM"

apt install libpam-pwquality -y
echo "minlen = 12
ucredit = -1
lcredit = -1
dcredit = -1
ocredit = -1
retry = 3" >> /etc/security/pwquality.conf

chage -d 0 "$USER_NAME"
echo "definindo uma nova senha para o usuário '$USER_NAME'..."
passwd "$USER_NAME"



echo "Configuração concluída com sucesso!"