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
	[INFONLY_LOGLEVEL_DEBUG, "Null vehicle passed to turret locality handler. Skipping."] call INFONLY_fnc_log;
};

// Skip infantry units (we only want to handle actual vehicles)
if (_vehicle isKindOf "Man") exitWith {
	[INFONLY_LOGLEVEL_DEBUG, "Infantry unit passed to turret locality handler. Skipping."] call INFONLY_fnc_log;
};

// Check if mod is enabled
if (!isNil "INFONLY_enable" && {!INFONLY_enable}) exitWith {
	[INFONLY_LOGLEVEL_DEBUG, "Mod is disabled. Skipping turret locality handling."] call INFONLY_fnc_log;
};

// Check whitelist - skip vehicles that are in the whitelist
if (!isNil "INFONLY_vehicleWhitelistParsed" && {count INFONLY_vehicleWhitelistParsed > 0}) then {
	private _vehicleType = toUpper(typeOf _vehicle);
	if (_vehicleType in INFONLY_vehicleWhitelistParsed) exitWith {
		[INFONLY_LOGLEVEL_DEBUG, format ["Skipping whitelisted vehicle in turret locality handler: %1", _vehicleType]] call INFONLY_fnc_log;
	};
};

// Skip if vehicle has no weapons
private _weapons = weapons _vehicle;
if (count _weapons == 0) exitWith {
	[INFONLY_LOGLEVEL_DEBUG, format ["Vehicle %1 has no weapons. Skipping turret locality handling.", typeOf _vehicle]] call INFONLY_fnc_log;
};

// Skip if vehicle is not local (ammo can only be set on local vehicles)
if (!local _vehicle) exitWith {
	[INFONLY_LOGLEVEL_DEBUG, format ["Vehicle %1 is not local. Skipping turret locality handling.", typeOf _vehicle]] call INFONLY_fnc_log;
};

[INFONLY_LOGLEVEL_DEBUG, format ["Handling turret locality for vehicle: %1", typeOf _vehicle]] call INFONLY_fnc_log;

// Set vehicle ammunition to zero using the built-in Arma 3 command
// This affects all turrets and weapons on the vehicle that are local to this machine
_vehicle setVehicleAmmo 0;

// Mark vehicle as processed
_vehicle setVariable ["INFONLY_weaponsDisabled", true];
