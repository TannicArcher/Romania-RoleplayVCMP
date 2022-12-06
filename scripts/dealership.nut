DEALERSHIP_PLR <- -1;
DEALERSHIP_ID <- 130;
DEALERSHIP_CARINST_ID <- -1;

function GetVehName(veh)
{
	if(veh == 130) return "landstalker";
	if(veh == 131) return "idaho";
	if(veh == 132) return "stinger";
	if(veh == 133) return "linerunner";
	if(veh == 134) return "perennial";
	if(veh == 135) return "sentinel";
	if(veh == 136) return "rio";
	if(veh == 137) return "firetruck";
	if(veh == 138) return "trashmaster";
	if(veh == 139) return "stretch";
	if(veh == 140) return "manana";
	if(veh == 141) return "infernus";
	if(veh == 142) return "voodoo";
	if(veh == 143) return "pony";
	if(veh == 144) return "mule";
	if(veh == 145) return "cheetah";
	if(veh == 146) return "ambulance";
	if(veh == 147) return "fbiwashington";
	if(veh == 148) return "moonbeam";
	if(veh == 149) return "esperanto";
	if(veh == 150) return "taxi";
	if(veh == 151) return "washington";
	if(veh == 152) return "bobcat";
	if(veh == 153) return "mrwhoopee";
	if(veh == 154) return "bf injection";
	if(veh == 155) return "hunter";
	if(veh == 156) return "police";
	if(veh == 157) return "enforcer";
	if(veh == 158) return "securicar";
	if(veh == 159) return "banshee";
	if(veh == 160) return "predator";
	if(veh == 161) return "bus";
	if(veh == 162) return "rhino";
	if(veh == 163) return "barracksol";
	if(veh == 164) return "cubanhermes";
	if(veh == 166) return "angel";
	if(veh == 167) return "coach";
	if(veh == 168) return "cabbie";
	if(veh == 169) return "stallion";
	if(veh == 170) return "rumpo";
	if(veh == 171) return "rc bandit";
	if(veh == 172) return "romero";
	if(veh == 173) return "packer";
	if(veh == 174) return "sentinel xs";
	if(veh == 175) return "admiral";
	if(veh == 176) return "squalo";
	if(veh == 177) return "sea sparrow";
	if(veh == 178) return "pizza boy";
	if(veh == 179) return "gang burrito";
	if(veh == 182) return "speeder";
	if(veh == 183) return "reefer";
	if(veh == 184) return "tropic";
	if(veh == 185) return "flatbed";
	if(veh == 186) return "yankee";
	if(veh == 187) return "caddy";
	if(veh == 188) return "zebra";
	if(veh == 189) return "top fun";
	if(veh == 190) return "skimmer";
	if(veh == 191) return "pcj600";
	if(veh == 192) return "faggio";
	if(veh == 193) return "freeway";
	if(veh == 194) return "rc baron";
	if(veh == 195) return "rc raider";
	if(veh == 196) return "glendale";
	if(veh == 197) return "oceanic";
	if(veh == 198) return "sanchez";
	if(veh == 199) return "sparrow";
	if(veh == 200) return "patriot";
	if(veh == 201) return "love fist";
	if(veh == 202) return "coast guard";
	if(veh == 203) return "dinghy";
	if(veh == 204) return "hermes";
	if(veh == 205) return "sabre";
	if(veh == 206) return "sabre turbo";
	if(veh == 207) return "pheonix";
	if(veh == 208) return "walton";
	if(veh == 209) return "regina";
	if(veh == 210) return "comet";
	if(veh == 211) return "deluxo";
	if(veh == 212) return "burrito";
	if(veh == 213) return "spandexpress";
	if(veh == 214) return "marquis";
	if(veh == 215) return "baggage";
	if(veh == 216) return "kaufman cab";
	if(veh == 217) return "maverick";
	if(veh == 218) return "vcn maverick";
	if(veh == 219) return "rancher";
	if(veh == 220) return "fbi rancher";
	if(veh == 221) return "virgo";
	if(veh == 222) return "greenwood";
	if(veh == 223)  return "cuban jetmax";
	if(veh == 224)  return "hotring racer 1";
	if(veh == 225) return "sandking";
	if(veh == 226) return "blista";
	if(veh == 227) return "virgo";
	if(veh == 228) return "boxville";
	if(veh == 229) return "benson";
	if(veh == 230) return "mesagrande";
	if(veh == 231) return "rc goblin";
	if(veh == 232) return "hotring racer 2";
	if(veh == 233) return "hotring racer 3";
	if(veh == 234) return "bloodring banger 1";
	if(veh == 235) return "bloodring banger 2";
	if(veh == 236) return "cheetah 2";
	
	if(veh == 6401) return "dacia logan";
	if(veh == 6402) return "audi a4";
	if(veh == 6403) return "cheetahsa";
	if(veh == 6404) return "bansheesa";
	if(veh == 6405) return "dacia logan police";
	if(veh == 6406) return "sultan";
	if(veh == 6407) return "elegy";
	if(veh == 6408) return "bobcatsa";
	if(veh == 6409) return "mesasa";
	if(veh == 6410) return "stretchsa";
	if(veh == 6411) return "towtruck";
	if(veh == 6412) return "turismo";
	if(veh == 6413) return "infernussa";
	if(veh == 6414) return "bullet";
	if(veh == 6415) return "zr";
	if(veh == 6416) return "jester";
	if(veh == 6417) return "flash";
	if(veh == 6418) return "uranus";
	if(veh == 6419) return "dacia 1310";
	if(veh == 6420) return "bmw i5";
}
function GetVehCash(veh)
{
	if(veh == null) return;
	try{
	veh = veh.tolower();
	}
	catch(e) { }
	if(veh == "landstalker") return 200000;
	if(veh == "stallion") return 400000;
	if(veh == "idaho") return 200000;
	if(veh == "stinger") return 400000;
	if(veh == "linerunner") return 300000;
	if(veh == "perennial") return 200000;
	if(veh == "sentinel") return 250000;
	if(veh == "firetruck") return 500000;
	if(veh == "trashmaster") return 400000;
	if(veh == "stretch") return 1000000;
	if(veh == "manana") return 120000;
	if(veh == "infernus") return 750000;
	if(veh == "voodoo") return 250000;
	if(veh == "pony") return 300000;
	if(veh == "mule") return 250000;
	if(veh == "cheetah") return 700000;
	if(veh == "cheetah 2") return 705000;
	if(veh == "coast guard") return 755000;
	if(veh == "kaufman cab") return 205000;
	if(veh == "vcn maverick") return 500000;
	if(veh == "ambulance") return 500000;
	if((veh == "fbi washington") || (veh == "fbiwashington")) return 550000;
	if(veh == "moonbeam") return 250000;
	if(veh == "esperanto") return 110000;
	if(veh == "taxi") return 350000;
	if(veh == "washington") return 300000;
	if(veh == "bobcat") return 225000;
	if((veh == "mr. whoopee") || (veh == "mrwhoopee")) return 200000;
	if((veh == "bf injection") || (veh == "bfinjection")) return 850000;
	if(veh == "hunter") return 5000000;
	if(veh == "police") return 450000;
	if(veh == "enforcer") return 650000;
	if(veh == "securicar") return 600000;
	if(veh == "banshee") return 650000;
	if(veh == "bus") return 150000;
	if(veh == "rhino") return 2000000;
	if((veh == "barracks ol") || (veh == "barracksol")) return 800000;
	if((veh == "cuban hermes") || (veh == "cubanhermes")) return 900000;
	if((veh == "maverick") || (veh == "helicopter")) return 1000000;
	if(veh == "angel") return 550000;
	if(veh == "coach") return 200000;
	if(veh == "cabbie") return 300000;
	if(veh == "rumpo") return 2000000;
	if((veh == "rc bandit") || (veh == "rcbandit")) return 75000;
	if(veh == "rc goblin") return 100000;
	if((veh == "romero's hearse") || (veh == "romeroshearse") || (veh == "romero")) return 400000;
	if(veh == "packer") return 600000;
	if(veh == "sentinel xs") return 300000;
	if(veh == "admiral") return 120000;
	if((veh == "pizza boy") || (veh == "pizzaboy")) return 75000;
	if((veh == "gang burrito") || (veh == "gangburrito")) return 400000;
	if(veh == "flatbed") return 175000;
	if(veh == "yankee") return 275000;
	if(veh == "caddy") return 90000;
	if((veh == "zebra") || (veh == "zebracab") || (veh == "zebra cab")) return 375000;
	if((veh == "topfun") || (veh == "top fun")) return 75000;
	if(veh == "skimmer") return 2000000;
	if((veh == "pcj-600") || (veh == "pcj") || (veh == "pcj600")) return 750000;
	if(veh == "faggio") return 130000;
	if(veh == "freeway") return 700000;
	if(veh == "rc baron") return 85000;
	if(veh == "rc raider") return 175000;
	if(veh == "glendale") return 275000;
	if(veh == "oceanic") return 300000;
	if(veh == "sanchez") return 700000;
	if(veh == "sparrow") return 900000;
	if(veh == "patriot") return 500000;
	if((veh == "lovefist") || (veh == "love fist")) return 1250000;
	if(veh == "hermes") return 300000;
	if(veh == "sabre") return 200000;
	if((veh == "sabreturbo") || (veh == "sabre turbo")) return 650750;
	if(veh == "pheonix") return 75000;
	if(veh == "walton") return 190000;
	if(veh == "regina") return 300000;
	if(veh == "comet") return 600000;
	if(veh == "deluxo") return 600000;
	if(veh == "burrito") return 300000;
	if(veh == "spandexpress") return 200500;
	if((veh == "baggage") || (veh == "baggage handler") || (veh == "baggagehandler")) return 90000;
	if((veh == "vcn maverixk") || (veh == "vcnmaverick") || (veh == "vcn")) return 90000;
	if(veh == "rancher") return 150000;
	if((veh == "fbi rancher") || (veh == "fbirancher")) return 90000;
	if(veh == "greenwood") return 225000;
	if((veh == "hotring racer 1") || (veh == "hotringracer1") || (veh == "hotring1"))  return 750000;
	if((veh == "hotring racer 2") || (veh == "hotringracer2") || (veh == "hotring2"))  return 750000;
	if((veh == "hotring racer 3") || (veh == "hotringracer3") || (veh == "hotring3"))  return 750000;
	if(veh == "sandking") return 450000;
	if((veh == "blista") || (veh == "blista compact") || (veh == "blistacompact")) return 500000;
	if((veh == "police maverick") || (veh == "policemaverick") || (veh == "police helicopter") || (veh == "policehelicopter")) return 1100000;
	if(veh == "virgo") return 250000;
	if(veh == "boxville") return 250000;
	if(veh == "benson") return 350000;
	if((veh == "mesagrande") || (veh == "mesa grande")) return 190000;
	
	if(veh == "hunter") return 5000000;
	if((veh == "maverick") || (veh == "helicopter")) return 1000000;
	if(veh == "skimmer") return 2000000;
	if((veh == "police maverick") || (veh == "policemaverick") || (veh == "police helicopter") || (veh == "policehelicopter")) return 1100000;
	if(veh == "sparrow") return 900000;	
	if(veh == "sea sparrow") return 3000000;	
	
	if(veh == "dinghy") return 400000;
	if(veh == "marquis") return 600000;
	if(veh == "cuban jetmax") return 900000;
	if(veh == "tropic") return 500000;
	if(veh == "reefer") return 450000;
	if(veh == "speeder") return 600000;
	if(veh == "predator") return 1000000;
	if(veh == "squalo") return 800000;
	if(veh == "rio") return 550000;
	
	if(veh == "bloodring banger 1") return 400000;
	if(veh == "bloodring banger 2") return 400000;
	
	if(veh == "dacia logan") return 200000;
	if(veh == "audi a4") return 400000;
	if(veh == "cheetahsa") 600000;
	if(veh == "bansheesa") 550000;
	if(veh == "dacia logan police") return 250000;
	if(veh == "sultan") return 450000;
	if(veh == "elegy") return 400000;
	if(veh == "bobcatsa") return 350000;
	if(veh == "mesasa") return 250000;
	if(veh == "stretchsa") return 750000;
	if(veh == "towtruck") return 375000;
	if(veh == "turismo") return 800000;
	if(veh == "infernussa") return 1000000;
	if(veh == "bullet") return 900000;
	if(veh == "zr") return 850000;
	if(veh == "jester") return 650000;
	if(veh == "flash") return 750000;
	if(veh == "uranus") return 150000;
	if(veh == "dacia 1310") return 120000;
	if(veh == "bmw i5") return 750000;
	
	return 150000;
}

function GetSafeCarId(increment)
{
	DEALERSHIP_ID += increment;
	if(DEALERSHIP_ID == 129)
	{
		DEALERSHIP_ID = 6420;
		return;
	}
	if(DEALERSHIP_ID == 6421)
	{
		DEALERSHIP_ID = 130;
		return;
	}
	if(DEALERSHIP_ID == 237)
	{
		DEALERSHIP_ID = 6401;
		return;
	}
	if(DEALERSHIP_ID == 6400)
	{
		DEALERSHIP_ID = 236;
		return;
	}
	if(DEALERSHIP_ID == 165) DEALERSHIP_ID += increment;
	if(DEALERSHIP_ID == 181) DEALERSHIP_ID += increment;
	if(DEALERSHIP_ID == 180) DEALERSHIP_ID += increment;
}
function SetDealerShip(player)
{
	if(DEALERSHIP_PLR != -1) return 1; //E deja un player in dealership
	//daca nu setam variabilele necesare
	DEALERSHIP_PLR = player.ID;
	DEALERSHIP_ID = 130;
	DEALERSHIP_CARINST_ID = CreateVehicle(DEALERSHIP_ID,0,Vector(-1016.72, -864.985, 17.963),0,1,1).ID;
	player.SetCameraPos(Vector(-1019.02, -856.307, 18.3374),Vector(-1016.72, -864.985, 17.963));
	player.Pos = Vector(-985.047, -833.965, 7.36474);
	player.Frozen = true;
}
function DealerShipUpdate(dt)
{
	GetSafeCarId(dt);
	if(FindVehicle(DEALERSHIP_CARINST_ID) != null)
	{
		FindVehicle(DEALERSHIP_CARINST_ID).Delete();
		local veh = CreateVehicle(DEALERSHIP_ID,0,Vector(-1016.72, -864.985, 17.963),0,1,1);
		if(veh != null)DEALERSHIP_CARINST_ID = veh.ID;
		else print("NULLVEHICLE "+DEALERSHIP_ID);
	}
	else
	{
		local veh = CreateVehicle(DEALERSHIP_ID,0,Vector(-1016.72, -864.985, 17.963),0,1,1);
		if(veh != null) DEALERSHIP_CARINST_ID = veh.ID;
	}
}
function DealerShipOut()
{
	if(FindVehicle(DEALERSHIP_CARINST_ID) != null)
	{
		FindVehicle(DEALERSHIP_CARINST_ID).Delete();
		DEALERSHIP_CARINST_ID = -1;
	}
	local player = FindPlayer(DEALERSHIP_PLR);
	player.Frozen = false;
	player.RestoreCamera();
	DEALERSHIP_ID = 130;
	DEALERSHIP_PLR = -1;
	DEALERSHIP_CARINST_ID = -1;
}
function DealerShipAccept()
{
	local c = GetVehCash(GetVehName(DEALERSHIP_ID));
	if(!PLAYERS[DEALERSHIP_PLR].Buy(c))
	{
		MSGPLR(C_RED+"Ai nevoie de "+c+"!",C_RED+"You need "+c+" $",FindPlayer(DEALERSHIP_PLR));
		return;
	}
	local player = FindPlayer(DEALERSHIP_PLR); // # 1
	player.Frozen = false;
	player.RestoreCamera(); // #2

	local i = DEALERSHIP_CARINST_ID-1;
	CARS[i] = Car(DEALERSHIP_CARINST_ID);
	local vehicle = FindVehicle(DEALERSHIP_CARINST_ID);
	CARS[i].Model = vehicle.Model;
	CARS[i].SpawnPosX = vehicle.Pos.x;
	CARS[i].SpawnPosY = vehicle.Pos.y;
	CARS[i].SpawnPosZ = vehicle.Pos.z;
	CARS[i].SpawnQuaternionX = vehicle.Rotation.x;
	CARS[i].SpawnQuaternionY = vehicle.Rotation.y;
	CARS[i].SpawnQuaternionZ = vehicle.Rotation.z;
	CARS[i].SpawnQuaternionW = vehicle.Rotation.w;
	CARS[i].Color1 = vehicle.Colour1;
	CARS[i].Color2 = vehicle.Colour2;
	CARS[i].Fuel = 100;
	CARS[i].NOS = 100;
	CARS[i].Owner = player.Name;
	CARS[i].dbID = DEALERSHIP_CARINST_ID;
	CARS[i].CreateNew();
	player.Vehicle = vehicle;
	vehicle.Pos = Vector(-1009.18, -880.162, 12.8868);
	print(i+" "+DEALERSHIP_PLR);
	
	DEALERSHIP_ID = 130;
	DEALERSHIP_PLR = -1;
	DEALERSHIP_CARINST_ID = -1;
}