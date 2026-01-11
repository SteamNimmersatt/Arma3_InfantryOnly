#define COMPONENT main
#define COMPONENT_BEAUTIFIED MAIN

#include "\z\infonly\addons\main\config\script_mod.hpp"
#include "\z\infonly\addons\main\config\script_macros.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_MAIN
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_MAIN
    #define DEBUG_SETTINGS DEBUG_SETTINGS_MAIN
#endif
