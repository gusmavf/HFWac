# Hardware Utilizado
MacBook Air<br>
Procesador: 1,6 ghz Intel Core i5 de 2 nucleos<br>
Grafico: Intel UHD Graphics 617<br>
RAM: 8 GB<br>
MacOs: Sonoma 14.2.1<br>

<hr>

### Instalacion del Xcode Tools:
xcode-select –install

### Descargar del repositorio los codigo fuentes de harbour:
git clone https://github.com/harbour/core harbour

### Compilar el codigo descargado:
cd harbour/core<br>

make<br>

### Instalar el GNU Midnight Commander (mc):

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"<br>

brew install mc<br>

### Clonar el repositorio de FiveMac:

git clone https://github.com/fivetechsoft/fivemac<br>

<hr>

### Modificar el script de compilacion:

Hay que modificar el archivo <b>fivemac/samples/build.sh</b> para que ubique las lib que necesite cuando linkee los archivos. <br>
Busca la linea que dice:<br>

CRTLIB=$SDKPATH/Library/Developer/CommandLineTools/SDKs/MacOSX11.3.sdk/usr/lib<br>

En mi caso esa linea quedaria de esta manera:<br>
CRTLIB=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/lib<br>

<hr>
Con esos pasos ya se podria comenzar a compilar los programas hecho con harbour + fwmac <br>
./build.sh [nombre_archivo]




