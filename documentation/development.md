# Infantry Only Mod Development Guide

## Overview
This guide provides information for developers who want to contribute to or extend the Infantry Only mod. It covers the project structure, coding standards, and development workflow.

## Initial Development Setup

  - Download hemtt and place it in the root directory of the git repository (or just run the `build.sh` script).
  - Open the project in your preferred SQF editor (VS Code with SQF extension recommended)
  - Subscribe to the development mods listed in file `hemtt/launch.toml`, section `workshop`.

## Building the mod

   - Run "hemtt dev" to create a dev build.
   - Run "hemtt release" to create a signed release build.
   - See the HEMTT documentation for more information.

## Editing code while Arma3 is running

   - In file `script_component.hpp` uncomment the `DISABLE_COMPILE_CACHE` definition. Do not commit this.

   - Run the game via `hemtt launch`. HEMTT will create a symbolic link in the Arma3 game directory to the .hemttoutput dir in the project dir. It will build the mod and run the game as defined in `hemtt/launch.toml`.

   - After a code change you need to restart the mission to see the change.

   - You need to restart the game if you've added any files. You will also need to restart in some other special cases like new addon settings.

## Coding Standards

### SQF Coding Standards
1. **Function Naming**: All functions must use the `fn_` prefix followed by camelCase naming
2. **Function Registration**: All functions must be registered in `cfgfunctions.hpp`
3. **Header Comments**: Every function file must include detailed header comments explaining:
   - Function purpose
   - Parameter(s) with types and descriptions
   - Return value(s) with types and descriptions
4. **Logging**: Use the INFONLY logging system appropriately:
   - DEBUG: Detailed information for troubleshooting
   - INFO: General operational information
   - WARNING: Potential issues that don't stop execution
   - ERROR: Critical issues that may affect functionality
5. **Error Handling**: Always check for null objects and edge cases
6. **Variable Scope**: Use private variables where appropriate

### File Organization
1. **One Function Per File**: Each SQF file should contain only one function
2. **Logical Grouping**: Related functions should be in the same directory
3. **Include Files**: Use `#include` statements for shared constants and headers

### Constants and Definitions
1. **Header File**: Define constants in `functions.h`
2. **Naming Convention**: Use uppercase with underscores for constants
3. **Prefix**: Use `INFONLY_` prefix for all constants

## Development Workflow

### Making Changes
1. Create a new branch for your changes
2. Make your modifications following the coding standards
3. Test your changes in Arma 3
4. Update documentation if necessary
5. Submit a pull request

### Testing
1. **Singleplayer Testing**: Test changes in the editor. Enable the mod "CBA_A3 - Addon - Cache Disable" to change code while Arma is running.
3. **Multiplayer Testing**: Test in multiplayer environment if applicable
4. **Performance Testing**: Monitor performance impact of your changes
5. **CBA Settings Testing**: Test all CBA settings and their effects

## CBA Integration

The mod now fully integrates with CBA (Community Base Addons) for enhanced functionality:

### CBA Settings
- Settings are defined in `init/initCBASettings.sqf` using `CBA_fnc_addSetting`
- Settings include mod enable/disable, vehicle whitelist, logging verbosity, and advanced vehicle classification options.
- Callback functions are used to process settings when they change

### CBA Event Handlers
- The mod registers a "vehicleSpawned" event handler for immediate vehicle processing
- Both server and client register the event handler for proper multiplayer support
- Event-driven processing replaces most of the need for periodic polling
- Additional handling for turret locality changes when players enter/exit vehicle positions

### Best Practices for CBA Integration
1. **Settings**: Use `CBA_fnc_addSetting` for all user-configurable options
2. **Event Handlers**: Use CBA event handlers instead of polling when possible
3. **Logging**: Use the CBA logging verbosity setting
4. **Compatibility**: Always check if CBA is loaded before using CBA functions

## Release Process

### Versioning
Follow semantic versioning (MAJOR.MINOR.PATCH):
- MAJOR: Breaking changes
- MINOR: New features
- PATCH: Bug fixes

### Packaging
1. Update version information in `script_version.hpp` and `.hemtt/project.toml`
2. Update changelog
3. Package using HEMTT
4. Test packaged mod
5. Create release archive

### Documentation Updates
1. Update README.md with new features
2. Update features.md with current capabilities
3. Update getting_started.md if installation process changes
4. Update development.md if development process changes
