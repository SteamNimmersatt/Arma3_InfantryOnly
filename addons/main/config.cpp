#include "config\script_component.hpp"
#include "init\CfgEventHandlers.hpp"

class CfgPatches
{
	class InfantryOnly
	{
		units[] = {};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_Modules_F", "cba_main", "cba_xeh"};
	};
};

class CfgFunctions {
	#include "cfgfunctions.hpp"
};
