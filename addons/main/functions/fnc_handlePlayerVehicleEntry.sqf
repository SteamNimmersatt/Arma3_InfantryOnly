#include "functions.h"

/*
	Handles player entry into vehicles to show notifications about disabled weapons.
	This function is called when a player enters a vehicle to check if that vehicle
	has had its weapons disabled and notify the player if so.
	
	Parameter(s):
	_player: OBJECT - The player entering the vehicle
	_vehicle: OBJECT - The vehicle being entered
	
	Returns:
	Nothing
*/

params [["_player", objNull], ["_vehicle", objNull]];

// Validate parameters
if (isNull _player || isNull _vehicle) exitWith {};

// Check if notifications are enabled
if (isNil "INFONLY_showNotifications" || {!INFONLY_showNotifications}) exitWith {};

// Check if this vehicle has had its weapons disabled
if (isNil {_vehicle getVariable "INFONLY_weaponsDisabled"}) exitWith {};

// Check if vehicle type is allowed (if it's allowed, weapons aren't actually disabled)
if ([_vehicle] call infonly_main_fnc_isVehicleTypeAllowed) exitWith {};

// Format the vehicle name for better readability
private _vehicleType = typeOf _vehicle;
private _displayName = getText (configFile >> "CfgVehicles" >> _vehicleType >> "displayName");
if (_displayName isEqualTo "") then {
	_displayName = _vehicleType;
};

// Show notification to player
[format ["<t color='#FF8800'>Infantry Only:</t> Weapons disabled on %1", _displayName], 0, 0.5, 5, 1, 0] spawn BIS_fnc_dynamicText;
