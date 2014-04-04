private ['_class', '_price'];
_class = _this;
_price = _class call GEAR_fnc_itemPrice;

_price > 0 || (call GEAR_fnc_priceLookup) find _class > -1