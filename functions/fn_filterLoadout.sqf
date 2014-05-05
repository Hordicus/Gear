#include "macro.sqf"
private ['_loadout', '_item'];
_loadout = +_this;
for "_i" from 0 to (count _loadout) do {
	_item = GET(_loadout, _i, "");
	if ( typeName _item == "ARRAY" ) then {
		{
			if !(_x call GEAR_fnc_isForSale) then {
				_item set [_forEachIndex, "REMOVE"];
			};
		} forEach _item;
		_item = _item - ["REMOVE"];
		_loadout set [_i, _item];
	} else { if ( _item != "" ) then {
		if !(_item call GEAR_fnc_isForSale ) then {
			_loadout set [_i, ""];

			if ( _i in [GEAR_index_uniform, GEAR_index_vest, GEAR_index_backpack] ) then {
				_loadout set [_i + 1, []];
			};
			
			if ( _i in [GEAR_index_primary, GEAR_index_secondary, GEAR_index_pistol] ) then {
				_loadout set [_i + 1, ""];
				_loadout set [_i + 2, ""];
				_loadout set [_i + 3, ""];
				_loadout set [_i + 4, ""];
			};
		};
	}};
};

_loadout