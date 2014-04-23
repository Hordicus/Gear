#include "functions\macro.sqf"

private ["_type", "_config", "_items", "_name", "_price", "_string", "_img", "_i"];
_type = _this;
lbClear ((findDisplay GEAR_dialog_idc) displayCtrl GEAR_itemslist_idc);

if ( _type == 'presets' ) then {
	[GEAR_presets, {
		if ( typeName _value == "ARRAY" ) then { // hashRem sets value to "UNDEF"
			_price = _value call GEAR_fnc_loadoutTotal;
			
			_string = format['%1 [$%2]', _key, _price];
			_index = lbAdd [GEAR_itemslist_idc, _string];
			lbSetData [GEAR_itemslist_idc, _index, _key];
		};
	}] call CBA_fnc_hashEachPair;
}
else {
	_config = call GEAR_fnc_config;
	_curCat = "Show All";
	
	if ( _type == 'sub' ) then {
		_type = GEAR_activeNav;
	};
	
	_categories = [_config, _type] call CBA_fnc_hashGet;
	
	if ( _this == 'sub' ) then {
		_curCat = lbText [GEAR_subTypes_idc, lbCurSel ((findDisplay GEAR_dialog_idc) displayCtrl GEAR_subTypes_idc)];
		
		{
			_cat = _x select 0;
			
			if ( _curCat == "Show All" || _curCat == _cat ) then {
				{
					_name = (_x select 0) call GEAR_fnc_itemName;
					_img = (_x select 0) call GEAR_fnc_itemImg;
					_price = _x select 1;
					
					_string = format['%1 [$%2]', _name, _price];
					_index = lbAdd [GEAR_itemslist_idc, _string];
					lbSetData [GEAR_itemslist_idc, _index, _x select 0];
					lbSetPicture[GEAR_itemslist_idc, _index, _img];
				} forEach (_x select 1);
			};
		} forEach _categories;
	}
	else {
		lbClear ((findDisplay GEAR_dialog_idc) displayCtrl GEAR_subTypes_idc);
		((findDisplay GEAR_dialog_idc) displayCtrl GEAR_subTypes_idc) lbAdd "Show All";
		
		{
			((findDisplay GEAR_dialog_idc) displayCtrl GEAR_subTypes_idc) lbAdd (_x select 0);
			true;

		} count _categories;
		
		GEAR_activeNav = _type;
		lbSetCurSel [GEAR_subTypes_idc, 0];
	};
};

lbSetCurSel [GEAR_itemslist_idc, 0];