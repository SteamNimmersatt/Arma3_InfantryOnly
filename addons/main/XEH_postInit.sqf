#include "\z\infonly\addons\main\functions\functions.h"

[INFONLY_LOGLEVEL_INFO, "XEH postInit started."] call INFONLY_fnc_log;

// Register CBA event handler for vehicle spawning (universal - runs on all machines)
["vehicleSpawned", INFONLY_fnc_handleVehicleSpawned] call CBA_fnc_addEventHandler;

[INFONLY_LOGLEVEL_INFO, "Registered CBA event handler for vehicle spawning."] call INFONLY_fnc_log;

// Execute server-side initialization (runs on server and in singleplayer)
// In singleplayer: !isMultiplayer is true
// In multiplayer: isServer is true for dedicated server or player-hosted server
if(isServer || !isMultiplayer) then {
	// Call server initialization function
	call INFONLY_fnc_initModServer;
} else {
	[INFONLY_LOGLEVEL_INFO, "Client connected to multiplayer server. Vehicle weapon disabling handled by server."] call INFONLY_fnc_log;
};

// Execute client-side initialization (runs only on clients in multiplayer)
// In multiplayer: isServer is false and hasInterface is true for clients with players
if(!isServer && hasInterface) then {
	// Call client initialization function
	call INFONLY_fnc_initModClient;
};

[INFONLY_LOGLEVEL_INFO, "Infantry Only mod initialized."] call INFONLY_fnc_log;
