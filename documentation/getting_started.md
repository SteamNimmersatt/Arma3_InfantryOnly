# Getting Started with Infantry Only Mod

## Installation

### As an Addon
1. Download the mod files
2. Place the mod folder in your Arma 3 mods directory
3. Launch Arma 3 with the mod enabled using the `-mod` parameter or through the Steam launcher

### As a Mission Script
1. Copy the `addons/main` folder to your mission folder
2. Add the following line to your mission's `init.sqf` file:
   ```sqf
   call compile preprocessFileLineNumbers "addons\main\functions\main\fn_initMod.sqf";
   ```

## Usage
Once installed, the mod works automatically. All vehicles in the mission will have their weapons disabled, preventing them from firing. Vehicles can still be used for transportation.

The mod logs information to the Arma 3 RPT file. You can find this file at:
- Windows: `C:\Users\[Username]\AppData\Local\Arma 3\`
- macOS: `~/Library/Application Support/Steam/steamapps/common/Arma 3/`
- Linux: `~/.local/share/steam/steamapps/common/Arma 3/`

## Configuration

### Log Level Adjustment
To change the logging verbosity:
1. Open `addons/main/functions/main/fn_log.sqf`
2. Modify the `_logLevelSetting` variable:
   ```sqf
   private _logLevelSetting = 1; // 0=DEBUG, 1=INFO, 2=WARNING, 3=ERROR
   ```

### Scan Interval Adjustment
To change how often the mod checks for new vehicles:
1. Open `addons/main/functions/main/fn_initMod.sqf`
2. Modify the sleep interval in the spawn block:
   ```sqf
   sleep 30; // Change this value to adjust frequency (in seconds)
   ```

## Extending the Mod

### Adding New Functions
1. Create a new SQF file in `addons/main/functions/main/` with the naming convention `fn_yourFunctionName.sqf`
2. Add your function to `addons/main/cfgfunctions.hpp`:
   ```cpp
   class Main
   {
       file = "\z\infonly\addons\main\functions\main";
       // ... existing functions ...
       class yourFunctionName {description = "Description of your function"; recompile = 1};
   };
   ```
3. Call your function using the standard prefix:
   ```sqf
   [] call INFONLY_fnc_yourFunctionName;
   ```

### Modifying Existing Behavior
1. Locate the relevant function file in `addons/main/functions/main/`
2. Make your changes to the SQF file
3. Test your changes in a mission (the `recompile = 1` setting allows for testing without repacking the mod)

## Troubleshooting

### Vehicles Still Have Weapons
1. Check the RPT file for error messages
2. Verify that the mod is properly loaded
3. Ensure the scan interval is appropriate for your mission (some missions spawn vehicles very quickly)

### Performance Issues
1. Increase the scan interval in `fn_initMod.sqf`
2. Check the RPT file for any infinite loops or errors
3. Consider implementing CBA event handlers for more efficient processing

### Mod Not Loading
1. Verify that the mod folder structure is correct
2. Check that all required files are present
3. Ensure that the mod is enabled in the launcher or startup parameters

## Development

### Project Structure
```
addons/
  main/
    functions/
      main/
        fn_initMod.sqf          # Main initialization
        fn_initModAddon.sqf     # Addon-specific initialization
        fn_initModClient.sqf    # Client-specific initialization
        fn_disableVehicleWeapons.sqf  # Core functionality
        fn_log.sqf              # Logging system
        fn_msgSideChat.sqf      # Side chat messaging
    cfgfunctions.hpp            # Function registration
    config.cpp                  # Mod configuration
documentation/
  README.md                   # Main documentation
  features.md                 # Feature list
  getting_started.md          # This file
  development.md              # Development guidelines
```

### Coding Standards
- Use the INFONLY prefix for all functions
- Include detailed header comments for all functions
- Follow the existing code formatting style
- Add logging for important operations
- Handle edge cases (null objects, etc.)
