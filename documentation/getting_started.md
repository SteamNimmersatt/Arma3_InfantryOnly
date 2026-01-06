# Getting Started with Infantry Only Mod

## Usage
Once installed, the mod works automatically. All vehicles in the mission will have their weapons disabled, preventing them from firing. Vehicles can still be used for transportation.

The mod logs information to the Arma 3 RPT file. You can find this file at:
- Windows: `C:\Users\[Username]\AppData\Local\Arma 3\`
- macOS: `~/Library/Application Support/Steam/steamapps/common/Arma 3/`
- Linux: `~/.local/share/steam/steamapps/common/Arma 3/`

## Configuration

### CBA Settings
The mod now includes configurable settings through the CBA settings interface:
1. Launch Arma 3 with both CBA and Infantry Only mods enabled
2. Access the settings through the CBA settings menu (usually found in the ESC menu)
3. Look for "Infantry Only" in the settings categories

Available settings:
- **Enable/Disable Mod**: Toggle the mod functionality on/off
- **Vehicle Whitelist**: Specify vehicle types that should NOT have their weapons disabled
- **Allow Static Turret Ammunition**: Control whether static turrets (machine guns, grenade launchers, etc.) keep their ammunition (enabled by default)
- **Logging Verbosity**: Control the amount of information logged


## Troubleshooting

1. Check the RPT file for error messages
2. Verify that the mod is properly loaded
3. Check if the mod is enabled in CBA settings

## Development

### Coding Standards
- Use the INFONLY prefix for all functions
- Include detailed header comments for all functions
- Follow the existing code formatting style
- Add logging for important operations
- Handle edge cases (null objects, etc.)
- Add new CBA settings for specific features
