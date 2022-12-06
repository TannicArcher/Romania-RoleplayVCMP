ZOMBIE_WORLD <- 3;
ZOMBIE_FROZEN <- false;
ZOMBIE_WAVE <- 0;
ZOMBIE_INSTAKILL <- 0;
ZOMBIES_REMAINING <- 0;
ZOMBIE_LEVEL_DIST <- 1000;
ZOMBIE_LEVEL_SPAWN <- Vector(0,0,0);
ZOMBIE_TIMER <- 0;
ZOMBIE_DEFAULTHP <- 100;
ZOMBIE_INV <- 0;
ZOMBIE_POWER <- false;
AIRDROP_PLANE <- CreateObject(638,3,Vector(0,0,0),255).ID;
AIRDROP_PICKUPS <- array(3,-1);
AIRDROP_LOC <- Vector(0,0,0);
AIRDROP_LOCA <- Vector(0,0,0);
AIRDROP_LOCB <- Vector(0,0,0);
ZOMBIE_SPAWN1 <- Vector(0,0,0);
ZOMBIE_SPAWN2 <- Vector(0,0,0);
ZOMBIE_SPAWN3 <- Vector(0,0,0);
ZOMBIE_SHOP <- Vector(-373.654, -596.776, 25.8263);
ZOMBIE_DIFFICULTY <- 1;
function ZS_PlayerSpawn(player)
{
	player.Pos = ZOMBIE_LEVEL_SPAWN;
	player.World = ZOMBIE_WORLD;
	player.GiveWeapon(17,999);
}
function onZombieDeath(player,zombie)
{
	player.Score += 1;
	player.Cash += NPC_ViataO[FindNPC(zombie.ID)] ;
	KillStreak(player);
	ZOMBIES_REMAINING -= 1;
	if(ZOMBIES_REMAINING > 0)
	{
		onZombieSpawn(zombie);
	}
	else zombie.World = 100;
}
function ZS_Update()
{
	local remaining = 0;
	local remainingplr = 0;
	for(local i = 0 ; i < 100;i++)
	{
		if(FindPlayer(i) != null)
		{
			if(FindPlayer(i).World == ZOMBIE_WORLD)
			{
				remainingplr += 1;
			}
		}
	}
	if(remainingplr == 0)
	{
		if(ZOMBIE_TIMER != 0)
		{
			ZS_Lost();
		}
		else return;
	}
	if(remainingplr == 1)
	{
		ZOMBIE_TIMER += 1;
	}
	for(local i =0; i < MAX_NPCS ; i++)
	{
		local npc = FindObject(NPC_OBJID[i]);
		if(npc != null)
		{
			if(npc.World == ZOMBIE_WORLD)
			{
				remaining += 1;
			}
		}
	}
	AnnounceZombie("~o~Zombies Remaining: "+ZOMBIES_REMAINING,1);
	if(remaining <= 0)
	{
		local a = 0;
		for(local i =0; i < MAX_NPCS ; i++)
		{
			local npc = FindObject(NPC_OBJID[i]);
			if(npc != null)
			{
				if(npc.World == 100)
				{
					npc.World = ZOMBIE_WORLD;
					onZombieSpawn(npc)
					NPC_ViataO[i] = ZOMBIE_DEFAULTHP;
					NPC_Viata[i] = ZOMBIE_DEFAULTHP;
					a += 1;
					if(a == ZOMBIES_REMAINING ) break;
				}
			}
		}
	}
	if(ZOMBIES_REMAINING <= 0)
	{
		ZOMBIE_WAVE += 1;
		ZS_Bomb(null);
		StartWave(ZOMBIE_WAVE);
	}
	for(local i =0; i < 100 ; i++)
	{
		local player = FindPlayer(i);
		if(player != null)
		{
			if(player.World == ZOMBIE_WORLD)
			{
				if(DistanceFromPoint(player.Pos.x,player.Pos.y,ZOMBIE_LEVEL_SPAWN.x,ZOMBIE_LEVEL_SPAWN.y) > ZOMBIE_LEVEL_DIST)
				{
					Announce("~o~GET BACK INTO THE PLAYABLE ZONE!",player,0);
					player.Health -= 1;
				}
			}
		}
	}
	if(ZOMBIE_WAVE == -1)
	{
		ZS_Start();
		for(local i =0; i < 100; i++)
		{
			local player = FindPlayer(i);
			if(player != null)
			{
				if(player.World == ZOMBIE_WORLD)
				{
					player.Disarm();
					ZS_PlayerSpawn(player);
				}
			}
		}
	}
	if(ZOMBIE_INSTAKILL > 0) ZOMBIE_INSTAKILL -= 1;
	if(ZOMBIE_INV > 0) ZOMBIE_INV -= 1;
}
ZOMBIE_FTIMER <- NewTimer("ZS_Update",1000,0);
function ZS_Start()
{
	if(ZOMBIE_TIMER != 0) return;
	local level = rand() % 5;
	local name = "";
	if(level == 0) level = 1;
	if(level == 6) level = 5;
	switch(level)
	{
		case 1:
		{
			ZOMBIE_LEVEL_SPAWN = Vector(-377.158, -562.345, 19.5742)
			ZOMBIE_LEVEL_DIST = 60;
			ZOMBIE_SPAWN1 = Vector(-377.145, -521.195, 12.7661);
			ZOMBIE_SPAWN2 = Vector(-378.98, -598.941, 25.8263);
			ZOMBIE_SPAWN3 = ZOMBIE_SPAWN1;
			ZOMBIE_SHOP = Vector(-373.654, -596.776, 25.8263);
			name = "Mansion";
			AIRDROP_LOC = Vector(-377.829, -534.652, 17.2822)
			AIRDROP_LOCA = Vector(-470.866, -517.281, 50);
			AIRDROP_LOCB = Vector(171.855, -623.754, 50);
			break;
		}
		case 2: 
		{
			ZOMBIE_LEVEL_SPAWN = Vector(-884.422, -469.341, 13.1103)
			ZOMBIE_LEVEL_DIST = 40;
			ZOMBIE_SPAWN1 = Vector(-867.836, -497.57, 11.1035);
			ZOMBIE_SPAWN2 = Vector(-872.542, -474.514, 11.1034);
			ZOMBIE_SPAWN3 = Vector(-869.434, -448.51, 11.1142);
			ZOMBIE_SHOP = Vector(-885.873, -457.344, 13.1108);
			name = "Hospital";
			AIRDROP_LOC = Vector(-860.215, -470.849, 10.9264)
			AIRDROP_LOCA = Vector(-470.866, -517.281, 50);
			AIRDROP_LOCB = Vector(-825.093, -799.256, 10.9643);
			break;
		}
		case 3:
		{
			ZOMBIE_LEVEL_SPAWN = Vector(-914.834, -341.909, 13.3802)
			ZOMBIE_LEVEL_DIST = 40;
			ZOMBIE_SPAWN1 = Vector(-875.042, -340.931, 11.1034);
			ZOMBIE_SPAWN2 = ZOMBIE_SPAWN1;
			ZOMBIE_SPAWN3 = ZOMBIE_SPAWN1
			ZOMBIE_SHOP = Vector(-870.264, -560.053, 11.1478);
			name = "Bank";
			AIRDROP_LOC = Vector(-873.6, -339.502, 11.1028);
			AIRDROP_LOCA = Vector(-470.866, -450, 50);
			AIRDROP_LOCB = Vector(-825.093, -799.256, 10.9643);
			break;
		}
		case 4:
		{
			ZOMBIE_LEVEL_SPAWN = Vector(-878.992, -575.9, 11.258)
			ZOMBIE_LEVEL_DIST = 35;
			ZOMBIE_SPAWN1 = Vector(-854.259, -569.534, 11.1041);
			ZOMBIE_SPAWN2 = Vector(-862.59, -556.987, 11.1012);
			ZOMBIE_SPAWN3 = Vector(-854.259, -569.534, 11.1041);
			ZOMBIE_SHOP = Vector(-858.079, -579.98, 11.1017);
			name = "Ice factory";
			AIRDROP_LOC = Vector(-854.227, -572.053, 11.1042);
			AIRDROP_LOCA = Vector(-470.866, -450, 50);
			AIRDROP_LOCB = Vector(-825.093, -799.256, 10.9643);
			break;
		}
		case 5:
		{
			ZOMBIE_LEVEL_SPAWN = Vector(-377.158, -562.345, 19.5742)
			ZOMBIE_LEVEL_DIST = 30;
			break;
		}
		default: break;
	}
	local diff = rand() % 4;
	if(diff == 0) diff = 1;
	ZOMBIE_DIFFICULTY = diff;
	if(ZOMBIE_TIMER == 0) Message(RED+"Loaded map :"+name+" Difficulty: "+GetMultiplierZombieDifficulty(ZOMBIE_DIFFICULTY));
	StartWave(ZOMBIE_WAVE);
	ResetZCash();
	ZS_Bomb(null);
}
function StartWave(wave)
{
	local bosswave = false;
	if(wave == 0) wave = 1;
	switch(wave)
	{
		case 1:
		{
			ZOMBIES_REMAINING = 1 * ZOMBIE_DIFFICULTY;
			ZOMBIE_DEFAULTHP = 50;
			break;
		}
		case 2:
		{
			ZOMBIES_REMAINING = 2* ZOMBIE_DIFFICULTY;
			ZOMBIE_DEFAULTHP = 50;
			break;
		}
		case 3:
		{
			ZOMBIES_REMAINING = 5* ZOMBIE_DIFFICULTY;
			ZOMBIE_DEFAULTHP = 50;
			break;
		}
		case 4:
		{
			ZOMBIES_REMAINING = 5* ZOMBIE_DIFFICULTY;
			ZOMBIE_DEFAULTHP = 100;
			break;
		}
		case 5:
		{
			ZOMBIES_REMAINING = 1* ZOMBIE_DIFFICULTY;
			ZOMBIE_DEFAULTHP = 500 * ZOMBIE_DIFFICULTY;
			bosswave = true;
			break;
		}
		case 6:
		{
			ZOMBIES_REMAINING = 10* ZOMBIE_DIFFICULTY;
			ZOMBIE_DEFAULTHP = 100;
			break;
		}
		case 7:
		{
			ZOMBIES_REMAINING = 25* ZOMBIE_DIFFICULTY;
			ZOMBIE_DEFAULTHP = 100;
			break;
		}
		case 8:
		{
			ZOMBIES_REMAINING = 25* ZOMBIE_DIFFICULTY;
			ZOMBIE_DEFAULTHP = 100;
			break;
		}
		case 9:
		{
			ZOMBIES_REMAINING = 50* ZOMBIE_DIFFICULTY;
			ZOMBIE_DEFAULTHP = 100;
			break;
		}
		case 10:
		{
			ZOMBIES_REMAINING = 1* ZOMBIE_DIFFICULTY;
			ZOMBIE_DEFAULTHP = 1000 * ZOMBIE_DIFFICULTY;
			bosswave = true;
			break;
		}
		case 11:
		{
			ZOMBIES_REMAINING = 75* ZOMBIE_DIFFICULTY;
			ZOMBIE_DEFAULTHP = 100;
			break;
		}
		case 12:
		{
			ZOMBIES_REMAINING = 100* ZOMBIE_DIFFICULTY;
			ZOMBIE_DEFAULTHP = 100;
			break;
		}
		case 13:
		{
			ZOMBIES_REMAINING = 100* ZOMBIE_DIFFICULTY;
			ZOMBIE_DEFAULTHP = 100;
			break;
		}
		case 14:
		{
			ZOMBIES_REMAINING = 100* ZOMBIE_DIFFICULTY;
			ZOMBIE_DEFAULTHP = 125;
			break;
		}
		case 15:
		{
			ZOMBIES_REMAINING = 3* ZOMBIE_DIFFICULTY;
			ZOMBIE_DEFAULTHP = 1000;
			bosswave = true;
			break;
		}
		case 16:
		{
			ZOMBIES_REMAINING = 100* ZOMBIE_DIFFICULTY;
			ZOMBIE_DEFAULTHP = 150;
			break;
		}
		case 17:
		{
			ZOMBIES_REMAINING = 125* ZOMBIE_DIFFICULTY;
			ZOMBIE_DEFAULTHP = 150;
			break;
		}
		case 18:
		{
			ZOMBIES_REMAINING = 150* ZOMBIE_DIFFICULTY;
			ZOMBIE_DEFAULTHP = 150;
			break;
		}
		case 19:
		{
			ZOMBIES_REMAINING = 200* ZOMBIE_DIFFICULTY;
			ZOMBIE_DEFAULTHP = 1000;
			break;
		}
		case 20:
		{
			ZOMBIES_REMAINING = 1;
			ZOMBIE_DEFAULTHP = 10000* ZOMBIE_DIFFICULTY;
			bosswave = true;
			break;
		}
		case 21:
		{
			ZS_Win();
			return;
		}
		default:
		{
			break;
		}
	}
	if(bosswave == false)AnnounceZombie("~o~ Wave "+wave,3);
	else AnnounceZombie("~o~ BOSS WAVE "+wave,3);
}
function ZS_Lost()
{
	AnnounceAll("~o~Zombies Won! ~n~ ~h~ Time: "+ZOMBIE_TIMER / 60+":"+ZOMBIE_TIMER % 60+" ~n~ Rounds survived: ~o~"+ZOMBIE_WAVE,3);
	ZOMBIE_TIMER = 0;
	ZOMBIE_WAVE = 0;
	Message(RED+"Loading new map!");
	ZS_Bomb(null);
	ZOMBIES_REMAINING = 0;
}
function ZS_Win()
{
	AnnounceAll("~h~Victory! ~n~ Humans won! ~n~ ~h~ Time: "+ZOMBIE_TIMER / 60+":"+ZOMBIE_TIMER % 60,3);
	ZOMBIE_TIMER = 0;
	ZOMBIE_WAVE = -1;
	Message(RED+"Loading new map!");
	ZS_Bomb(null);
	ZOMBIES_REMAINING = 0;
}
function KillStreak(player)
{
	local name = "";
	switch(player.Score)
	{
		case 25:
		{
			ZOMBIE_POWER = true;
			AnnounceZombie("~h~Power turned on!",3);
			name = "Power";
			player.Score += 1;
			break;
		}
		case 50:
		{
			name = "Instant Health";
			if(player.Health >= 101) player.Health = 255;
			else player.Health = 100;
			player.Score += 1;
			break;
		}
		case 75:
		{
			name = "Juggernaut";
			player.Health = 255;
			player.Score += 1;
			break;
		}
		case 100:
		{
			name = "Minigun";
			player.GiveWeapon(33,1000);
			player.Score += 1;
			break;
		}
		case 125:
		{
			name = "Insta-Kill";
			ZOMBIE_INSTAKILL = 60;
			player.Score += 1;
			break;
		}
		case 150:
		{
			name = "Weapon Pack";
			player.GiveWeapon(18,99);
			player.GiveWeapon(21,99);
			player.GiveWeapon(25,99);
			player.GiveWeapon(26,99);
			player.GiveWeapon(28,99);
			player.GiveWeapon(32,99);
			player.Score += 1;
			break;
		}
		case 175:
		{
			name = "Airdrop";
			AirDrop(1);
			player.Score += 1;
			break;
		}
		case 200:
		{
			name = "Invincibility";
			ZOMBIE_INV = 60;
			player.Score += 1;
			break;
		}
		case 225:
		{
			name = "Special Weapon";
			player.GiveWeapon(102+rand() % 7,999);
			player.Score += 1;
			break;
		}
		case 250:
		{
			name = "Emengercy Airdrop";
			AirDrop(rand() % 10);
			player.Score += 1;
			break;
		}
		case 275:
		{
			name = "Bomb";
			ZS_Bomb(player);
			player.Score += 1;
			break;
		}
		case 300:
		{
			name = "Nuke";
			ZOMBIES_REMAINING = 0;
			ZS_Bomb(player);
			player.Cash += 1000;
			player.Score = 0;
			break;
		}
		default: break;
	}
	if(name != "")Message(GREEN+player+" used "+name+" !");
}
function AirDrop(param)
{
	FindObject(AIRDROP_PLANE).Pos = AIRDROP_LOCA;
	FindObject(AIRDROP_PLANE).MoveTo(AIRDROP_LOCB,10000);
	CreatePickup(383,3,param,AIRDROP_LOC,255,true);
}
function ZS_Bomb(player)
{
	CreateExplosion(0,ZOMBIE_WORLD,AIRDROP_LOC,-1,false);
	for(local i =0; i < MAX_NPCS;i++)
	{
		local npc = FindObject(NPC_OBJID[i]);
		if(npc != null)
		{
			if(npc.World == 3)
			{
				if(player != null) onNPCDeath(npc,player);
				else
				{
					npc.World = 100;
				}
			}
		}
	}
}
function AnnounceZombie(text,style)
{
	for(local i =0; i < 100 ; i++)
	{
		local player = FindPlayer(i);
		if(player != null)
		{
			if(player.World == ZOMBIE_WORLD) Announce(text,player,style);
		}
	}
}
function onZombieSpawn(zombie)
{
	local spawnid = rand() % 3;
	if(spawnid == 0) zombie.Pos = ZOMBIE_SPAWN1;
	if(spawnid == 1) zombie.Pos = ZOMBIE_SPAWN2;
	if(spawnid == 2) zombie.Pos = ZOMBIE_SPAWN3;
	NPC_ViataO[FindNPC(zombie.ID)] = ZOMBIE_DEFAULTHP;
}
function ZS_RandomReward(arg,player)
{
	if(arg == 0) return;
	else
	{
		local oldsore = player.Score;
		local rng = rand() % 13;
		if(rng == 0) rng =1;
		player.Score = rng * 25;
		KillStreak(player);
		player.Score = oldsore;
		arg -= 1;
		ZS_RandomReward(arg,player);
	}
}
function ResetZCash()
{
	for(local i =0; i < 100 ; i++)
	{
		local player = FindPlayer(i);
		if(player != null)
		{
			if(player.World == ZOMBIE_WORLD) 
			{
				player.Cash = 500;
			}
		}
	}
}
function GetMultiplierZombieDifficulty(diff)
{
	if(diff == 1 ) return "Normal";
	if(diff == 2 ) return "Hard";
	if(diff == 3 ) return "Hardcore";
	else return 1;
}