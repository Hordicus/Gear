#include "macro.sqf"
private ['_loadout_info'];
_loadout_info = parseText format['Total: $%1', (GEAR_activeLoadout call GEAR_fnc_filterLoadout) call GEAR_fnc_loadoutTotal];
((findDisplay GEAR_dialog_idc) displayCtrl GEAR_purchase_info_idc) ctrlSetStructuredText _loadout_info;