set render=src\engine\render\render.c src\engine\render\render_internal.c src\engine\render\render_util.c
set io=src\engine\io\io.c
set files=src\glad.c src\main.c src\engine\global.c %render% %io%
set libs=C:\Work\cgame-engine-from-scratch\lib\SDL2main.lib C:\Work\cgame-engine-from-scratch\lib\SDL2.lib C:\Work\cgame-engine-from-scratch\lib\freetype.lib

CL /Zi /I C:\Work\cgame-engine-from-scratch\include %files% /link %libs% /OUT:mygame.exe
