# ./build.sh - (c) FiveTech Software 2007-2023
# crear un archivo con el nombre build.sh y entro pegar todas estas lineas

# declaro las rutas necesarias
HARBOUR=~/harbour
HARB_INC=$HARBOUR/include
SOURCE_INC=../include
FIVEMAC=~/fivemac
OBJ=./obj

CRTLIB=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/lib
HRBLIBS='-lhbdebug -lhbvm -lhbrtl -lhblang -lhbrdd -lgttrm -lhbmacro -lhbpp -lrddntx -lrddcdx -lrddfpt -lhbsix -lhbcommon -lhbcplr -lhbcpage -lhbhsx -lrddnsx'
FRAMEWORKS='-framework Cocoa -framework WebKit -framework QTkit -framework Quartz  -framework ScriptingBridge -framework AVKit -framework AVFoundation -framework CoreMedia -framework iokit'
WINNH3DLIB='-L/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/macosx/ -rpath /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/macosx/ -rpath @executable_path/../Frameworks'

clear

if [ $# = 0 ]; then
   echo syntax: ./build.sh file [options...]
   exit
fi

mkdir $OBJ

$HARBOUR/bin/darwin/clang/harbour $1 -n -w -I$SOURCE_INC:$FIVEMAC/include:$HARB_INC -o$OBJ/$1 $2
if [ $? = 1 ]; then
   exit
fi   

echo compiling C module...

#  add -arch ppc -arch i386 for universal binaries
if [ -d /Applications/Xcode.app ]; then
   SDKPATH=$(xcrun --sdk macosx --show-sdk-path)
   gcc -ObjC $OBJ/$1.c -c -I$SDKPATH -I$SOURCE_INC -I$HARB_INC -o$OBJ/$1.o
else
   gcc -ObjC $OBJ/$1.c -c -I$SOURCE_INC -I$HARB_INC
fi   

if [ ! -d $1.app ]; then
   mkdir $1.app
fi   
if [ ! -d $1.app/Contents ]; then
   mkdir $1.app/Contents
   echo '<?xml version="1.0" encoding="UTF-8"?>' > $1.app/Contents/Info.plist
   echo '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">' >> $1.app/Contents/Info.plist
   echo '<plist version="1.0">' >> $1.app/Contents/Info.plist
   echo '<dict>' >> $1.app/Contents/Info.plist
   echo '   <key>CFBundleExecutable</key>' >> $1.app/Contents/Info.plist
   echo '   <string>'$1'</string>' >> $1.app/Contents/Info.plist
   echo '   <key>CFBundleName</key>' >> $1.app/Contents/Info.plist
   echo '   <string>'$1'</string>' >> $1.app/Contents/Info.plist
   echo '   <key>CFBundleIdentifier</key>' >> $1.app/Contents/Info.plist
   echo '   <string>com.fivetech.'$1'</string>' >> $1.app/Contents/Info.plist
   echo '   <key>CFBundlePackageType</key>' >> $1.app/Contents/Info.plist
   echo '   <string>APPL</string>' >> $1.app/Contents/Info.plist
   echo '   <key>CFBundleInfoDictionaryVersion</key>' >> $1.app/Contents/Info.plist
   echo '   <string>6.0</string>' >> $1.app/Contents/Info.plist
   echo '   <key>CFBundleIconFile</key>' >> $1.app/Contents/Info.plist
   echo '   <string>fivetech.icns</string>' >> $1.app/Contents/Info.plist
   echo '</dict>' >> $1.app/Contents/Info.plist
   echo '</plist>' >> $1.app/Contents/Info.plist
fi   
if [ ! -d $1.app/Contents/MacOS ]; then
   mkdir $1.app/Contents/MacOS
fi  
if [ ! -d $1.app/Contents/Resources ]; then
   mkdir $1.app/Contents/Resources
   cp $FIVEMAC/icons/fivetech.icns $1.app/Contents/Resources/
fi 
if [ ! -d $1.app/Contents/frameworks ]; then
   mkdir $1.app/Contents/frameworks
   cp -r $FIVEMAC/frameworks/* $1.app/Contents/frameworks/
fi 

echo linking...

#  add -arch ppc -arch i386 for universal binaries
# -framework Scintilla
#gcc $1.o -o ./$1.app/Contents/MacOS/$1 -L$CRTLIB -L./../lib -lfive -lfivec -L./../../harbour/lib/darwin/clang $HRBLIBS $FRAMEWORKS  -F./../frameworks -framework Scintilla $WINNH3DLIB

gcc $OBJ/$1.o -o ./$1.app/Contents/MacOS/$1 -L$CRTLIB -L$FIVEMAC/lib -lfive -lfivec -L$HARBOUR/lib/darwin/clang $HRBLIBS $FRAMEWORKS  -F$FIVEMAC/frameworks -framework Scintilla $CRTLIB/libz.tbd $CRTLIB/libpcre.tbd

#rm $1.c
#rm $1.o

echo done!
#./$1.app/Contents/MacOS/$1
/usr/bin/open -W ./$1.app
