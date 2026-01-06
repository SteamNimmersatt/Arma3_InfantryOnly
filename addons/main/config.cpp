class CfgPatches
{
	class InfantryOnly
	{
		units[] = {"InfantryOnly_Commanders","InfantryOnly_Groups"};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_Modules_F", "cba_main", "cba_xeh"};
	};
};

class CfgFunctions {
	#include "cfgfunctions.hpp"
	#include "cfgfunctionsaddon.hpp"
};
