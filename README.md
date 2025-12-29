# 🧪 Infra Lab — Linux, DevOps & Cybersecurity

Este repositório documenta um laboratório prático de **infraestrutura Linux**, 
com foco em **administração de servidores, DevOps e segurança (DevSecOps)**.

O projeto segue um roadmap progressivo, simulando desafios reais de ambiente de produção.

---

## 🎯 Objetivo

Construir, automatizar e proteger uma infraestrutura Linux do zero, aplicando:

- Boas práticas de SysAdmin
- Automação com Bash
- Containers e CI/CD
- Hardening e segurança ofensiva/defensiva
- Monitoramento e observabilidade

---

## 🖥️ Ambiente

- **Host:** Linux (KVM/QEMU)
- **Hypervisor:** KVM + libvirt
- **VM:** Ubuntu Server
- **Rede:** NAT (libvirt default)
- **Acesso:** SSH com chave
- **Firewall:** UFW
- **Usuários:** sem login root

---

## 🔰 Fase 1 — Linux & Administração de Servidores

### ✅ Semana 1 — Servidor Linux (produção simulada)

#### Atividades realizadas:

- Criação de VM via KVM
- Configuração de usuários e grupos
- Hardening do SSH:
  - Login root desativado
  - Autenticação por chave
  - Porta customizada
- Firewall configurado (UFW)
- Política de senhas com PAM
- Expiração de senha forçada (`chage`)
- Análise de logs de autenticação

#### Conceitos aplicados:

- Permissões e usuários Linux
- PAM (Pluggable Authentication Modules)
- Segurança em serviços de acesso remoto
- Logs e auditoria básica

---

## 🔐 Segurança

- SSH protegido contra brute-force
- Política de senhas forte (`pwquality`)
- Logs de autenticação monitorados
- Pronto para Fail2Ban (Fase 1 — Semana 3)

---

## 📂 Estrutura do Projeto

```
infra-lab/
├── terraform/
├── ansible/
├── docker/
├── scripts/
├── security/
├── docs/
└── README.md
```
