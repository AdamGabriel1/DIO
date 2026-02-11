# Guia de Mitigação - Ataques de Força Bruta

## 1. Autenticação Robusta

### Política de Senhas
- Comprimento mínimo: 12 caracteres
- Complexidade obrigatória
- Histórico de senhas (não repetir últimas 12)
- Verificação contra senhas vazadas (Have I Been Pwned API)

### Multi-Fator de Autenticação (MFA)
- TOTP (Google Authenticator, Authy)
- Hardware tokens (YubiKey)
- Push notification (apps proprietários)
- **Importante**: MFA deve ser obrigatório, não opcional

## 2. Controle de Taxa (Rate Limiting)

```nginx
# Exemplo Nginx
limit_req_zone $binary_remote_addr zone=login:10m rate=5r/m;

location /login {
    limit_req zone=login burst=3 nodelay;
    proxy_pass http://backend;
}
```

```python
# Exemplo Flask (Python)
from flask_limiter import Limiter

limiter = Limiter(app, key_func=get_remote_address)

@app.route('/login', methods=['POST'])
@limiter.limit("5 per minute")
def login():
    # lógica de login
    pass
```

## 3. Bloqueio de Conta

- Bloqueio temporário após 5 tentativas falhas
- Tempo de bloqueio progressivo (5min, 15min, 1h)
- Notificação ao usuário por email/SMS
- Reset apenas via email verificado

## 4. CAPTCHA e Desafios

- reCAPTCHA v2/v3 (Google)
- hCaptcha (alternativa com foco em privacidade)
- CAPTCHA após 3 tentativas falhas
- Não usar CAPTCHA em todas as requisições (UX ruim)

## 5. Monitoramento e Detecção

### Logs Essenciais
- Timestamp
- IP de origem
- Usuário tentado
- Resultado (sucesso/falha)
- User-Agent
- Geolocalização

### Alertas
- > 10 tentativas falhas/minuto por IP
- > 5 tentativas em contas diferentes (password spraying)
- Tentativas de múltiplos países simultâneos
- Horários atípicos

## 6. Hardening de Protocolos

### SMB
```bash
# Desabilitar SMBv1 (Linux - Samba)
[global]
    server min protocol = SMB2
    server max protocol = SMB3

# Windows PowerShell
Set-SmbServerConfiguration -EnableSMB1Protocol $false
Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol
```

### SSH
```bash
# /etc/ssh/sshd_config
PermitRootLogin no
PasswordAuthentication no  # Usar apenas chaves
MaxAuthTries 3
ClientAliveInterval 300
ClientAliveCountMax 2
AllowUsers usuario1 usuario2
```

## 7. Arquitetura Defensiva

### Segmentação
- VLANs para serviços diferentes
- DMZ para serviços públicos
- Rede administrativa isolada
- Jump servers para acesso privilegiado

### VPN Obrigatória
- Acesso administrativo apenas via VPN
- 2FA na VPN
- Split tunneling desabilitado

## 8. Resposta a Incidentes

### Playbook: Detecção de Força Bruta

1. **Identificação**: SIEM alerta sobre padrão suspeito
2. **Containment**: Bloquear IP no WAF/firewall
3. **Investigação**: Analisar logs, identificar contas alvo
4. **Eradicação**: Forçar troca de senha nas contas potencialmente comprometidas
5. **Recovery**: Monitorar contas recuperadas
6. **Lessons Learned**: Ajustar thresholds, atualizar regras

## Checklist de Implementação

- [ ] Política de senhas forte implementada
- [ ] MFA ativado para todos os usuários
- [ ] Rate limiting configurado
- [ ] Bloqueio de conta ativado
- [ ] CAPTCHA em formulários de login
- [ ] SIEM coletando logs de autenticação
- [ ] Alertas configurados
- [ ] SMBv1 desabilitado
- [ ] SSH com autenticação por chave apenas
- [ ] Rede segmentada
- [ ] VPN para acesso administrativo
- [ ] Playbook de IR testado
