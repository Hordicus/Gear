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
		};
	}};
};

_loadout