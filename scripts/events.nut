
function onScriptLoad()
{ 
    print("----------" + GetServerName() + "----------")
    print("Server Password: " + ((GetPassword() != "") && GetPassword() || "N/A"));
    print("Total Players: "   + GetPlayers())
    print("caca maca face caca xD")
    print("-------------------------------------------------")
}

function onScriptUnload()
{
    DisconnectSQL(iptocountry);
	DisconnectSQL( DB );
}

// =========================================== P L A Y E R   E V E N T S ==============================================

function onPlayerJoin( player )
{
    //SetCinematicBorder(player, true);
	PLAYERS[player.ID] = Player(player.ID);
	PLAYERS[player.ID].Load();
    local country = IpToCountry(player.IP);
    MSG(C_GREEN+player.Name+" a intrat in server din "+country,C_GREEN+ "" + player.Name + " has joined the server from " + country + " ( " + country + " ) ");
    MSGPLR(C_WHITE + "Bine ai venit in [#002B7F]VCMP [#FCD116]Romania [#CE1126]Roleplay (" + timez("gmt") + " )", "[#FFFFFF]Welcome to [#002B7F]VCMP [#FCD116]Romania [#CE1126]Roleplay [#FFFFFF] (" + timez("gmt") + " )", player)
    MSGPLR(C_WHITE + "Foloseste [#FF0000]/help [#FFFFFF]pentru mai multe","" + C_WHITE + "Use [#FF0000]/help [#FFFFFF]if you want more", player)
	if(PLAYERS[player.ID].Autologin() == true)
	{
		MSGPLR(C_GREEN+"Ai fost autologat",C_GREEN+"Autologged",player);
		player.Spawn();
	}
}

function onPlayerPart( player, reason )
{
	PLAYERS[player.ID].Quit();
	PLAYERS[player.ID] = null;
}

function onPlayerRequestClass( player, classID, team, skin )
{
	return 1;
}

function onPlayerRequestSpawn( player )
{
    if(PLAYERS[player.ID].Logged == false)
    {
        if(PLAYERS[player.ID].GetPassword() == null) MSGPLR(C_RED+"Trebuie sa te inregistrezi ca sa continui.",C_RED+"You must register to continue.",player);
        else MSGPLR(C_RED+"logheaza-te pe contul tau cu /login <parola> pentru a continua.",C_GREEN+"Please login to your account with /login <password> in order to continue..",player);
        return 0;
    }
    return 1;
}

function onPlayerSpawn( player )
{
    //SetCinematicBorder(player, false);
	PLAYERS[player.ID].Spawn(); 
    player.Colour = RGB( rand()%255,rand()%255,rand()%255 )
}

function onPlayerDeath( player, reason )
{
}

function onPlayerKill( player, killer, reason, bodypart )
{
	PLAYERS[killer.ID].Deaths++;
	PLAYERS[player.ID].Kills++;
}

function onPlayerTeamKill( player, killer, reason, bodypart )
{
	onPlayerKill( player, killer, reason, bodypart )
}

function onPlayerChat(player, text)
{     
    Message(C_WHITE + "[" + player.ID + "] " + PlrColToStrHex(player) + "" + player.Name + "[#ffffff]: " + text + "")
    print("[" + player.ID + "] " + player.Name + " " + text);
}

function onPlayerPM( player, playerTo, message )
{
	return 1;
}

function onPlayerBeginTyping( player )
{
}

function onPlayerEndTyping( player )
{
}

function onNameChangeable( player )
{
}

function onPlayerSpectate( player, target )
{
}

function onPlayerCrashDump( player, crash )
{
}

function onPlayerMove( player, lastX, lastY, lastZ, newX, newY, newZ )
{
}

function onPlayerHealthChange( player, lastHP, newHP )
{
}

function onPlayerArmourChange( player, lastArmour, newArmour )
{
}

function onPlayerWeaponChange( player, oldWep, newWep )
{
}

function onPlayerAwayChange( player, status )
{
}

function onPlayerNameChange( player, oldName, newName )
{
}

function onPlayerActionChange( player, oldAction, newAction )
{
}

function onPlayerStateChange( player, oldState, newState )
{
}

function onPlayerOnFireChange( player, IsOnFireNow )
{
}

function onPlayerCrouchChange( player, IsCrouchingNow )
{
}

function onPlayerGameKeysChange( player, oldKeys, newKeys )
{
}

function onPlayerUpdate( player, update )
{
}

// ========================================== V E H I C L E   E V E N T S =============================================

function onPlayerEnteringVehicle( player, vehicle, door )
{
	return 1;
}

function onPlayerEnterVehicle( player, vehicle, door )
{
	MessagePlayer(C_WHITE+CARS[vehicle.ID-1].ShowStats(),player);
}

function onPlayerExitVehicle( player, vehicle )
{
}

function onVehicleExplode( vehicle )
{
}

function onVehicleRespawn( vehicle )
{
	local c = CARS[vehicle.ID-1];
	vehicle.Rotation = Quaternion(c.SpawnQuaternionX,c.SpawnQuaternionY,c.SpawnQuaternionZ,c.SpawnQuaternionW);
}

function onVehicleHealthChange( vehicle, oldHP, newHP )
{
}

function onVehicleMove( vehicle, lastX, lastY, lastZ, newX, newY, newZ )
{
}

function onVehicleRepair (p)
{
    local player = FindPlayer(p);
    if (player) {
        local veh = player.Vehicle;
        if (veh) {
            player.IsFrozen = false;
            player.Vehicle.Fix();
            player.Vehicle.Colour1 = rand() % 255, rand() % 255, rand() % 255,
                Announce("New engine and paint job. keep your car safe", player, 7)
            player.PlaySound(50008)
        }
    }
}

function load1(p) {
    local player = FindPlayer(p)
    if (player) {
        Announce("~b~- ~h~- ~h~-", player, 7)
        player.PlaySound(370)
    }
}

function load2(p) {
    local player = FindPlayer(p)
    if (player) {
        Announce("~h~- ~b~- ~h~-", player, 7)
        player.PlaySound(370)
    }
}

function load3(p) {
    local player = FindPlayer(p)
    if (player) {
        Announce("~h~- ~h~- ~b~-", player, 7)
        player.PlaySound(370)
    }
}

function onHealNigga(p)
{
    local player = FindPlayer(p)
    if (player)
    {
        player.Health = 100;
        player.IsDrunk = false;
    }
}

function onBankRob (p) {
    local player = FindPlayer(p)
    if (player) {
		local money = 10000 + rand()%10000;
		CreateExplosion(1,7,-940.005, -343.934, 7.22693,-1,true)
		PLAYERS[player.ID].AddCash(money);
		PlaySound( player.UniqueWorld , 50002 , player.Pos );
		MSG( C_RED + player.Name + " a jefuit banca!", C_RED + player.Name + " robbed the bank!");
    }
}

// =========================================== P I C K U P   E V E N T S ==============================================

function onPickupClaimPicked( player, pickup )
{
	return 1;
}

function onPickupPickedUp( player, pickup )
{
    switch (pickup.Model) {
        case 367:
        if (player.Health  == 100 || player.Health == 250) MSGPLR(C_RED + "Vino mai incolo ca ai deja " + player.Health, C_RED + "Come back later, you already have like " + player.Health, player);
        else {
        onHealNigga(player.ID)
        }
        break;
        case 595:
        player.Health -= 10     
        player.IsDrunk = true
        MSGPLR(C_RED + "Esti beat, fratioare! ;3 XOXO", C_RED + "You're drunk, my friend ;3 XOXO", player)
        break;
        case 408:
        RobPointPickup(pickup,player);
        break;
        case 564:
        if (player.Weapon == 16) {
        NewTimer("onBankRob",5000,1,player.ID)
        ANNPLR("Ai 5 secunde sa fugi","You have 5 seconds to run",player)
        player.RemoveWeapon(16)
        }
        else {
        MSGPLR(C_RED+"Trebuie sa ai o bomba",C_RED+"You must have a bomb",player)
        }
        break;
    }
}

function onPickupRespawn( pickup )
{
}

// ========================================== O B J E C T   E V E N T S ==============================================

function onObjectShot( object, player, weapon )
{
}

function onObjectBump( object, player )
{
}

// ====================================== C H E C K P O I N T   E V E N T S ==========================================

function onCheckpointEntered(player, cp) {
    switch (cp.ID) {
        case 0:
        player.Pos = Vector(-936.309, -353.718, 7.22692) // rezolvat
        player.PlaySound(465)
        break;
        case 1:
        player.Pos = Vector(-934.265, -351.009, 17.8038) // rezolvat
        player.PlaySound(465)
        break;
        case 2:
        player.Pos = Vector(-902.013, 1055.28 11.0946) // rezolvat
        player.PlaySound(465)
        break;
        case 3:        
        player.Pos = Vector(-887.03, 1054.3, 14.2122) // rezolvat
        player.PlaySound(465)
        break;
        case 4:        
        player.Pos = Vector(-880.807, 1160.26, 17.8194) // rezolvat
        player.PlaySound(465)
        break;
        case 5:        
        player.Pos = Vector(-872.666, 1159.57, 11.0993) // rezolvat
        player.PlaySound(465)
        break;
        case 6:
        player.Pos = Vector(-1414.53, 1158.69, 266.762) // rezolvat
        player.PlaySound(465)
        break;
        case 7:
        player.Pos = Vector(-1106.06, 1330.81, 20.07) // rezolvat
        player.PlaySound(465)
        break;
        case 8:
        case 9:
        case 10:
        local veh = player.Vehicle;
        if (veh)
        {
        	player.IsFrozen = true
        	player.PlaySound(50001)
        	NewTimer("load1",1000,1,player.ID)
        	NewTimer("load2",2000,1,player.ID)
        	NewTimer("load3",3000,1,player.ID)
        	NewTimer("onVehicleRepair",4000,1,player.ID)
        }
        else {
        MSGPLR(C_RED + "Tu nu esti intro masina", C_RED + "You ain't in a vehicle" )
        }
        break;
 	}
 }

function onCheckpointExited( player, checkpoint )
{
}

// =========================================== B I N D   E V E N T S =================================================

function onKeyDown( player, key )
{
}

function onKeyUp( player, key )
{
}

// ================================== E N D   OF   O F F I C I A L   E V E N T S ======================================