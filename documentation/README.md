# Infantry Only Mod Documentation

## Overview
The Infantry Only mod enforces infantry-only gameplay in Arma 3 by preventing vehicles from using weapons. Vehicles can still be used for transportation, but all weapon systems are disabled.

## How It Works
The mod works by setting the ammunition for all vehicle weapons to zero, effectively preventing them from firing. This approach is applied to all types of vehicles including cars, tanks, helicopters, and aircraft.

### Implementation Details
1. **Initialization**: The mod initializes on both server and clients through the standard Arma 3 mod initialization system.
2. **Vehicle Detection**: The mod uses CBA event handlers to detect when new vehicles are spawned, with periodic scanning as a backup.
3. **Weapon Disabling**: For each vehicle with weapons, the mod removes all ammunition from turrets and weapons.
4. **Efficiency**: Vehicles are marked as processed to avoid redundant operations.

## CBA Integration
The mod is now fully integrated with CBA (Community Base Addons):

1. **Event-driven Vehicle Detection**: Uses CBA event handlers to detect when new vehicles are spawned:
   ```sqf
   ["vehicleSpawned", infonly_main_fnc_handleVehicleSpawned] call CBA_fnc_addEventHandler;
   ```

2. **CBA Settings**: Fully configurable options through CBA settings system:
   - Enable/disable the mod
   - Whitelist certain vehicle types
   - Logging verbosity level

3. **Performance Improvements**: Event-driven approach reduces CPU usage compared to periodic polling.

## Debugging
The mod uses the INFONLY logging system with different levels:
- DEBUG: Detailed information for troubleshooting
- INFO: General operational information
- WARNING: Potential issues that don't stop execution
- ERROR: Critical issues that may affect functionality

To increase logging verbosity, use the CBA settings interface to adjust the logging level.

## Performance Considerations
- The mod uses CBA event handlers for immediate vehicle processing
- Periodic scanning every 30 seconds serves as a backup
- Vehicles are marked as processed to avoid redundant operations
- The mod skips infantry units and vehicles without weapons
