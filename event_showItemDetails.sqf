#include "functions\macro.sqf"
private ["_index", "_class", "_config", "_compatible_ammo", "_items", "_compatible_attachments"];
lbClear ((findDisplay GEAR_dialog_idc) displayCtrl GEAR_items_attachments_ammo_idc);

_index  = lbCurSel ((findDisplay GEAR_dialog_idc) displayCtrl GEAR_itemslist_idc);
_config = call GEAR_fnc_config;
_class  = lbData [GEAR_itemslist_idc, _index];

_items = [];

if ( GEAR_activeSubNav == 'ammo' ) then {
	_compatible_ammo = getArray (configFile >> "CfgWeapons" >> _class >> "magazines");
	
	// Check muzzles for ammo types
	{
		if ( _x != 'this' ) then {
			_compatible_ammo = _compatible_ammo + getArray (configFile >> "CfgWeapons" >> _class >> _x >> "magazines");
		};
	} count (getArray (configFile >> "CfgWeapons" >> _class >> "muzzles"));
	
	
	{
		if ( _x call GEAR_fnc_isForSale ) then {
			_items set [count _items, _x];
		};
		true
	} count _compatible_ammo;

}
else {
	if ( GEAR_activeSubNav == 'attachments' ) then {
		_compatible_attachments = [_class] call GEAR_fnc_getAttachments;
		{
			if ( _x call GEAR_fnc_isForSale ) then {
				_items set [count _items, _x];
			};
			true
		} count _compatible_attachments;
	};
};

{
	_name = _x call GEAR_fnc_ItemName;
	if ( _name != "" ) then {
		_img = _x call GEAR_fnc_ItemImg;
		_price = _x call GEAR_fnc_itemPrice;

		_string = format['%1 [$%2]', _name, _price];
		lbAdd [GEAR_items_attachments_ammo_idc, _string];
		lbSetData [GEAR_items_attachments_ammo_idc, _forEachIndex, _x];
		lbSetPicture[GEAR_items_attachments_ammo_idc, _forEachIndex, _img];
	};
} forEach _items;
