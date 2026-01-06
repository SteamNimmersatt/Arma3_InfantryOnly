#include "functions.h"

/*
	Disables all weapons on vehicles by setting their ammunition to zero.
	This function should be called periodically to handle newly spawned vehicles.
	
	Parameter(s):
	None
	
	Returns:
	Nothing
*/

// Check if mod is enabled
if (!isNil "INFONLY_enable" && {!INFONLY_enable}) exitWith {
	[INFONLY_LOGLEVEL_DEBUG, "Mod is disabled. Skipping vehicle weapon disabling."] call INFONLY_fnc_log;
};

[INFONLY_LOGLEVEL_DEBUG, "Checking for vehicles to disable weapons on..."] call INFONLY_fnc_log;

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
	
	// Check whitelist - skip vehicles that are in the whitelist
	if (!isNil "INFONLY_vehicleWhitelistParsed" && {count INFONLY_vehicleWhitelistParsed > 0}) then {
		private _vehicleType = toUpper(typeOf _vehicle);
		if (_vehicleType in INFONLY_vehicleWhitelistParsed) then {
			[INFONLY_LOGLEVEL_DEBUG, format ["Skipping whitelisted vehicle: %1", _vehicleType]] call INFONLY_fnc_log;
			continue;
		};
	};
	
	// Skip if vehicle has no weapons
	private _weapons = weapons _vehicle;
	if (count _weapons == 0) then {
		// Even if no weapons now, mark as processed to avoid rechecking
		_vehicle setVariable ["INFONLY_weaponsDisabled", true];
		continue;
	};
	
	// Check if we've already processed this vehicle to avoid unnecessary work
	if (!isNil {_vehicle getVariable "INFONLY_weaponsDisabled"}) then {
		continue;
	};
	
	// Skip if vehicle is not local (ammo can only be set on local vehicles)
	if (!local _vehicle) then {
		continue;
	};
	
	[INFONLY_LOGLEVEL_DEBUG, format ["Disabling weapons on vehicle: %1", typeOf _vehicle]] call INFONLY_fnc_log;
	
	// Set vehicle ammunition to zero using the built-in Arma 3 command
	// This affects all turrets and weapons on the vehicle
	_vehicle setVehicleAmmo 0;
	
	// Mark vehicle as processed
	_vehicle setVariable ["INFONLY_weaponsDisabled", true];
	_processedCount = _processedCount + 1;
} forEach _allVehicles;

[INFONLY_LOGLEVEL_DEBUG, format ["Finished checking vehicles. Processed %1 vehicles.", _processedCount]] call INFONLY_fnc_log;
