/*
	 recompile = 1 - Allows to edit code while Arma3 is running. Restart the mission to see changes. This is useful for debugging and development.
*/
class InfantryOnly
{
	tag = "INFONLY";
	
class Main
	{
		file = "\z\infonly\addons\main\functions\main";
		class handleVehicleSpawned {description = "Handles vehicle spawned events from CBA event handlers"; recompile = 1;};
		class handleTurretLocality {description = "Handles turret locality changes for vehicles"; recompile = 1;};
		class log {description = ""; recompile = 1;};
		class msgSideChat {description = ""; recompile = 1;};
		class disableVehicleWeapons {description = "Disables all weapons on vehicles by setting their ammunition to zero"; recompile = 1;};
		class isVehicleTypeAllowed {description = "Determines if a vehicle's type is allowed based on CBA settings"; recompile = 1;};
	};
	
	class Init
	{
		file = "\z\infonly\addons\main\init";
		class initModClient {description = "Initializes the mod on the clients"; recompile = 1;};
		class initModServer {description = "Initializes the mod on the server"; recompile = 1;};
	};
	
};