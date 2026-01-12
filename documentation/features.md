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

### CBA Integration
- **Event Handlers**: Uses CBA's "vehicleSpawned" event for immediate vehicle processing
- **Settings System**: Fully configurable through CBA settings interface
- **Extended Compatibility**: Integrates with other CBA-based mods

### Logging System
- **Multi-level Logging**: Supports DEBUG, INFO, WARNING, and ERROR log levels
- **RPT File Output**: Logs information to the Arma 3 RPT file for debugging
- **Configurable Verbosity**: Log level can be adjusted through CBA settings

## Configurable Settings

### General Settings
- **Enable/Disable Mod**: Toggle the mod functionality on/off through CBA settings

### Vehicle Settings
- **Vehicle Whitelist**: Specify vehicle types that should NOT have their weapons disabled
- **Allow Static Turret Ammunition**: Control whether static turrets (machine guns, grenade launchers, etc.) keep their ammunition (enabled by default)
- **Allow Technical Vehicles**: Control whether technical vehicles (armed light wheeled vehicles) keep their ammunition
- **Allow APCs / IFVs**: Control whether armored personnel carriers and infantry fighting vehicles keep their ammunition
- **Allow Tanks**: Control whether main battle tanks and tank destroyers keep their ammunition
- **Allow Helicopters**: Control whether helicopters keep their ammunition
- **Allow Fixed-Wing Aircraft**: Control whether fixed-wing aircraft keep their ammunition
- **Allow UAVs/Drones**: Control whether unmanned aerial/ground vehicles keep their ammunition
- **UAV Base Classes**: Customize which UAV/Drone base classes are allowed to keep their ammunition
- **Allow Naval Vessels**: Control whether naval vessels (boats, ships) keep their ammunition
- **Naval Base Classes**: Customize which naval vessel base classes are allowed to keep their ammunition

### Logging Settings
- **Logging Verbosity**: Control the amount of information logged (Disabled, Errors Only, Warnings, Info, Debug)

## Planned Features

### TODO
