private ['_class', '_price'];
_class = _this;
_price = _class call GEAR_fnc_itemPrice;

_price > 0 || (call GEAR_fnc_priceLookup select 0) find _class > -1 || {({_class == _x} count (call GEAR_fnc_priceLookup select 0)) == 1}