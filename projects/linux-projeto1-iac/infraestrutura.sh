#!/bin/bash

# Função para criar diretórios
create_directories() {
    for directory in "$@"; do
        if [ ! -d "$directory" ]; then
            mkdir -p "$directory"
            echo "Diretório $directory criado."
        else
            echo "Diretório $directory já existe."
        fi
    done
}

# Função para criar grupos de usuários
create_groups() {
    for group in "$@"; do
        if ! getent group "$group" > /dev/null; then
            groupadd "$group"
            echo "Grupo $group criado."
        else
            echo "Grupo $group já existe."
        fi
    done
}

# Função para criar usuários
create_users() {
    for user in "$@"; do
        username=$(echo "$user" | cut -d' ' -f1)
        groups=$(echo "$user" | cut -d' ' -f2-)
        if ! getent passwd "$username" > /dev/null; then
            useradd "$username" -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G "$groups"
            echo "Usuário $username criado."
        else
            echo "Usuário $username já existe."
        fi
    done
}

# Função para definir permissões dos diretórios
set_permissions() {
    for directory in "$@"; do
        path=$(echo "$directory" | cut -d' ' -f1)
        owner=$(echo "$directory" | cut -d' ' -f2)
        group=$(echo "$directory" | cut -d' ' -f3)
        permissions=$(echo "$directory" | cut -d' ' -f4)
        if [ -d "$path" ]; then
            chown "$owner:$group" "$path"
            chmod "$permissions" "$path"
            echo "Permissões definidas para o diretório $path."
        else
            echo "Diretório $path não encontrado."
        fi
    done
}

# Criação dos diretórios
create_directories "/publico" "/adm" "/ven" "/sec"

# Criação dos grupos de usuários
create_groups "GRP_ADM" "GRP_VEN" "GRP_SEC"

# Criação dos usuários
create_users "carlos GRP_ADM" "maria GRP_ADM" "joao GRP_ADM" "debora GRP_VEN" "sebastiana GRP_VEN" "roberto GRP_VEN" "josefina GRP_SEC" "amanda GRP_SEC" "rogerio GRP_SEC"

# Definição das permissões dos diretórios
set_permissions "/adm root GRP_ADM 770" "/ven root GRP_VEN 770" "/sec root GRP_SEC 770" "/publico root root 777"

echo "Concluído!"
