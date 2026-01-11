# Infantry Only Mod Features

## Current Features

### Vehicle Weapon Disabling
- **Comprehensive Coverage**: Disables weapons on all types of vehicles including cars, trucks, armored vehicles, helicopters, and aircraft
- **All Weapon Systems**: Removes ammunition from all turrets, weapons, and missile systems on vehicles
- **Event-Driven Processing**: Uses CBA event handlers to respond immediately when vehicles are spawned
- **Periodic Updates**: Checks for newly spawned vehicles every 30 seconds as a backup to event handlers
- **Turret Locality Handling**: Addresses the issue where turrets become local to a machine when players enter them as gunners
- **Frequent Locality Checks**: Checks for vehicles with changed locality every 5 seconds to ensure proper weapon disabling
- **Efficient Processing**: Marks vehicles as processed to avoid redundant operations
- **Selective Application**: Only affects actual vehicles, not infantry units

### CBA Integration
- **Event Handlers**: Uses CBA's "vehicleSpawned" event for immediate vehicle processing
- **Settings System**: Fully configurable through CBA settings interface
- **Extended Compatibility**: Integrates with other CBA-based mods

### Initialization System
- **Clear Execution Contexts**: Separated initialization logic into distinct server, client, and universal components
- **Server-Client Architecture**: Properly initializes on both server and client machines
- **Double Initialization Prevention**: Prevents the mod from initializing multiple times
- **Addon Compatibility**: Works as both a mission script and addon

### Logging System
- **Multi-level Logging**: Supports DEBUG, INFO, WARNING, and ERROR log levels
- **RPT File Output**: Logs information to the Arma 3 RPT file for debugging
- **Configurable Verbosity**: Log level can be adjusted through CBA settings

### Code Quality
- **Modular Design**: Functions are separated into individual files for maintainability
- **Clear Documentation**: Each function includes detailed header comments
- **Standard Naming Convention**: Uses infonly_main_fnc_ prefix for all functions
- **Error Handling**: Includes checks for null objects and other edge cases

## Configurable Settings

### General Settings
- **Enable/Disable Mod**: Toggle the mod functionality on/off through CBA settings

### Vehicle Settings
- **Vehicle Whitelist**: Specify vehicle types that should NOT have their weapons disabled
- **Allow Static Turret Ammunition**: Control whether static turrets (machine guns, grenade launchers, etc.) keep their ammunition (enabled by default)

### Logging Settings
- **Logging Verbosity**: Control the amount of information logged (Disabled, Errors Only, Warnings, Info, Debug)

## Planned Features

### Performance Enhancements
- **Optimized Scanning**: More intelligent vehicle scanning algorithms
- **Reduced Frequency**: Less frequent checks with more targeted updates

### Advanced Options
- **Mission Maker Controls**: Tools for mission creators to customize behavior
