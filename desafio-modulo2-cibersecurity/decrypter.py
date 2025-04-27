import os
import pyaes
import hashlib

file_name = "teste.txt.ransomwaretroll"

def generate_key(password):
    return hashlib.sha256(password.encode()).digest()

def decrypt_file(file_path, key):
    try:
        with open(file_path, 'rb') as file:
            file_data = file.read()
        os.remove(file_path)
        integrity_hash = file_data[-32:]
        crypto_data = file_data[:-32]
        if hashlib.sha256(crypto_data).digest() == integrity_hash:
            aes = pyaes.AESModeOfOperationCTR(key)
            decrypt_data = aes.decrypt(crypto_data)
            new_file_path = file_path.replace('.ransomwaretroll', '')
            with open(new_file_path, 'wb') as new_file:
                new_file.write(decrypt_data)
            print(f"Arquivo {file_path} descriptografado com sucesso.")
        else:
            print("Integridade comprometida. O arquivo pode ter sido alterado.")
    except Exception as e:
        print(f"Erro ao descriptografar o arquivo: {e}")

password = "sua_senha_segura"
key = generate_key(password)
file_path_to_decrypt = (file_name)
decrypt_file(file_path_to_decrypt, key)
