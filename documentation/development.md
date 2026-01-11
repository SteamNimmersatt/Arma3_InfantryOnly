# Infantry Only Mod Development Guide

## Overview
This guide provides information for developers who want to contribute to or extend the Infantry Only mod. It covers the project structure, coding standards, and development workflow.

## Project Structure
```
addons/
  main/
    config/                     # Configuration files (CBA definitions, Component config etc.)
    init/                       # Initialization files (XEH, CBA settings etc.)
    functions/                  # Mod functionality
    cfgfunctions.hpp            # Function registration
    config.cpp                  # Mod configuration
    addon.toml                  # HEMTT build configuration
```

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

### Setting Up Development Environment
1. Clone or download the repository
2. Open the project in your preferred SQF editor (VS Code with SQF extension recommended)
3. Download HEMMT and place it into the project dir: https://github.com/BrettMayson/HEMTT/releases/latest/

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
- Settings include mod enable/disable, vehicle whitelist, and logging verbosity
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

## Performance Considerations

### Optimization Techniques
1. **Event-Driven Processing**: Use CBA event handlers instead of periodic polling
2. **Caching**: Cache results when possible to avoid redundant calculations
3. **Selective Processing**: Skip objects that don't need processing
4. **Batch Operations**: Process multiple objects together when possible
5. **Efficient Loops**: Use appropriate loop constructs for the data size
6. **Locality-Aware Processing**: Only process vehicles that are local to the current machine
7. **Tiered Polling**: Use different polling frequencies for different tasks (frequent for critical operations, less frequent for backups)

### Monitoring Performance
1. **Profiling**: Use Arma 3 profiling tools to identify bottlenecks
2. **Logging**: Add timing information to critical functions
3. **Memory Management**: Avoid memory leaks by properly cleaning up variables

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
