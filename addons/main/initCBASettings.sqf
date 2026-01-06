/*
	Initializes CBA settings for the Infantry Only mod.
	This should be called during XEH preinit.
*/
#include "\z\infonly\addons\main\functions\functions.h"

// Define category and sub-category names
#define CBA_SETTINGS_CAT "Infantry Only"
#define SUB_CAT_GENERAL "General Settings"
#define SUB_CAT_VEHICLE "Vehicle Settings"
#define SUB_CAT_LOGGING "Logging Settings"

// Enable/disable mod setting
[
	"INFONLY_enable"
	,"CHECKBOX"
	,["Enable Infantry Only Mod", "Enable or disable the Infantry Only mod functionality"]
	,[CBA_SETTINGS_CAT, SUB_CAT_GENERAL]
	,true
	,true
] call CBA_fnc_addSetting;

// Vehicle whitelist setting
[
	"INFONLY_vehicleWhitelist"
	,"EDITBOX"
	,["Vehicle Whitelist", "Comma-separated list of vehicle classnames that should NOT have their weapons disabled (e.g. B_APC_Wheeled_01_cannon_F,O_Heli_Light_02_unarmed_F)"]
	,[CBA_SETTINGS_CAT, SUB_CAT_VEHICLE]
	,""
	,true
	,{
		params ["_value"];
		// Parse the whitelist when it changes
		if (_value isEqualType "") then {
			INFONLY_vehicleWhitelistParsed = _value splitString ",";
			{
				// Trim whitespace and convert to uppercase for consistent comparison
				INFONLY_vehicleWhitelistParsed set [_forEachIndex, trim(toUpper(_x))];
			} forEach INFONLY_vehicleWhitelistParsed;
		} else {
			INFONLY_vehicleWhitelistParsed = [];
		};
	}
] call CBA_fnc_addSetting;

// Allow static turrets to keep their ammunition
[
	"INFONLY_allowStaticTurretsAmmunition"
	,"CHECKBOX"
	,["Allow Static Turret Ammunition", "Allow static turrets (machine guns, grenade launchers, etc.) to keep their ammunition. When unchecked, static turrets will have their ammunition removed like other vehicles."]
	,[CBA_SETTINGS_CAT, SUB_CAT_VEHICLE]
	,true
	,true
] call CBA_fnc_addSetting;

// Logging verbosity setting
[
	"INFONLY_logLevel"
	,"LIST"
	,["Logging Verbosity", "Set the verbosity level for mod logging"]
	,[CBA_SETTINGS_CAT, SUB_CAT_LOGGING]
	,[["Disabled", "Errors Only", "Warnings and Errors", "Info", "Debug"], [0, 1, 2, 3, 4], 3]  // Default to "Info" level
	,true
] call CBA_fnc_addSetting;

[INFONLY_LOGLEVEL_INFO, "CBA settings initialized."] call INFONLY_fnc_log;
