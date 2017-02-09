_this spawn {

	params[
	
		["_Name","Caeli et Terrae"],
		["_Ort", "Takistan"],
		["_Ziel", "Camp Pico"],
		["_Zeit", 10]
	];

	titleText ["","BLACK IN"];
	titleFadeOut 8;
	sleep 6;

	[ 
		[_Name,"font = 'PuristaSemiBold'"],
		["","<br/>"],
		[_Ziel,"font = 'PuristaMedium'"],
		["","<br/>"],
		[_Ort,"font = 'PuristaLight'"]
	] execVM "\a3\missions_f_bootcamp\Campaign\Functions\GUI\fn_SITREP.sqf";
};