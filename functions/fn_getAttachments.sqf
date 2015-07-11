private ["_gun","_cfg","_limit","_getProperties","_entry","_i","_compatible","_items","_entryName","_slots","_linkProxy"];
_gun = _this select 0;
_cfg = _gun call GEAR_fnc_getConfig;
_limit = switch (_this select 1) do {
	case 'muzzle': {["MuzzleSlot"]};
	case 'acc': {["PointerSlot"]};
	case 'optic': {["CowsSlot"]};
	case 'bipod': {["UnderBarrelSlot"]};
};

if ( isNil "_limit" ) then {
	_limit = ["MuzzleSlot", "PointerSlot", "CowsSlot", "UnderBarrelSlot"];
};

_getProperties = {
	private ['_properties', '_class', '_entry'];
	_properties = [];
	_class = _this;
	for "_i" from 0 to count _class - 1 do {
		_entry = _class select _i;
		_properties set [_i, configName _entry];
	};
	
	_properties
};

_compatible = [];
{
	_items = getArray (configFile >> "CfgWeapons" >> _gun >> "WeaponSlotsInfo" >> _x >> "compatibleItems");
	if ( count _items == 0 && isClass (configFile >> "CfgWeapons" >> _gun >> "WeaponSlotsInfo" >> _x >> "compatibleItems") ) then {
		_items = (configFile >> "CfgWeapons" >> _gun >> "WeaponSlotsInfo" >> _x >> "compatibleItems") call _getProperties;
	};
	
	_compatible = _compatible + _items;
} count _limit;

_slots = configFile >> "CfgWeapons" >> _gun >> "WeaponSlotsInfo";
for "_i" from 0 to count _slots - 1 do {
	_entry = _slots select _i;
	_entryName = configName _entry;
	
	if !( _entryName in ["MuzzleSlot", "PointerSlot", "CowsSlot", "UnderBarrelSlot"] ) then {
		_linkProxy = getText (_entry >> "linkProxy");
		
		if (
			( _linkProxy == "\A3\data_f\proxies\weapon_slots\TOP" && "CowsSlot" in _limit )
			||
			( _linkProxy == "\A3\data_f\proxies\weapon_slots\SIDE" && "PointerSlot" in _limit )
			||
			( _linkProxy == "\A3\data_f\proxies\weapon_slots\UNDERBARREL" && "UnderBarrelSlot" in _limit )
		) then {
			_compatible = _compatible + (((inheritsFrom _entry) >> "compatibleItems") call _getProperties);
		};
	};
};
	
_compatible