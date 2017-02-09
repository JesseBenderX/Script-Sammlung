playSound "windKurz";
[] spawn 
{
	_sound0 = ASLToAGL [0,0,0] nearestObject "#soundonvehicle";
	sleep 200;
	deleteVehicle _sound0;
};

if (isServer) then
    {
    for "_i" from 1 to 10 do
	   {
	   	setWind [_i, _i, true];
		sleep 1;
	   };
    };

    _hndl1 = ppEffectCreate ["colorCorrections", 1501];
    _hndl1 ppEffectEnable true;
    _hndl1 ppEffectAdjust [0.4, 1, 0, [0.82, 0.69, 0.43, 0.20], [0.8, 0.74, 0.63, 0.40], [0.8, 0.74, 0.63, 0.30]];
    _particles = [player, -1, 0.8, true] call BIS_fnc_sandstorm;
    _hndl1 ppEffectCommit 15;

    45 setFog [1, 0.01, 100];

sleep 152;

if (isServer) then
    {
    setWind [9, 9, true];
    sleep 5;
    setWind [7, 7, true];
    sleep 5;
    setWind [5, 5, true];
    sleep 5;
    setWind [3, 3, true];
    };

    _hndl1 ppEffectAdjust [1, 1, 0,[ 0, 0, 0, 0],[ 1, 1, 1, 1],[ 0, 0, 0, 0]];
    _hndl1 ppEffectCommit 26;
	{deleteVehicle _x;} forEach _particles;

10 setFog 0;

sleep 5;

if (isServer) then
    {
    setWind [2, 2, true]
    };