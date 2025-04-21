# Exploit DVWA - Command Injection

Este script en Bash explota una vulnerabilidad de **Command Injection** en DVWA (Damn Vulnerable Web Application), permitiendo subir una shell al servidor y obtener acceso remoto mediante una reverse shell.

---

## ¿Qué hace?

1. Sube un archivo PHP malicioso codificado en base64 al servidor vulnerable.
2. Decodifica ese archivo en el servidor para crear `cmd.php`.
3. Ejecuta una reverse shell desde el servidor hacia tu máquina.
4. Limpia los archivos para no dejar rastro.

---

## Requisitos

- DVWA con el módulo de **Command Injection** activado y **seguridad en modo "low"**
- Cookie activa de sesión (`PHPSESSID`)
- Conexión en red entre tu máquina atacante y DVWA
- `bash`, `curl` y `nc` instalados

---

## Uso

1. Asegúrate de que DVWA esté corriendo.
2. (Opcional) Crea un archivo `.env` con tu IP para ocultarla:
- `IP_USER=192.168.1.50`

3. Da permisos de ejecución al script:

```bash
chmod +x dvwa_cmdinject.sh
```
4. Ejecuta el script:
- `./dvwa_cmdinject.sh`

5. Elige entre:
- **Modo por defecto**: usa configuración predefinida y la IP desde .env
- **Modo personalizado**: introduce la URL vulnerable, cookie de sesión, IP y puerto manualmente.


## Importante

#### Este script es solo para fines educativos, entornos controlados y prácticas de hacking ético. No lo utilices contra sistemas que no tengas permiso para auditar.
