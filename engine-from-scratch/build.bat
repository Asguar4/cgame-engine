set render=src\engine\render\render.c src\engine\render\render_internal.c src\engine\render\render_util.c
set io=src\engine\io\io.c
set config=src\engine\config\config.c
set input=src\engine\input\input.c
set time=src\engine\time\time.c
set physics=src\engine\physics\physics.c
set array_list=src\engine\array_list\array_list.c
set entity=src\engine\entity\entity.c
set animation=src\engine\animation\animation.c
set files=src\glad.c src\main.c src\engine\global\global.c %render% %io% %config% %input% %time% %physics% %array_list% %entity% %animation%
set libs=C:\Work\cgame-engine-from-scratch\lib\SDL2main.lib C:\Work\cgame-engine-from-scratch\lib\SDL2.lib C:\Work\cgame-engine-from-scratch\lib\freetype.lib

CL /Zi /I C:\Work\cgame-engine-from-scratch\include %files% /link %libs% /OUT:mygame.exe
