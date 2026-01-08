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

// Allow static turrets
[
	"INFONLY_allowStaticTurrets"
	,"CHECKBOX"
	,["Allow Static Turret Ammunition", "Allow static turrets (machine guns, grenade launchers, etc.) to keep their ammunition. When unchecked, static turrets will have their ammunition removed like other vehicles."]
	,[CBA_SETTINGS_CAT, SUB_CAT_VEHICLE]
	,true
	,true
] call CBA_fnc_addSetting;

// Log Level
[
    "INFONLY_logLevel",																// Unique setting name.  Matches resulting variable name.
    "LIST",																			// Type of setting.  Can be CHECKBOX, EDITBOX, LIST, SLIDER, COLOR, TIME.
    ["Logging Verbosity", "Set the mods log level. 'Debug' will log all levels."],	// Display name or display name + tooltip (optional, default: same as setting name).
    [CBA_SETTINGS_CAT, SUB_CAT_LOGGING],											// Category for the settings menu + optional sub-category.
    [[3, 2, 1, 0], ['Error', 'Warning', 'Info', 'Debug'], 2],						// Extra properties of the setting depending of _settingType. List: [_values, _valueTitles, _defaultIndex].
    true																			// '_isGlobal' flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;


[INFONLY_LOGLEVEL_INFO, "CBA settings initialized."] call INFONLY_fnc_log;
