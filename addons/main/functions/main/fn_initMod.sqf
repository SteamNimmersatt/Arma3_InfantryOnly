#include "\z\infonly\addons\main\functions\functions.h"

/*
	Starts the mod. Must be executed on all clients & the server. Will be executed automatically
	if running the mod as an addon. If running the mod as a script embedded 
	inside a mission, this should be executed from the init.sqf file (e.g. call INFONLY_fnc_initMod; )

	Parameter(s):
	_this select 0: BOOLEAN - Auto-configure commanders & the groups they can command (optional, defaults to true)
	
		Note: If this is set to false, it's the responsibility of the mission creator using 
		scripts to define commanders and their associated groups.	
*/

// Prevent init from running twice
if(!isNil "INFONLY_INIT") exitWith {}; 
INFONLY_INIT = true;

params [["_autoConfigureCommanders",true]];

[INFONLY_LOGLEVEL_INFO, "Initializing mod."] call INFONLY_fnc_log;

INFONLY_INIT_STARTUP_SCRIPTS_EXECUTED = true;

if(!_autoConfigureCommanders || !isServer) exitWith {};

// Auto-configure commanders and groups under command

private["_commandersModules","_groupsModules","_configurationMode"];

_commandersModules = allMissionObjects "AdvancedAICommand_Commanders";
_groupsModules = allMissionObjects "AdvancedAICommand_Groups";

_configurationMode = "ALL_COMMANDERS_ALL_GROUPS";
if(count _commandersModules > 0) then {
	[INFONLY_LOGLEVEL_INFO, "Found modules of type 'AdvancedAICommand_Commanders'. Will configure these commanders."] call INFONLY_fnc_log;

	if(count _groupsModules > 0) then {
		[INFONLY_LOGLEVEL_INFO, "Found modules of type 'AdvancedAICommand_Groups'. Will assign the specific groups to the commanders."] call INFONLY_fnc_log;
		_configurationMode = "SPECIFIED_COMMANDERS_SPECIFIED_GROUPS"
	} else {
		[INFONLY_LOGLEVEL_INFO, "Found NO modules of type 'AdvancedAICommand_Groups'. Will assign all local-side groups to the commanders."] call INFONLY_fnc_log;
		_configurationMode = "SPECIFIED_COMMANDERS_ALL_GROUPS"
	};
} else {
	// TODO: Respect future CBA setting.
	[INFONLY_LOGLEVEL_INFO, "Could not find any modules of type 'AdvancedAICommand_Commanders'. Will make everyone a commander."] call INFONLY_fnc_log;
};

if(_configurationMode == "SPECIFIED_COMMANDERS_SPECIFIED_GROUPS") then {
	_commandControlIndex = 0;
	{
		_commandControlId = "COMMAND_MODULE_" + (str _commandControlIndex);
		[_commandControlId] call INFONLY_fnc_createCommandControl;
		{
			if(typeOf _x == "AdvancedAICommand_Groups") then {
				{
					if(typeOf _x != "AdvancedAICommand_Commanders" && !isNull (group _x)) then {
						[_commandControlId,group _x] call INFONLY_fnc_commandControlAddGroup;
					};
				} forEach ( synchronizedObjects _x );
			};
		} forEach (synchronizedObjects _x);
		[_configurationMode, [_x, _commandControlId]] remoteExec ["INFONLY_fnc_initModClient", 0, true];
		_commandControlIndex = _commandControlIndex + 1;
	} forEach _commandersModules;
};

if(_configurationMode == "SPECIFIED_COMMANDERS_ALL_GROUPS") then {
	{
		[_configurationMode, [_x]] remoteExec ["INFONLY_fnc_initModClient", 0, true];
	} forEach _commandersModules;
};

if(_configurationMode == "ALL_COMMANDERS_ALL_GROUPS") then {
	[_configurationMode] remoteExec ["INFONLY_fnc_initModClient", 0, true];
};









