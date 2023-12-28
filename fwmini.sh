# Script para crear la carpeta de inicio, 
# dentro de la carpeta se copia el archivo build.sh
# que se encuentra dentro de una carpeta especificada

SCRIPT=~/workshop

clear

if [ $# = 0 ]; then
   echo ""
   echo "Falta el nombre del proyecto"
   echo ""
   echo "Sintaxis: "
   echo "        ./fwmini.sh [Nombre del proyecto]"
   echo ""
   exit
fi

mkdir $SCRIPT/$1
mkdir $SCRIPT/$1/obj
mkdir $SCRIPT/$1/include
cp $SCRIPT/build.sh $1

echo ""
echo "==================================="
echo "Estructura creada"
echo ""
find $1 -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
echo ""
echo "==================================="
