#include "functions.h"

/*
	Logs the given message to the RPT file.

	Parameter(s):
	_this select 0: STRING - Message to log.	
*/

private _logLevelNumeric = param [0];
private _msg = param [1];

// Use CBA setting for log level, default to INFO level (3) if setting not available
private _logLevelSetting = if (isNil "INFONLY_logLevel") then { 3 } else { 
    private _setting = INFONLY_logLevel;
    // Ensure the setting is a number, default to INFO level (3) if not
    [3, _setting] select (_setting isEqualType 0)
};

if (_logLevelNumeric < _logLevelSetting) exitWith {}; // Don't log if the message is below our current log level setting.

private _logLevelText = switch (_logLevelNumeric) do {
	case INFONLY_LOGLEVEL_DEBUG: {"DEBUG"};
	case INFONLY_LOGLEVEL_INFO: {"INFO"};
	case INFONLY_LOGLEVEL_WARNING: {"WARNING"};
	case INFONLY_LOGLEVEL_ERROR: {"ERROR"};
	default {"INVALID LOG LEVEL"};
};

diag_log text format ["%1 - %2 - %3", "[InfOnly]", _logLevelText, _msg];
