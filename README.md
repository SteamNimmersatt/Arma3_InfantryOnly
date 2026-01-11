# Arma3_InfantryOnly
Arma3 mod which enforces infantry-only gameplay

## Features
This mod disables all weapons on vehicles, forcing infantry-only gameplay while still allowing vehicles for transportation. Key features include:

- **Complete Vehicle Weapon Disabling**: Removes ammunition from all vehicle weapons and turrets
- **CBA Integration**: Fully integrated with CBA for enhanced functionality
- **Configurable Settings**: Adjustable through CBA settings interface
- **Event-Driven Processing**: Uses CBA event handlers for immediate response to vehicle spawning
- **Whitelist Support**: Configure specific vehicle types to retain their weapons
- **Multiplayer Compatible**: Works in both singleplayer and multiplayer environments

## Development
### Initial setup

    Download hemtt and place it in the root directory of the git repository.
    Subscribe to the development mods listed in file "hemtt/launch.toml", section "workshop".

### Building the mod

    Run "hemtt dev" (Windows: "hemtt.exe dev") to create a dev build.
    Run "hemtt release" to create a signed release build.
    See the full hemtt documentation for more information.

### Editing code while Arma3 is running

    Run the game via "hemtt launch" (Windows: "hemtt.exe launch")
        This will create a symbolic link in the Arma3 game directory to the source code of the git repository.
        It will build the mod and run the game as defined in "hemtt/launch.toml".
    After a code change you need to restart the mission to see the change.
        You need to restart the game if you've added any files. You will also need to restart in some other special cases like new addon settings.

