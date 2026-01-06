/*
	 recompile = 1 - Allows to edit code while Arma3 is running. Restart the mission to see changes. This is useful for debugging and development.
*/
class InfantryOnly
{
	tag = "INFONLY";
	
	class Main
	{
		file = "\z\infonly\addons\main\functions\main";
		class initMod {description = ""; recompile = 1};
		class initModClient {description = ""; recompile = 1};
		class initModServer {description = "Initializes server-side components of the mod"; recompile = 1};
		class initCBASettings {description = "Initializes CBA settings for the mod"; recompile = 1};
		class handleVehicleSpawned {description = "Handles vehicle spawned events from CBA event handlers"; recompile = 1};
		class handleTurretLocality {description = "Handles turret locality changes for vehicles"; recompile = 1};
		class log {description = ""; recompile = 1};
		class msgSideChat {description = ""; recompile = 1};
		class disableVehicleWeapons {description = "Disables all weapons on vehicles by setting their ammunition to zero"; recompile = 1};
	};
	
};
