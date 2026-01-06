#include "functions.h"

/*
	Starts the mod on the client side. The function "INFONLY_fnc_initMod"
	is responsible for calling this and shouldn't be used outside of that.
*/

if(!hasInterface) exitWith {};

waitUntil {!isNil "INFONLY_INIT_STARTUP_SCRIPTS_EXECUTED" && !isNull player};

// Client-side initialization
[INFONLY_LOGLEVEL_INFO, "Infantry Only client initialized."] call INFONLY_fnc_log;

// Register CBA event handler for vehicle spawning on client
["vehicleSpawned", INFONLY_fnc_handleVehicleSpawned] call CBA_fnc_addEventHandler;

[INFONLY_LOGLEVEL_INFO, "Registered CBA event handler for vehicle spawning on client."] call INFONLY_fnc_log;

// Handle vehicles that are local to this client (important for multiplayer)
// When a player gets in as gunner, turrets become local to their machine
// Skip this in singleplayer as the host handles it in the main initialization
if(isMultiplayer) then {
	[] spawn {
		while {true} do {
			sleep 30; // Check every 30 seconds for locally controlled vehicles
			call INFONLY_fnc_disableVehicleWeapons;
		};
	};
} else {
	[INFONLY_LOGLEVEL_INFO, "Singleplayer detected. Vehicle weapon disabling handled by host initialization."] call INFONLY_fnc_log;
};
