#include "macro.sqf"
private ['_dialog', '_exclude'];
disableSerialization;
_dialog = findDisplay GEAR_dialog_idc;

_exclude = [_this, 0, [], [[]]] call BIS_fnc_param;

{
	if !( _x in _exclude ) then {
		(_dialog displayCtrl _x) ctrlSetBackgroundColor [0,0,0,0.5];
	};
	true
} count [
	GEAR_select_uniform_bg_idc,
	GEAR_select_vest_bg_idc,
	GEAR_select_backpack_bg_idc,
	GEAR_select_helmet_bg_idc,
	GEAR_select_glasses_bg_idc,
	GEAR_select_nvg_bg_idc,
	GEAR_select_binocular_bg_idc,
	GEAR_item_map_bg_idc,
	GEAR_item_gps_bg_idc,
	GEAR_item_radio_bg_idc,
	GEAR_item_compass_bg_idc,
	GEAR_item_watch_bg_idc,
	GEAR_primary_bg_idc,
	GEAR_secondary_bg_idc,
	GEAR_pistol_bg_idc,
	GEAR_primary_muzzle_bg_idc,
	GEAR_primary_acc_bg_idc,
	GEAR_primary_optic_bg_idc,
	GEAR_primary_mag_bg_idc,
	GEAR_secondary_muzzle_bg_idc,
	GEAR_secondary_acc_bg_idc,
	GEAR_secondary_optic_bg_idc,
	GEAR_secondary_mag_bg_idc,
	GEAR_pistol_muzzle_bg_idc,
	GEAR_pistol_acc_bg_idc,
	GEAR_pistol_optic_bg_idc,
	GEAR_pistol_mag_bg_idc
];

true