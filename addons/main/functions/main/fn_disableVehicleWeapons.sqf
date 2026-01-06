#include "functions.h"

/*
	Disables all weapons on vehicles by setting their ammunition to zero.
	This function should be called periodically to handle newly spawned vehicles.
	
	Parameter(s):
	None
	
	Returns:
	Nothing
*/

// TODO: When integrating with CBA, consider using CBA event handlers for more efficient vehicle detection:
// - CBA_fnc_addEventHandler for "vehicleSpawned" event
// - This would eliminate the need for periodic polling

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
	
	[INFONLY_LOGLEVEL_DEBUG, format ["Disabling weapons on vehicle: %1", typeOf _vehicle]] call INFONLY_fnc_log;
	
	// Set ammunition for all turrets to zero
	{
		private _turretPath = _x;
		private _magazines = _vehicle magazinesTurret _turretPath;
		
		{
			_vehicle removeMagazinesTurret [_x, _turretPath];
		} forEach _magazines;
	} forEach (allTurrets [_vehicle, true]);
	
	// Set ammunition for vehicle weapons to zero
	{
		private _weapon = _x;
		private _magazines = _vehicle magazines [_weapon];
		
		{
			_vehicle removeMagazine _x;
		} forEach _magazines;
	} forEach _weapons;
	
	// Mark vehicle as processed
	_vehicle setVariable ["INFONLY_weaponsDisabled", true];
	_processedCount = _processedCount + 1;
} forEach _allVehicles;

[INFONLY_LOGLEVEL_DEBUG, format ["Finished checking vehicles. Processed %1 vehicles.", _processedCount]] call INFONLY_fnc_log;
