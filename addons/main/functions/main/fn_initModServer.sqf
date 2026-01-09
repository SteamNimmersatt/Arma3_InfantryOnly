#include "functions.h"

/*
	Starts the server-side components of the mod. This function is called automatically
	by fn_initMod.sqf when running on the server or in singleplayer.
	
	Server responsibilities:
	- Disabling weapons on vehicles
	- Handling periodic checks for new vehicles (backup to event handlers)
	- Handling turret locality changes (when players enter/exit vehicles)
*/

[INFONLY_LOGLEVEL_INFO, "Initializing Infantry Only server components."] call INFONLY_fnc_log;

// Execute vehicle weapon disabling initialization
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

// Schedule more frequent checks for turret locality changes
// This addresses the issue where turrets become local to a machine when a player
// enters them as a gunner
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

[INFONLY_LOGLEVEL_INFO, "Infantry Only server components initialized."] call INFONLY_fnc_log;