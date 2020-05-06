#include "../SDL_internal.h"

#include "SDL_events.h"
#include "SDL_events_c.h"
#include "SDL_dragevents_c.h"

#include "../video/SDL_sysvideo.h"  /* for SDL_Window internals. */

const int
SDL_SendDrag(SDL_Window *window, const SDL_EventType evtype, const char *data, int x, int y)
{
    static SDL_bool app_is_dragging = SDL_FALSE;
    int posted = 0;

    const SDL_bool need_begin = window ? !window->is_dragging : !app_is_dragging;
    SDL_Event event;

    if (need_begin) {
        SDL_zero(event);
        event.type = SDL_DRAGBEGIN;
        event.drag.x = x;
        event.drag.y = y;

        if (window) {
            event.drag.windowID = window->id;
        }

        posted = (SDL_PushEvent(&event) > 0);
        if (!posted) {
            return 0;
        }
        if (window) {
            window->is_dragging = SDL_TRUE;
        } else {
            app_is_dragging = SDL_TRUE;
        }
    }

    SDL_zero(event);
    event.type = evtype;
    event.drag.file = data ? SDL_strdup(data) : NULL;
    event.drag.windowID = window ? window->id : 0;
    event.drag.x = x;
    event.drag.y = y;
    posted = (SDL_PushEvent(&event) > 0);

    if (posted && (evtype == SDL_DRAGCOMPLETE)) {
        if (window) {
            window->is_dragging = SDL_FALSE;
        } else {
            app_is_dragging = SDL_FALSE;
        }
    }
    return posted;
}

int SDL_SendDragFile(SDL_Window *window, const char *file, int x, int y)
{
    return SDL_SendDrag(window, SDL_DRAGFILE, file, x, y);
}

int SDL_SendDragComplete(SDL_Window *window, int x, int y) {
    return SDL_SendDrag(window, SDL_DRAGCOMPLETE, NULL, x, y);
}
