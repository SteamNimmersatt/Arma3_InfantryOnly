#include "functions.h"

/*
	Determines if a vehicle's type is allowed based on CBA settings.
	This function checks the vehicle against the various allow settings
	(technicals, APCs, tanks, etc.) and returns whether it should be allowed
	to keep its ammunition.
	
	Parameter(s):
	_vehicle: OBJECT - The vehicle to check
	
	Returns:
	BOOL - True if the vehicle type is allowed, false otherwise
*/

params [["_vehicle", objNull]];

// Validate vehicle
if (isNull _vehicle) exitWith {
	false
};

// Skip infantry units (we only want to handle actual vehicles)
if (_vehicle isKindOf "Man") exitWith {
	false
};

// Check if mod is enabled
if (!isNil "INFONLY_enable" && {!INFONLY_enable}) exitWith {
	true
};

// Check whitelist - allow vehicles that are in the whitelist
if (!isNil "INFONLY_vehicleWhitelistParsed" && {count INFONLY_vehicleWhitelistParsed > 0}) then {
	private _vehicleType = toUpper(typeOf _vehicle);
	if (_vehicleType in INFONLY_vehicleWhitelistParsed) exitWith {
		true
	};
};

// Check if vehicle has no weapons
private _weapons = weapons _vehicle;
if (count _weapons == 0) exitWith {
	true
};

// Check static weapons
if (_vehicle isKindOf "StaticWeapon" && {!isNil "INFONLY_allowStaticTurrets"} && {INFONLY_allowStaticTurrets}) exitWith {
	true
};

// Check technicals (light wheeled armed vehicles)
if (!isNil "INFONLY_allowTechnicals" && {INFONLY_allowTechnicals}) then {
	// Common technical vehicle base classes
	private _technicalBaseClasses = [
		"LSV_01_armed_F",
		"LSV_02_armed_F",
		"MRAP_01_gmg_F",
		"MRAP_01_hmg_F",
		"MRAP_02_hmg_F",
		"MRAP_03_hmg_F",
		"Offroad_01_armed_F",
		"Offroad_01_AT_F",
		"Offroad_01_LMG_F",
		"Offroad_01_MG_F",
		"Quadbike_01_armed_F",
		"Van_01_transport_F" // Some variants of this can be armed
	];
	
	// Check if vehicle is a technical or inherits from one
	{
		if (_vehicle isKindOf _x) exitWith {
			true
		};
	} forEach _technicalBaseClasses;
};

// Check APCs / IFVs
if (!isNil "INFONLY_allowAPCs" && {INFONLY_allowAPCs}) then {
	// Common APC/IFV base classes
	private _apcBaseClasses = [
		"APC_Tracked_01_base_F",
		"APC_Tracked_02_base_F",
		"APC_Tracked_03_base_F",
		"APC_Wheeled_01_base_F",
		"APC_Wheeled_02_base_F",
		"APC_Wheeled_03_base_F"
	];
	
	// Check if vehicle is an APC/IFV or inherits from one
	{
		if (_vehicle isKindOf _x) exitWith {
			true
		};
	} forEach _apcBaseClasses;
};

// Check tanks
if (!isNil "INFONLY_allowTanks" && {INFONLY_allowTanks}) then {
	// Common tank base classes
	private _tankBaseClasses = [
		"MBT_01_base_F",
		"MBT_02_base_F",
		"MBT_03_base_F",
		"MBT_04_base_F"
	];
	
	// Check if vehicle is a tank or inherits from one
	{
		if (_vehicle isKindOf _x) exitWith {
			true
		};
	} forEach _tankBaseClasses;
};

// Check helicopters
if (!isNil "INFONLY_allowHelis" && {INFONLY_allowHelis}) then {
	// Check if vehicle is a helicopter
	if (_vehicle isKindOf "Helicopter") exitWith {
		true
	};
};

// Check planes
if (!isNil "INFONLY_allowPlanes" && {INFONLY_allowPlanes}) then {
	// Check if vehicle is a plane
	if (_vehicle isKindOf "Plane") exitWith {
		true
	};
};

// If none of the above conditions matched, the vehicle type is not allowed
false