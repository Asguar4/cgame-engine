set files=src\glad.c src\main.c
set libs=C:\Work\cgame-engine-from-scratch\lib\SDL2main.lib C:\Work\cgame-engine-from-scratch\lib\SDL2.lib C:\Work\cgame-engine-from-scratch\lib\freetype.lib

CL /Zi /I C:\Work\cgame-engine-from-scratch\include %files% /link %libs% /OUT:mygame.exe
