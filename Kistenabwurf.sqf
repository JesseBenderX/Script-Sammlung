/* 
- s_1 Spielerbezeichnung wer ausführt

- Ini des Spielers

this addaction ["Versorgung anfordern", {[[[],"scripts\versorgung.sqf"], "BIS_fnc_execVM", true] call BIS_fnc_MP;}];

*/ 

// Abwurfezone festlegen + Heli spawn

openMap [true, true];
JeBe = 0;
hintc "Setzen sie eine Abwurfzone";

s_1 onMapSingleClick {

	_SHeli = [(getMarkerPos "heli_spawn"), 300, "I_Heli_Transport_02_F", WEST] call BIS_fnc_spawnVehicle;
	createVehicleCrew (_SHeli select 0);
	heliF = _SHeli select 0;
	_heliC = _SHeli select 1;
	_heliG = _SHeli select 2;
	_heliWP1 = _heliG addWaypoint [(_pos), 5, 1];
	_heliWP1 setWaypointType "MOVE";
	_heliWP2 = _heliG addWaypoint [(getMarkerPos "heli_spawn"), 0, 2];
	_heliWP2 setWaypointType "MOVE";
	heliF flyInHeight 75;
	heliF allowDammage false;
	heliF allowFleeing 0;
	_heliG setSpeedMode "FULL";
	_heliG setBehaviour "CARELESS";
	_heliMarker = createMarker ["mark1", _pos];
	"mark1" setMarkerText "Abwurfzone";
	"mark1" setMarkerType "hd_pickup";
	"mark1" setMarkerColor "ColorGreen";
	pad = "Land_HelipadEmpty_F" createVehicle getMarkerPos "mark1";
	JeBe = 1;
	openMap [false, false];
	onMapSingleClick "";
};

// Anflug auf das Helipad mit Abwurf

waitUntil {(JeBe == 1)};
hint "Versorgungslieferung ist auf dem Weg";

waitUntil {(pad distance heliF) < 300}; 
heliF animateDoor ["CargoRamp_Open",1];

waitUntil {( pad distance heliF) < 180};
_Box = createVehicle ["B_SupplyCrate_F", (getPos heliF), [], 0, "CAN_COLLIDE"];
_Box allowDammage false;

clearBackpackCargoGlobal _Box;
clearWeaponCargoGlobal _Box;
clearMagazineCargoGlobal _Box;
clearItemCargoGlobal _Box;
_Box disableCollisionWith HeliF;
HeliF disableCollisionWith _Box;

_Box attachTo [HeliF, [0, 0, 0]];
_Box setDir ([_Box, HeliF] call BIS_fnc_dirTo);
detach _Box;
[_Box,nil,true] spawn BIS_fnc_MP;

// Fallschirm anbringen, Kiste füllen und Rauch

_Schirm = createVehicle ["B_parachute_02_F", (getPos _Box), [], 0, "CAN_COLLIDE"];	
_Box attachTo [_Schirm,[0,0,-0.5]];	
_Schirm hideObject true;
_Schirm setPos getPos _Box;

sleep 2;
hint "Versogungslieferung abgeworfen";
heliF animateDoor ["CargoRamp_Open",0];
_Schirm hideObject false;

_Smoke = "SmokeShellBlue" createVehicle (position _Box);
_Smoke attachTo [_Box, [0,0,0]];

_Box addMagazineCargoGlobal ["16Rnd_9x21_Mag", 10];
_Box addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag", 20];
_Box addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag_Tracer", 10];
_Box addMagazineCargoGlobal ["100Rnd_65x39_caseless_mag",5];
_Box addMagazineCargoGlobal ["100Rnd_65x39_caseless_mag_Tracer", 3];
_Box addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",10];
_Box addMagazineCargoGlobal ["1Rnd_Smoke_Grenade_shell", 5];
_Box addMagazineCargoGlobal ["1Rnd_SmokeRed_Grenade_shell", 5];
_Box addMagazineCargoGlobal ["1Rnd_SmokeGreen_Grenade_shell", 5];
_Box addItemCargoGlobal ["ACE_fieldDressing", 15];
_Box addItemCargoGlobal ["ACE_elasticBandage", 15];
_Box addItemCargoGlobal ["ACE_packingBandage", 10];
_Box addItemCargoGlobal ["ACE_quikclot", 10];
_Box addItemCargoGlobal ["ACE_morphine", 10];
_Box addItemCargoGlobal ["ACE_epinephrine", 10];
_Box addItemCargoGlobal ["ACE_tourniquet", 10];
_Box addItemCargoGlobal ["ACE_salineIV_500", 5];

// Entfernen der gesetzen Objekte + Abschluss

heliF allowDammage true;
deleteMarker "mark1";
deleteVehicle pad;
s_1 removeAction 0;
JeBe = 2;

waitUntil {(getPos _Box select 2) < 1}; 
detach _Box;

sleep 80;

{deleteVehicle _x;} forEach crew HeliF; 
deleteVehicle HeliF;
