#!bin/bash

# Leer el nombre del proyecto para generar la primera carpeta
read -p "Introduce el nombre del proyecto: " proyecto

# Confirmo que el proyecto no existe
if [ -e $proyecto ]; then
    echo "El proyecto ya existe, selecciona otro nombre."
    exit 1
fi

# Comienzo a crear la estructura de carpetas
echo "Creando la carpeta principal..."
mkdir $proyecto

# Creamos la carpeta de preparación del pentesting
echo "Creando las carpetas del apartado 01. Preparación..."
mkdir $proyecto/01_Preparación/
mkdir $proyecto/01_Preparación/Alcance
touch $proyecto/01_Preparación/Alcance/Sistemas_Incluidos.txt
touch $proyecto/01_Preparación/Alcance/Sistemas_Excluidos.txt
touch $proyecto/01_Preparación/Alcance/Objetivos_Pentest.md
mkdir $proyecto/01_Preparación/Contratos
mkdir $proyecto/01_Preparación/Info_recolectada
mkdir $proyecto/01_Preparación/Info_recolectada/Whois
mkdir $proyecto/01_Preparación/Info_recolectada/DNS_Info
mkdir $proyecto/01_Preparación/Info_recolectada/Correos_y_Direcciones.txt
mkdir $proyecto/01_Preparación/Info_recolectada/Notas_Reconocimiento_Pasivo.md

# Creamos la carpeta de testeo del pentesting
echo "Creando las carpetas del apartado 02. Testeo..."
mkdir $proyecto/02_Testeo/
mkdir $proyecto/02_Testeo/01_Escaneos
mkdir $proyecto/02_Testeo/01_Escaneos/Nmap
mkdir $proyecto/02_Testeo/01_Escaneos/Masscan
touch $proyecto/02_Testeo/01_Escaneos/Resultados_Escaneo.md
#####################################################
mkdir $proyecto/02_Testeo/02_Enumeracion
mkdir $proyecto/02_Testeo/02_Enumeracion/SMB_Enum
mkdir $proyecto/02_Testeo/02_Enumeracion/LDAP_Enum
mkdir $proyecto/02_Testeo/02_Enumeracion/Web_Enum
#####################################################
mkdir $proyecto/02_Testeo/03_Vulnerabilidades_Detectadas
mkdir $proyecto/02_Testeo/03_Vulnerabilidades_Detectadas/Escaner_Vulnerabilidades
mkdir $proyecto/02_Testeo/03_Vulnerabilidades_Detectadas/Manuales
#####################################################
mkdir $proyecto/02_Testeo/04_Explotacion
mkdir $proyecto/02_Testeo/04_Explotacion/Exploits_Usados
mkdir $proyecto/02_Testeo/04_Explotacion/Capturas_Exitosas
#####################################################
mkdir $proyecto/02_Testeo/05_Escalada_Privilegios
mkdir $proyecto/02_Testeo/05_Escalada_Privilegios/Winpeas_Linpeas
touch $proyecto/02_Testeo/05_Escalada_Privilegios/Resumen_Escalada_Privilegios.md
#####################################################
mkdir $proyecto/02_Testeo/06_Mantenimiento
touch $proyecto/02_Testeo/06_Mantenimiento/Mecanismos_Persistencia.md
mkdir $proyecto/02_Testeo/06_Mantenimiento/Backdoors_Instalados

# Creamos la carpeta de análisis del pentesting
echo "Creando las carpetas del apartado 03. Análisis..."
mkdir $proyecto/03_Analisis/
mkdir $proyecto/03_Analisis/01_Informes
touch $proyecto/03_Analisis/01_Informes/Informe_Tecnico.docx
touch $proyecto/03_Analisis/01_Informes/Resumen_Ejecutivo.docx
touch $proyecto/03_Analisis/01_Informes/Recomendaciones_Finales.md
mkdir $proyecto/03_Analisis/02_Evidencias
mkdir $proyecto/03_Analisis/02_Evidencias/Capturas_Pantalla
mkdir $proyecto/03_Analisis/02_Evidencias/Logs_Completos
mkdir $proyecto/03_Analisis/03_Analisis_Riesgos
touch $proyecto/03_Analisis/03_Analisis_Riesgos/Matriz_Riesgos.xlsx
mkdir $proyecto/03_Analisis/03_Analisis_Riesgos/Clasificación_CVSS

# Creamos las carpetas restantes
echo "Creando las carpetas restantes..."
mkdir $proyecto/Scripts_Utiles/
mkdir $proyecto/Scripts_Utiles/Scripts_Propios/
mkdir $proyecto/Scripts_Utiles/Scripts_Descargados/
touch $proyecto/README.md
touch $proyecto/Notas_Rapidas.md

# Aqui ha finalizado la creación de carpetas
echo "Finalizada la creación de carpetas."