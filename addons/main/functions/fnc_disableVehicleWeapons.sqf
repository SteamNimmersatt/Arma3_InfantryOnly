#include "functions.h"

/*
	Disables all weapons on vehicles by setting their ammunition to zero.
	This function processes vehicles that are local to the machine executing it.
	
	In multiplayer environments:
	- Server processes vehicles local to the server
	- Clients process vehicles local to those clients
	- When a player becomes a gunner in a vehicle, that turret becomes local 
	  to their machine, and this function will process it when called on that machine
	
	This function should be called:
	- Periodically on server and clients to catch any vehicles that became local
	- When a vehicle spawns (via event handler)
	
	Parameter(s):
	None
	
	Returns:
	Nothing
*/

// Check if mod is enabled
if (!isNil "INFONLY_enable" && {!INFONLY_enable}) exitWith {
	[INFONLY_LOGLEVEL_DEBUG, "Mod is disabled. Skipping vehicle weapon disabling."] call infonly_main_fnc_log;
};

[INFONLY_LOGLEVEL_DEBUG, "Checking for vehicles to disable weapons on..."] call infonly_main_fnc_log;

// Get all vehicles in the mission
private _allVehicles = vehicles;

// Counter for processed vehicles (for logging purposes)
private _processedCount = 0;

{
	private _vehicle = _x;
	
	// Skip if vehicle is null or deleted
	if (isNull _vehicle) then {
		continue;
	};
	
	// Skip infantry units (we only want to disable weapons on actual vehicles)
	if (_vehicle isKindOf "Man") then {
		continue;
	};
	
	// Check if we've already processed this vehicle to avoid unnecessary work
	if (!isNil {_vehicle getVariable "INFONLY_weaponsDisabled"}) then {
		continue;
	};
	
	// Check if vehicle type is allowed
	if ([_vehicle] call infonly_main_fnc_isVehicleTypeAllowed) then {
		[INFONLY_LOGLEVEL_DEBUG, format ["Vehicle of type '%1' is allowed to keep ammunition. Skipping.", typeOf _vehicle]] call infonly_main_fnc_log;
		// Mark as processed to avoid rechecking
		_vehicle setVariable ["INFONLY_weaponsDisabled", true];
		continue;
	};
	
	// Skip if vehicle is not local (ammo can only be set on local vehicles)
	if (!local _vehicle) then {
		continue;
	};
	
	[INFONLY_LOGLEVEL_DEBUG, format ["Disabling weapons on vehicle: %1", typeOf _vehicle]] call infonly_main_fnc_log;
	
	// Set vehicle ammunition to zero using the built-in Arma 3 command
	// This affects all turrets and weapons on the vehicle
	_vehicle setVehicleAmmo 0;
	
	// Mark vehicle as processed
	_vehicle setVariable ["INFONLY_weaponsDisabled", true];
	_processedCount = _processedCount + 1;
} forEach _allVehicles;

[INFONLY_LOGLEVEL_DEBUG, format ["Finished checking vehicles. Processed %1 vehicles.", _processedCount]] call infonly_main_fnc_log;
