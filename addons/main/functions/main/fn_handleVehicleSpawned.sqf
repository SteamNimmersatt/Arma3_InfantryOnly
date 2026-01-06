#include "functions.h"

/*
	Handles vehicle spawned events from CBA event handlers.
	This function is called whenever a new vehicle is spawned in the mission.
	
	This function processes vehicles that are local to the machine executing it.
	In multiplayer environments:
	- Server processes vehicles local to the server
	- Clients process vehicles local to those clients
	
	Parameter(s):
	_this select 0: OBJECT - The vehicle that was spawned
	
	Returns:
	Nothing
*/

private _vehicle = param [0, objNull];

// Check if mod is enabled
if (!isNil "INFONLY_enable" && {!INFONLY_enable}) exitWith {
	[INFONLY_LOGLEVEL_DEBUG, "Mod is disabled. Skipping vehicle spawn handling."] call INFONLY_fnc_log;
};

// Validate vehicle
if (isNull _vehicle) exitWith {
	[INFONLY_LOGLEVEL_DEBUG, "Null vehicle passed to spawn handler. Skipping."] call INFONLY_fnc_log;
};

// Skip infantry units (we only want to disable weapons on actual vehicles)
if (_vehicle isKindOf "Man") exitWith {
	[INFONLY_LOGLEVEL_DEBUG, "Infantry unit passed to spawn handler. Skipping."] call INFONLY_fnc_log;
};

// Check whitelist - skip vehicles that are in the whitelist
if (!isNil "INFONLY_vehicleWhitelistParsed" && {count INFONLY_vehicleWhitelistParsed > 0}) then {
	private _vehicleType = toUpper(typeOf _vehicle);
	if (_vehicleType in INFONLY_vehicleWhitelistParsed) exitWith {
		[INFONLY_LOGLEVEL_DEBUG, format ["Skipping whitelisted vehicle spawn: %1", _vehicleType]] call INFONLY_fnc_log;
	};
};

// Skip if vehicle has no weapons
private _weapons = weapons _vehicle;
if (count _weapons == 0) exitWith {
	[INFONLY_LOGLEVEL_DEBUG, format ["Vehicle %1 has no weapons. Skipping.", typeOf _vehicle]] call INFONLY_fnc_log;
};

// Skip if vehicle is not local (ammo can only be set on local vehicles)
if (!local _vehicle) exitWith {
	[INFONLY_LOGLEVEL_DEBUG, format ["Vehicle %1 is not local. Skipping.", typeOf _vehicle]] call INFONLY_fnc_log;
};

// Check if this is a static weapon and if we should allow it to keep ammunition
if (_vehicle isKindOf "StaticWeapon" && {!isNil "INFONLY_allowStaticTurretsAmmunition"} && {INFONLY_allowStaticTurretsAmmunition}) exitWith {
	[INFONLY_LOGLEVEL_DEBUG, format ["Static weapon %1 is allowed to keep ammunition. Skipping.", typeOf _vehicle]] call INFONLY_fnc_log;
	// Mark as processed to avoid rechecking
	_vehicle setVariable ["INFONLY_weaponsDisabled", true];
};

[INFONLY_LOGLEVEL_DEBUG, format ["Disabling weapons on newly spawned vehicle: %1", typeOf _vehicle]] call INFONLY_fnc_log;

// Set vehicle ammunition to zero using the built-in Arma 3 command
// This affects all turrets and weapons on the vehicle
_vehicle setVehicleAmmo 0;

// Mark vehicle as processed
_vehicle setVariable ["INFONLY_weaponsDisabled", true];
