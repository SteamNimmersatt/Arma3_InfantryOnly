#include "\z\infonly\addons\main\functions\functions.h"

/*
	Initializes CBA settings for the Infantry Only mod.
	This should be called during XEH preinit.
*/

// Define category and sub-category names
#define CBA_SETTINGS_CAT "Infantry Only"
#define SUB_CAT_GENERAL "General Settings"
#define SUB_CAT_VEHICLE "Vehicle Settings"


/////////////////////////////////////////////
//             General Settings
/////////////////////////////////////////////

// Enable/disable mod setting
[
    "INFONLY_enable",																// Unique setting name.  Matches resulting variable name.
    "CHECKBOX",																		// Type of setting.  Can be CHECKBOX, EDITBOX, LIST, SLIDER, COLOR, TIME.
    ["Enable Mod", "Enable or disable the whole mod."],	// Display name or display name + tooltip (optional, default: same as setting name).
    [CBA_SETTINGS_CAT, SUB_CAT_GENERAL],											// Category for the settings menu + optional sub-category.
    true,																			// Default value for the setting.
    true																			// '_isGlobal' flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;

// Log Level
[
    "INFONLY_logLevel",																// Unique setting name.  Matches resulting variable name.
    "LIST",																			// Type of setting.  Can be CHECKBOX, EDITBOX, LIST, SLIDER, COLOR, TIME.
    ["Logging Verbosity", "Set the mods log level. 'Debug' will log all levels."],	// Display name or display name + tooltip (optional, default: same as setting name).
    [CBA_SETTINGS_CAT, SUB_CAT_GENERAL],											// Category for the settings menu + optional sub-category.
    [[3, 2, 1, 0], ['Error', 'Warning', 'Info', 'Debug'], 2],						// Extra properties of the setting depending of _settingType. List: [_values, _valueTitles, _defaultIndex].
    true																			// '_isGlobal' flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;


/////////////////////////////////////////////
//             Vehicle Settings
/////////////////////////////////////////////

// Vehicle whitelist setting
[
    "INFONLY_vehicleWhitelist",														// Unique setting name.  Matches resulting variable name.
    "EDITBOX",																		// Type of setting.  Can be CHECKBOX, EDITBOX, LIST, SLIDER, COLOR, TIME.
    ["Vehicle Whitelist", "Comma-separated list of vehicle classnames that should NOT have their weapons depleted (e.g. B_APC_Wheeled_01_cannon_F,O_Heli_Light_02_unarmed_F)"],	// Display name or display name + tooltip (optional, default: same as setting name).
    [CBA_SETTINGS_CAT, SUB_CAT_VEHICLE],											// Category for the settings menu + optional sub-category.
    "",																				// Default value for the setting.
    true,																			// '_isGlobal' flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {																				// Optional callback function that is executed when the setting is changed.
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
    "INFONLY_allowStaticTurrets",													// Unique setting name.  Matches resulting variable name.
    "CHECKBOX",																		// Type of setting.  Can be CHECKBOX, EDITBOX, LIST, SLIDER, COLOR, TIME.
    ["Allow Static Turrets", "Allow static turrets (machine guns, grenade launchers, etc.) to keep their ammunition. When unchecked, static turrets will have their ammunition removed like other vehicles."],	// Display name or display name + tooltip (optional, default: same as setting name).
    [CBA_SETTINGS_CAT, SUB_CAT_VEHICLE],											// Category for the settings menu + optional sub-category.
    true,																			// Default value for the setting.
    true																			// '_isGlobal' flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;

// Allow technicals
[
    "INFONLY_allowTechnicals",														// Unique setting name.  Matches resulting variable name.
    "CHECKBOX",																		// Type of setting.  Can be CHECKBOX, EDITBOX, LIST, SLIDER, COLOR, TIME.
    ["Allow Technicals", "Allow technical vehicles (light wheeled armed vehicles like jeeps with machine guns) to keep their ammunition. When unchecked, technicals will have their ammunition removed like other vehicles."],	// Display name or display name + tooltip (optional, default: same as setting name).
    [CBA_SETTINGS_CAT, SUB_CAT_VEHICLE],											// Category for the settings menu + optional sub-category.
    false,																			// Default value for the setting.
    true																			// '_isGlobal' flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;

// Allow APCs / IFVs
[
    "INFONLY_allowAPCs",															// Unique setting name.  Matches resulting variable name.
    "CHECKBOX",																		// Type of setting.  Can be CHECKBOX, EDITBOX, LIST, SLIDER, COLOR, TIME.
    ["Allow APCs / IFVs", "Allow armored personnel carriers and infantry fighting vehicles to keep their ammunition. When unchecked, APCs/IFVs will have their ammunition removed like other vehicles."],	// Display name or display name + tooltip (optional, default: same as setting name).
    [CBA_SETTINGS_CAT, SUB_CAT_VEHICLE],											// Category for the settings menu + optional sub-category.
    false,																			// Default value for the setting.
    true																			// '_isGlobal' flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;

// Allow Tanks
[
    "INFONLY_allowTanks",															// Unique setting name.  Matches resulting variable name.
    "CHECKBOX",																		// Type of setting.  Can be CHECKBOX, EDITBOX, LIST, SLIDER, COLOR, TIME.
    ["Allow Tanks", "Allow main battle tanks and tank destroyers to keep their ammunition. When unchecked, tanks will have their ammunition removed like other vehicles."],	// Display name or display name + tooltip (optional, default: same as setting name).
    [CBA_SETTINGS_CAT, SUB_CAT_VEHICLE],											// Category for the settings menu + optional sub-category.
    false,																			// Default value for the setting.
    true																			// '_isGlobal' flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;

// Allow Helicopters
[
    "INFONLY_allowHelis",															// Unique setting name.  Matches resulting variable name.
    "CHECKBOX",																		// Type of setting.  Can be CHECKBOX, EDITBOX, LIST, SLIDER, COLOR, TIME.
    ["Allow Helicopters", "Allow helicopters to keep their ammunition. When unchecked, helicopters will have their ammunition removed like other vehicles."],	// Display name or display name + tooltip (optional, default: same as setting name).
    [CBA_SETTINGS_CAT, SUB_CAT_VEHICLE],											// Category for the settings menu + optional sub-category.
    false,																			// Default value for the setting.
    true																			// '_isGlobal' flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;

// Allow Planes
[
    "INFONLY_allowPlanes",															// Unique setting name.  Matches resulting variable name.
    "CHECKBOX",																		// Type of setting.  Can be CHECKBOX, EDITBOX, LIST, SLIDER, COLOR, TIME.
    ["Allow Planes", "Allow fixed-wing aircraft to keep their ammunition. When unchecked, planes will have their ammunition removed like other vehicles."],	// Display name or display name + tooltip (optional, default: same as setting name).
    [CBA_SETTINGS_CAT, SUB_CAT_VEHICLE],											// Category for the settings menu + optional sub-category.
    false,																			// Default value for the setting.
    true																			// '_isGlobal' flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;



[INFONLY_LOGLEVEL_INFO, "CBA settings initialized."] call infonly_main_fnc_log;
