# sdl2 cmake project-config input for ./configure scripts

set(prefix "D:/esy-sdl2/_esy/default/store/s/esy_sdl2-67897b02") 
set(exec_prefix "${prefix}")
set(libdir "${exec_prefix}/lib")
set(SDL2_PREFIX "D:/esy-sdl2/_esy/default/store/s/esy_sdl2-67897b02")
set(SDL2_EXEC_PREFIX "D:/esy-sdl2/_esy/default/store/s/esy_sdl2-67897b02")
set(SDL2_LIBDIR "${exec_prefix}/lib")
set(SDL2_INCLUDE_DIRS "${prefix}/include/SDL2")
set(SDL2_LIBRARIES "-L${SDL2_LIBDIR}  -lmingw32 -lSDL2main -lSDL2 -mwindows")
string(STRIP "${SDL2_LIBRARIES}" SDL2_LIBRARIES)
