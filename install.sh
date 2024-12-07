#!/bin/bash

# Variables
APPIMAGE="LinuxOficce365-1.0.0.AppImage"
APP_NAME="LinuxOficce365"
ICON_NAME="linuxoficce365.png"
APPIMAGE_URL="https://github.com/SrChaoz/LinuxOffice365/releases/download/v1.0.0/LinuxOficce365-1.0.0.AppImage"
APPIMAGE_PATH="$HOME/.local/bin/$APPIMAGE"
DESKTOP_PATH="$HOME/.local/share/applications/$APP_NAME.desktop"
ICON_PATH="$HOME/.local/share/icons/$ICON_NAME"

# Crear directorios necesarios
mkdir -p $HOME/.local/bin
mkdir -p $HOME/.local/share/applications
mkdir -p $HOME/.local/share/icons

# Descargar la AppImage
echo "Descargando la AppImage desde $APPIMAGE_URL..."
curl -L "$APPIMAGE_URL" -o "$APPIMAGE_PATH"
if [ $? -eq 0 ]; then
  chmod +x "$APPIMAGE_PATH"
  echo "AppImage descargada e instalada en $APPIMAGE_PATH"
else
  echo "ERROR: No se pudo descargar la AppImage."
  exit 1
fi

# Copiar el icono
echo "Copiando el icono..."
if [ -f "./assets/icons/$ICON_NAME" ]; then
  cp "./assets/icons/$ICON_NAME" "$ICON_PATH"
  echo "Icono instalado en $ICON_PATH"
else
  echo "ERROR: No se encontró el icono en ./assets/icons/$ICON_NAME"
  exit 1
fi

# Generar el archivo .desktop 
echo "Generando el archivo .desktop..."
cat > "$DESKTOP_PATH" <<EOL
[Desktop Entry]
Name=$APP_NAME
Comment=Microsoft Office 365 en Linux
Exec=$APPIMAGE_PATH
Icon=$ICON_PATH
Type=Application
Terminal=false
Categories=Office;
EOL

if [ -f "$DESKTOP_PATH" ]; then
  echo "Archivo .desktop creado en $DESKTOP_PATH"
else
  echo "ERROR: No se pudo crear el archivo .desktop"
  exit 1
fi

# Actualizar la base de datos de aplicaciones
echo "Actualizando la base de datos de aplicaciones..."
update-desktop-database "$HOME/.local/share/applications/"

# Actualizar la caché de íconos
echo "Actualizando la caché de íconos..."
gtk-update-icon-cache "$HOME/.local/share/icons/" || echo "Advertencia: No se pudo actualizar la caché de íconos."

echo "Instalación completada."

