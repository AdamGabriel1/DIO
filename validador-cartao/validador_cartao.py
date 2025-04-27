def validar_cartao(numero):
    numero = numero.replace(" ", "")  # Remove espaços
    if not numero.isdigit() or len(numero) < 13 or len(numero) > 19:
        return False, "Número inválido."

    # Validar bandeira
    if numero.startswith("4") and (len(numero) == 13 or len(numero) == 16):
        bandeira = "Visa"
    elif numero.startswith(("51", "52", "53", "54", "55")) and len(numero) == 16:
        bandeira = "MasterCard"
    elif numero.startswith(("34", "37")) and len(numero) == 15:
        bandeira = "American Express"
    elif numero.startswith(("6011", "644", "645", "646", "647", "648", "649", "65")) and len(numero) == 16:
        bandeira = "Discover"
    elif numero.startswith(("300", "301", "302", "303", "304", "305", "36", "38")) and len(numero) == 14:
        bandeira = "Diners Club"
    else:
        return False, "Bandeira não reconhecida."

    return True, bandeira

# Testando a função
cartoes = [
    "4111 1111 1111 1111",   # Visa
    "5111 1111 1111 1118",   # MasterCard
    "3714 4963 5400 000",     # American Express
    "6011 1111 1111 1117",   # Discover
    "3056 9309 0259 04"       # Diners Club
]

for cartao in cartoes:
    valido, resultado = validar_cartao(cartao)
    if valido:
        print(f"{cartao}: Válido - {resultado}")
    else:
        print(f"{cartao}: {resultado}")
