#include "macro.sqf"

private ['_cfg', '_allowedSlots', '_found'];
_cfg = _this call GEAR_fnc_getConfig;

_allowedSlots = [];
_found = {
	_allowedSlots = _allowedSlots + getArray _x;
	
	isArray _x
} count [
	_cfg >> "allowedSlots",
	_cfg >> "ItemInfo" >> "allowedSlots",
	_cfg >> "WeaponSlotsInfo" >> "allowedSlots"
];

if ( _found == 0 ) then {
	_allowedSlots = [GEAR_type_uniform, GEAR_type_vest, GEAR_type_backpack];
};

_allowedSlots