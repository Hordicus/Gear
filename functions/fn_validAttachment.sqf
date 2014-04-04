private ['_gun', '_attachment', '_compatible'];
_gun = _this select 0;
_attachment = _this select 1;
_compatible = [_this select 0, _this select 2] call GEAR_fnc_getAttachments;

_attachment in _compatible || { toLower(_attachment) in _compatible }