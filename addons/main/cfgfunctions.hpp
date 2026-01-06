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
		class log {description = ""; recompile = 1};
		class msgSideChat {description = ""; recompile = 1};
	};
	
};
