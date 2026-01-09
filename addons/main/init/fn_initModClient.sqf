#include "\z\infonly\addons\main\functions\functions.h"

/*
	Starts the client-side components of the mod. This function is called automatically
	by fn_initMod.sqf when running on a client in multiplayer.
	
	Client responsibilities:
	- Registering CBA event handlers
	- Handling vehicles that are local to this client (important for multiplayer)
	  When a player gets in as gunner, turrets become local to their machine
*/

// Ensure this only runs on machines with a player interface (not dedicated servers or headless clients)
if(!hasInterface) exitWith {};

// Wait for player to be initialized
waitUntil {!isNil "INFONLY_INIT_STARTUP_SCRIPTS_EXECUTED" && !isNull player};

[INFONLY_LOGLEVEL_INFO, "Initializing Infantry Only client components."] call INFONLY_fnc_log;

// Register CBA event handler for vehicle spawning on client
["vehicleSpawned", INFONLY_fnc_handleVehicleSpawned] call CBA_fnc_addEventHandler;

[INFONLY_LOGLEVEL_INFO, "Registered CBA event handler for vehicle spawning on client."] call INFONLY_fnc_log;

// Handle vehicles that are local to this client (important for multiplayer)
// When a player gets in as gunner, turrets become local to their machine
if(isMultiplayer) then {
	[] spawn {
		// Periodic check for new vehicles (backup to event handlers)
		while {true} do {
			sleep 30; // Check every 30 seconds for locally controlled vehicles
			call INFONLY_fnc_disableVehicleWeapons;
		};
	};
	
	// More frequent check for turret locality changes
	[] spawn {
		while {true} do {
			sleep 5; // Check every 5 seconds for vehicles with changed locality
			
			// Get all vehicles in the mission
			private _allVehicles = vehicles;
			
			{
				private _vehicle = _x;
				
				// Skip if vehicle is null or deleted
				if (isNull _vehicle) then {
					continue;
				};
				
				// Skip infantry units
				if (_vehicle isKindOf "Man") then {
					continue;
				};
				
				// Skip if vehicle is not local (we only handle vehicles local to this machine)
				if (!local _vehicle) then {
					continue;
				};
				
				// Skip if vehicle has no weapons
				private _weapons = weapons _vehicle;
				if (count _weapons == 0) then {
					continue;
				};
				
				// Handle turret locality for this vehicle
				[_vehicle] call INFONLY_fnc_handleTurretLocality;
			} forEach _allVehicles;
		};
	};
};

[INFONLY_LOGLEVEL_INFO, "Infantry Only client components initialized."] call INFONLY_fnc_log;
