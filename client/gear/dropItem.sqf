#include "dialogs\gear_defines.sqf"
disableSerialization;

_target       = ctrlIDC (_this select 0);
_dropped      = _this select 4 select 0;
_class        = _dropped select 2;
_type         = _class call GEAR_getType;
_allowedSlots = _class call GEAR_allowedSlots;
_valid        = false;

_idcs = [
	 GEAR_select_helmet_idc, GEAR_select_glasses_idc, GEAR_select_nvg_idc, GEAR_select_binocular_idc,
	GEAR_item_map_idc, GEAR_item_gps_idc, GEAR_item_radio_idc, GEAR_item_compass_idc, GEAR_item_watch_idc
];

_types = [
	GEAR_type_helmet, GEAR_type_glasses, GEAR_type_nvg, GEAR_type_binocular,
	GEAR_type_map, GEAR_type_gps, GEAR_type_radio, GEAR_type_compass, GEAR_type_watch
];

_type_indexes = [
	GEAR_index_helmet, GEAR_index_glasses, GEAR_index_nvg, GEAR_index_binocular,
	GEAR_index_map, GEAR_index_gps, GEAR_index_radio, GEAR_index_compass, GEAR_index_watch
];

_index = _idcs find _target;
if ( _index >= 0 ) then {
	_target_type = _types select _index;
	_type_index = _type_indexes select _index;
	
	if ( _type == _target_type ) then {
		GEAR_activeLoadout set [_type_index, _class];
	};
}
else {
	switch(_target) do {
		case (GEAR_select_uniform_idc): {
			if ( _type == GEAR_type_uniform) then {
				GEAR_activeLoadout set [GEAR_index_uniform, _class];
			}
			else {
			
			};
		};
		
		case (GEAR_select_vest_idc): {
			if ( _type == GEAR_type_vest) then {
				GEAR_activeLoadout set [GEAR_index_vest, _class];
			}
			else {
			
			};
		};
		
		case (GEAR_select_backpack_idc): {
			if ( _type == GEAR_type_backpack) then {
				GEAR_activeLoadout set [GEAR_index_backpack, _class];
			}
			else {
				// if ( GEAR_type_backpack in _allowedSlots ) then {
					_contents = GEAR_activeLoadout select GEAR_index_backpack_contents;
					if ( isNil "_contents" ) then {
						_contents = [];
					};
					
					_contents set [count _contents, _class];
					GEAR_activeLoadout set [GEAR_index_backpack_contents, _contents];
				// };
			};
		};
	
		case (GEAR_primary_idc): {
			if ( _type != GEAR_type_primary) exitwith{};

			GEAR_activeLoadout set [GEAR_index_primary, _class];
			GEAR_activeLoadout set [GEAR_index_primary_muzzle, nil];
			GEAR_activeLoadout set [GEAR_index_primary_acc, nil];
			GEAR_activeLoadout set [GEAR_index_primary_optic, nil];
			GEAR_activeLoadout set [GEAR_index_primary_mag, nil];
		};
		
		case (GEAR_secondary_idc): {
			if ( _type != GEAR_type_secondary) exitwith{};

			GEAR_activeLoadout set [GEAR_index_secondary, _class];
			GEAR_activeLoadout set [GEAR_index_secondary_muzzle, nil];
			GEAR_activeLoadout set [GEAR_index_secondary_acc, nil];
			GEAR_activeLoadout set [GEAR_index_secondary_optic, nil];
			GEAR_activeLoadout set [GEAR_index_secondary_mag, nil];
		};
		
		case (GEAR_pistol_idc): {
			if ( _type != GEAR_type_pistol) exitwith{};

			GEAR_activeLoadout set [GEAR_index_pistol, _class];
			GEAR_activeLoadout set [GEAR_index_pistol_muzzle, nil];
			GEAR_activeLoadout set [GEAR_index_pistol_acc, nil];
			GEAR_activeLoadout set [GEAR_index_pistol_optic, nil];
			GEAR_activeLoadout set [GEAR_index_pistol_mag, nil];
		};
	
		case (GEAR_primary_muzzle_idc);
		case (GEAR_secondary_muzzle_idc);
		case (GEAR_pistol_muzzle_idc): {
			if ( _type != GEAR_type_muzzle) exitwith{};

			_gun_offset = -1;
			_gun = GEAR_activeLoadout select ((_target + _gun_offset) call GEAR_IDCToLoadoutIndex);
			_compatible_muzzles = getArray (configFile >> "CfgWeapons" >> _gun >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems");
			
			if ( _class in _compatible_muzzles ) then {
				GEAR_activeLoadout set [ _target call GEAR_IDCToLoadoutIndex, _class ];
			};
		};
		
		case (GEAR_primary_acc_idc);
		case (GEAR_secondary_acc_idc);
		case (GEAR_pistol_acc_idc): {
			if ( _type != GEAR_type_acc) exitwith{};
		
			_gun_offset = -2;
			_gun = GEAR_activeLoadout select ((_target + _gun_offset) call GEAR_IDCToLoadoutIndex);
			_compatible_accs = getArray (configFile >> "CfgWeapons" >> _gun >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems");
			
			if ( _class in _compatible_accs ) then {
				GEAR_activeLoadout set [ _target call GEAR_IDCToLoadoutIndex, _class ];
			};
		};
		
		case (GEAR_primary_optic_idc);
		case (GEAR_secondary_optic_idc);
		case (GEAR_pistol_optic_idc): {
			if ( _type != GEAR_type_optic) exitwith{};
			
			_gun_offset = -3;
			_gun = GEAR_activeLoadout select ((_target + _gun_offset) call GEAR_IDCToLoadoutIndex);
			_compatible_optics = getArray (configFile >> "CfgWeapons" >> _gun >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems");
			
			if ( _class in _compatible_optics ) then {
				GEAR_activeLoadout set [ _target call GEAR_IDCToLoadoutIndex, _class ];
			};
		};
		
		case (GEAR_primary_mag_idc);
		case (GEAR_secondary_mag_idc);
		case (GEAR_pistol_mag_idc): {
			_gun_offset = -4;
			_gun = GEAR_activeLoadout select ((_target + _gun_offset) call GEAR_IDCToLoadoutIndex);
			_compatible_mags = getArray (configFile >> "CfgWeapons" >> _gun >> "magazines");
			
			if ( _class in _compatible_mags ) then {
				GEAR_activeLoadout set [ _target call GEAR_IDCToLoadoutIndex, _class ];
			};
		};
	};
};

// call GEAR_updateDialogImgs;
call GEAR_updateDialogImgs;