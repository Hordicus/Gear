#include "functions\macro.sqf"
disableSerialization;

_class        = _this select 1 select 0 select 2;
_type         = _class call GEAR_fnc_getType;
_allowedSlots = _class call GEAR_fnc_allowedSlots;

_bad = [];

{
	if !( _type == (_x select 0) || (_x select 0) in _allowedSlots ) then {
		_bad set [count _bad, _x select 1];
	};
	true
} count [
	[GEAR_type_uniform,     GEAR_select_uniform_bg_idc],
	[GEAR_type_vest,        GEAR_select_vest_bg_idc],
	[GEAR_type_backpack,    GEAR_select_backpack_bg_idc],
	[GEAR_type_helmet,      GEAR_select_helmet_bg_idc],
	[GEAR_type_glasses,     GEAR_select_glasses_bg_idc],
	[GEAR_type_nvg,         GEAR_select_nvg_bg_idc],
	[GEAR_type_binocular,   GEAR_select_binocular_bg_idc],
	[GEAR_type_map,         GEAR_item_map_bg_idc],
	[GEAR_type_gps,         GEAR_item_gps_bg_idc],
	[GEAR_type_radio,       GEAR_item_radio_bg_idc],
	[GEAR_type_compass,     GEAR_item_compass_bg_idc],
	[GEAR_type_watch,       GEAR_item_watch_bg_idc],
	[GEAR_type_primary,     GEAR_primary_bg_idc],
	[GEAR_type_secondary,   GEAR_secondary_bg_idc],
	[GEAR_type_pistol,      GEAR_pistol_bg_idc]

];

{
	if ( isNil {_x select 0} || { _x select 0 == "" } ) then {
		_bad = _bad + (_x select 1);
	}
	else {
		if ( _type != GEAR_type_muzzle || !([_x select 0, _class] call GEAR_fnc_validAttachment) ) then {
			_bad set [count _bad, _x select 1 select 0];
		};

		if ( _type != GEAR_type_acc || !([_x select 0, _class] call GEAR_fnc_validAttachment) ) then {
			_bad set [count _bad, _x select 1 select 1];
		};

		if ( _type != GEAR_type_optic || !([_x select 0, _class] call GEAR_fnc_validAttachment) ) then {
			_bad set [count _bad, _x select 1 select 2];
		};

		if ( !(_class in (getArray (configFile >> "CfgWeapons" >> _x select 0 >> "magazines"))) ) then {
			_bad set [count _bad, _x select 1 select 3];
		};
	};
	true
} count [
	[GEAR_activeLoadout select GEAR_index_primary, [
		GEAR_primary_muzzle_bg_idc,
		GEAR_primary_acc_bg_idc,
		GEAR_primary_optic_bg_idc,
		GEAR_primary_mag_bg_idc
	]],
	[GEAR_activeLoadout select GEAR_index_secondary, [
		GEAR_secondary_muzzle_bg_idc,
		GEAR_secondary_acc_bg_idc,
		GEAR_secondary_optic_bg_idc,
		GEAR_secondary_mag_bg_idc
	]],
	[GEAR_activeLoadout select GEAR_index_pistol, [
		GEAR_pistol_muzzle_bg_idc,
		GEAR_pistol_acc_bg_idc,
		GEAR_pistol_optic_bg_idc,
		GEAR_pistol_mag_bg_idc
	]]
];

_dialog = findDisplay GEAR_dialog_idc;
{
	(_dialog displayCtrl _x) ctrlSetBackgroundColor [0.3,0,0,0.5];
} count _bad;

[_bad] call GEAR_fnc_resetBackground;