#include "functions.h"

/*
    Checks if a projectile should be blocked based on the CBA settings.
    If the projectile is in the blacklist and the setting is enabled, the projectile is deleted.
*/

params ["_projectile"];

// Check if the setting to disable scripted projectiles is enabled
if (INFONLY_allowScriptedProjectiles) exitWith {};

// Check if the projectile is in the blacklist and was created via script
if ((toUpper(typeOf _projectile)) in INFONLY_scriptedProjectileBlacklistParsed && {vehicle _projectile isEqualTo _projectile}) then {
    [INFONLY_LOGLEVEL_INFO, format["Blocked scripted projectile of type '%1'", typeOf _projectile]] call infonly_main_fnc_log;
    deleteVehicle _projectile;
};
