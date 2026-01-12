#include "config\script_component.hpp"
#include "init\CfgEventHandlers.hpp"

class CfgPatches
{
	class ADDON
	{
		name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"A3_Modules_F", "cba_main", "cba_xeh"};
        author = ECSTRING(common);
        authors[] = {"Nimmersatt"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
	};
};
