# Infantry Only Mod Documentation

## Overview
The Infantry Only mod enforces infantry-only gameplay in Arma 3 by preventing vehicles from using weapons. Vehicles can still be used for transportation, but all weapon systems are disabled.

## How It Works
The mod works by setting the ammunition for all vehicle weapons to zero, effectively preventing them from firing. This approach is applied to all types of vehicles including cars, tanks, helicopters, and aircraft.

### Implementation Details
1. **Initialization**: The mod initializes on both server and clients through the standard Arma 3 mod initialization system.
2. **Vehicle Detection**: The mod scans all vehicles in the mission periodically.
3. **Weapon Disabling**: For each vehicle with weapons, the mod removes all ammunition from turrets and weapons.
4. **Efficiency**: Vehicles are marked as processed to avoid redundant operations.

### Files Structure
- `addons/main/functions/main/fn_initMod.sqf` - Main initialization function
- `addons/main/functions/main/fn_initModClient.sqf` - Client-specific initialization
- `addons/main/functions/main/fn_initModAddon.sqf` - Addon-specific initialization
- `addons/main/functions/main/fn_disableVehicleWeapons.sqf` - Core function that disables vehicle weapons
- `addons/main/cfgfunctions.hpp` - Function registration

## CBA Integration (Planned)
The mod is designed to integrate with CBA (Community Base Addons) in the future. The planned improvements include:

1. **Event-driven Vehicle Detection**: Instead of periodic polling, use CBA event handlers to detect when new vehicles are spawned:
   ```sqf
   // TODO: Implement CBA event handler
   // CBA_fnc_addEventHandler for "vehicleSpawned" event
   ```

2. **CBA Settings**: Add configurable options through CBA settings system:
   - Enable/disable the mod
   - Whitelist certain vehicle types
   - Logging verbosity level

3. **Performance Improvements**: Event-driven approach would reduce CPU usage compared to periodic polling.

## Extending the Mod
To extend the mod functionality:

1. Create new function files in `addons/main/functions/main/`
2. Register new functions in `addons/main/cfgfunctions.hpp`
3. Call new functions from the appropriate initialization points

## Debugging
The mod uses the INFONLY logging system with different levels:
- DEBUG: Detailed information for troubleshooting
- INFO: General operational information
- WARNING: Potential issues that don't stop execution
- ERROR: Critical issues that may affect functionality

To increase logging verbosity, modify the `_logLevelSetting` variable in `fn_log.sqf`.

## Performance Considerations
- The mod checks vehicles every 30 seconds by default
- Vehicles are marked as processed to avoid redundant operations
- The mod skips infantry units and vehicles without weapons
