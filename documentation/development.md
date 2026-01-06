# Infantry Only Mod Development Guide

## Overview
This guide provides information for developers who want to contribute to or extend the Infantry Only mod. It covers the project structure, coding standards, and development workflow.

## Project Structure
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
        functions.h             # Header file with constants
    cfgfunctions.hpp            # Function registration
    cfgfunctionsaddon.hpp       # Addon function registration
    config.cpp                  # Mod configuration
    $PBOPREFIX$                 # PBO prefix file
    addon.toml              # HEMTT build configuration
documentation/
  README.md                   # Main documentation
  features.md                 # Feature list
  getting_started.md          # User guide
  development.md              # This file
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
3. Make sure you have HEMTT installed for packaging (optional)

### Making Changes
1. Create a new branch for your changes
2. Make your modifications following the coding standards
3. Test your changes in Arma 3
4. Update documentation if necessary
5. Submit a pull request

### Testing
1. **Local Testing**: Test changes in the editor using the `recompile = 1` setting
2. **Mission Testing**: Create a simple mission to test the mod functionality
3. **Multiplayer Testing**: Test in multiplayer environment if applicable
4. **Performance Testing**: Monitor performance impact of your changes

## CBA Integration Roadmap

### Phase 1: Basic Integration
1. Add CBA as a required addon in `config.cpp`
2. Implement CBA settings system for configuration
3. Use CBA logging functions instead of custom logging

### Phase 2: Event-Driven Processing
1. Replace periodic polling with CBA event handlers
2. Implement "vehicleSpawned" event handler
3. Add "vehicleDeleted" event handler for cleanup

### Phase 3: Advanced Features
1. Implement CBA keybinding system
2. Add CBA XEH (Extended Event Handlers) support
3. Create CBA-compatible API for other mods

## Performance Considerations

### Optimization Techniques
1. **Caching**: Cache results when possible to avoid redundant calculations
2. **Selective Processing**: Skip objects that don't need processing
3. **Batch Operations**: Process multiple objects together when possible
4. **Efficient Loops**: Use appropriate loop constructs for the data size

### Monitoring Performance
1. **Profiling**: Use Arma 3 profiling tools to identify bottlenecks
2. **Logging**: Add timing information to critical functions
3. **Memory Management**: Avoid memory leaks by properly cleaning up variables

## Extending Functionality

### Adding New Features
1. Identify the appropriate location for your new function
2. Create a new SQF file following the naming convention
3. Register the function in `cfgfunctions.hpp`
4. Call the function from the appropriate initialization point
5. Add logging for debugging and monitoring
6. Update documentation

### Mod Compatibility
1. **Namespace Isolation**: Use unique prefixes to avoid conflicts
2. **Event Handling**: Use CBA event handlers when possible for better compatibility
3. **Graceful Degradation**: Handle cases where required mods are not present

## Release Process

### Versioning
Follow semantic versioning (MAJOR.MINOR.PATCH):
- MAJOR: Breaking changes
- MINOR: New features
- PATCH: Bug fixes

### Packaging
1. Update version information in `mod.cpp`
2. Update changelog
3. Package using HEMTT
4. Test packaged mod
5. Create release archive

### Documentation Updates
1. Update README.md with new features
2. Update features.md with current capabilities
3. Update getting_started.md if installation process changes
4. Update development.md if development process changes
