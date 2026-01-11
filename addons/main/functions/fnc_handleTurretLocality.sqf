#include "functions.h"

/*
	Handles turret locality changes for vehicles.
	This function should be called when a player enters or exits a vehicle position,
	as turrets change locality when players become gunners.
	
	Parameter(s):
	_vehicle: OBJECT - The vehicle to check for turret locality changes
	
	Returns:
	Nothing
*/

params [["_vehicle", objNull]];

// Validate vehicle
if (isNull _vehicle) exitWith {
	[INFONLY_LOGLEVEL_DEBUG, "Null vehicle passed to turret locality handler. Skipping."] call infonly_main_fnc_log;
};

// Skip infantry units (we only want to handle actual vehicles)
if (_vehicle isKindOf "Man") exitWith {
	[INFONLY_LOGLEVEL_DEBUG, "Object of kind 'Man' passed to turret locality handler. Skipping."] call infonly_main_fnc_log;
};

// Check if we've already processed this vehicle locally to avoid unnecessary work
if (!isNil {_vehicle getVariable "INFONLY_weaponsDisabledLocal"}) exitWith {
	[INFONLY_LOGLEVEL_DEBUG, format ["Vehicle %1 has already been processed locally. Skipping.", typeOf _vehicle]] call infonly_main_fnc_log;
};

// Check if mod is enabled
if (!isNil "INFONLY_enable" && {!INFONLY_enable}) exitWith {
	[INFONLY_LOGLEVEL_DEBUG, "Mod is disabled. Skipping turret locality handling."] call infonly_main_fnc_log;
};

// Skip if vehicle is not local (ammo can only be set on local vehicles)
if (!local _vehicle) exitWith {
	[INFONLY_LOGLEVEL_DEBUG, format ["Vehicle %1 is not local. Skipping turret locality handling.", typeOf _vehicle]] call infonly_main_fnc_log;
};

// Check if vehicle type is allowed
if ([_vehicle] call infonly_main_fnc_isVehicleTypeAllowed) exitWith {
	[INFONLY_LOGLEVEL_DEBUG, format ["Vehicle of type '%1' is allowed to keep ammunition. Skipping turret locality handling.", typeOf _vehicle]] call infonly_main_fnc_log;
};



[INFONLY_LOGLEVEL_DEBUG, format ["Handling turret locality for vehicle: %1", typeOf _vehicle]] call infonly_main_fnc_log;

// Set vehicle ammunition to zero using the built-in Arma 3 command
// This affects all turrets and weapons on the vehicle that are local to this machine
_vehicle setVehicleAmmo 0;

// Mark vehicle as processed locally
_vehicle setVariable ["INFONLY_weaponsDisabledLocal", true];
