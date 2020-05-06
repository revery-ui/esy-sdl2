#include "../SDL_internal.h"

#ifndef SDL_dragevents_c_h_
#define SDL_dragevents_c_h_

extern int SDL_SendDragFile(SDL_Window *window, const char *file, int x, int y);
extern int SDL_SendDragComplete(SDL_Window *window, int x, int y);
#endif
