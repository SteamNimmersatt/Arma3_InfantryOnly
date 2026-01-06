#include "functions.h"

/*
	Starts the mod on the client side. The function "INFONLY_fnc_initMod"
	is responsible for calling this and shouldn't be used outside of that.
*/

if(!hasInterface) exitWith {};

waitUntil {!isNil "INFONLY_INIT_STARTUP_SCRIPTS_EXECUTED" && !isNull player};

// Client-side initialization
[INFONLY_LOGLEVEL_INFO, "Infantry Only client initialized."] call INFONLY_fnc_log;

// Note: Vehicle weapon disabling is handled server-side, but we can call the function
// on the client for debugging purposes or to check local vehicle states
// call INFONLY_fnc_disableVehicleWeapons;
