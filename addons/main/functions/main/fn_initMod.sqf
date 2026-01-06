#include "\z\infonly\addons\main\functions\functions.h"

/*
	Starts the mod. Must be executed on all clients & the server. Will be executed automatically
	if running the mod as an addon. If running the mod as a script embedded 
	inside a mission, this should be executed from the init.sqf file (e.g. call INFONLY_fnc_initMod; )
*/

// Prevent init from running twice
if(!isNil "INFONLY_INIT") exitWith {}; 
INFONLY_INIT = true;

[INFONLY_LOGLEVEL_INFO, "Initializing Infantry Only mod."] call INFONLY_fnc_log;

// Initialize CBA settings
call INFONLY_fnc_initCBASettings;

// Register CBA event handler for vehicle spawning
["vehicleSpawned", INFONLY_fnc_handleVehicleSpawned] call CBA_fnc_addEventHandler;

[INFONLY_LOGLEVEL_INFO, "Registered CBA event handler for vehicle spawning."] call INFONLY_fnc_log;

// Execute vehicle weapon disabling initialization
// In singleplayer: !isMultiplayer is true
// In multiplayer: isServer is true for dedicated server
if(isServer || !isMultiplayer) then {
	[INFONLY_LOGLEVEL_INFO, "Starting vehicle weapon disabling system."] call INFONLY_fnc_log;
	
	// Call the function immediately to disable weapons on existing vehicles
	call INFONLY_fnc_disableVehicleWeapons;
	
	// Schedule periodic checks for new vehicles (as backup to event handlers)
	[] spawn {
		while {true} do {
			sleep 30; // Check every 30 seconds for new vehicles
			call INFONLY_fnc_disableVehicleWeapons;
		};
	};
} else {
	[INFONLY_LOGLEVEL_INFO, "Client connected to multiplayer server. Vehicle weapon disabling handled by server."] call INFONLY_fnc_log;
};

// Execute client-side initialization
// TODO: Implement client-side initialization if needed
[INFONLY_LOGLEVEL_INFO, "Infantry Only mod initialized."] call INFONLY_fnc_log;
