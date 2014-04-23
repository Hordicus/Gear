private ['_class', '_types', '_prices', '_classes', '_lookup', '_index', '_price'];
_types = ['guns', 'ammo', 'launchers', 'items', 'wearables', 'attachments'];
_class = _this;

if ( isNil "GEAR_fnc_priceLookup" ) then {
	_config = call GEAR_fnc_config;
	_classes  = [];
	_prices = [];
	
	{
		_categories = [_config, _x] call CBA_fnc_hashGet;
		
		if ( typeName (_categories select 0 select 1) == "ARRAY" ) then {
			{
				{
					_classes set [count _classes, _x select 0];
					_prices set [count _prices, _x select 1];
					true
				} count (_x select 1);
				true
			} count _categories;
		}
		else {
			{
				_classes set [count _classes, _x select 0];
				_prices set [count _prices, _x select 1];
				true
			} count _categories;
		};
		true
	} count _types;
	
	GEAR_fnc_priceLookup = compileFinal str [_classes, _prices];
};

_lookup = call GEAR_fnc_priceLookup;
_index = (_lookup select 0) find _class;
_price = 0;

if ( _index > -1 ) then {
	_price = (_lookup select 1) select _index;
};

_price