
function GetJobNameEN(job)
{
	switch(job)
	{
		case 0: return "Unemployed";
		case 1: return "Cop";
		case 2: return "Medic";
		case 3: return "Fireman";
		case 4: return "Junkman";
		case 5: return "Bank guard";
		case 6: return "Trucker";
		case 7: return "Hunter";
		case 8: return "Terrorist";
	}
}

function Player::GiveJob(job)
{
	if(this.Job == job) this.SetJob(job,false);
	else this.SetJob(job,true);
}

function Player::SetJob(job,j)
{
	local player = this.GetInst();
	if(j)
	{
		MSG(C_WHITE+player.Name+" is now an "+GetJobNameEN(job),C_WHITE+player.Name+" este acum un "+GetJobNameRO(job));
	}
	player.Disarm();
	switch(job)
	{
		case 1:
		{
			if(this.WantedLevel != 0)
			{
				MSGPLR(C_RED+"You are wanted by the police.",C_RED+"Esti cautat de politie.",player);
				return;
			}
			player.GiveWeapon(17,187);
			player.GiveWeapon(4,1);
			player.GiveWeapon(19,88);
			player.GiveWeapon(25,330);
			this.GiveJobSkin(1);
			player.Colour = RGB(0,0,255);
			break;
		}
		case 2:
		{
			player.GiveWeapon(101,0);
			this.GiveJobSkin(5);
			this.JobQuantity = 5;
			player.Colour = RGB(0,255,255);
			break;
		}
		case 3:
		{
			this.GiveJobSkin(6);
			player.Colour = RGB(255,0,0);
			break;
		}
		case 4:
		{
			this.GiveJobSkin(29);
			player.Colour = RGB(128,128,128);
			break;
		}
		case 5:
		{
			this.GiveJobSkin(91);
			player.Colour = RGB(149,0,255);
			player.GiveWeapon(102,330);
			player.GiveWeapon(19,88);
			player.GiveWeapon(30,2);
			break;
		}
		case 6:
		{
			this.GiveJobSkin(153);
			player.Colour = RGB(255, 255, 0);
			break;
		}
		case 7:
		{
			player.Colour = RGB(0,128,0);
			player.GiveWeapon(28,55);
			player.GiveWeapon(20,88);
			player.GiveWeapon(17,187);
			player.GiveWeapon(102,330);
			break;
		}
		case 8:
		{
			if(this.WantedLevel < 6) player.WantedLevel = 6;
			player.GiveWeapon(18,66);
			player.GiveWeapon(102,660);
			player.GiveWeapon(31,550);
			player.Colour = RGB(0,255,0);
			break;
		}
		default: 
		{
			print("unknown job. parameters: "+player.Name+" "+j+" "+job);
			break;
		}
	}
	this.Job = job;
}
function ShowJobHelp(player,job)
{
	switch(job)
	{
		case 1:
		{
			MSGPLR(C_WHITE+"Your job is killing or arresting wanted players. \n "+
			"To arrest a wanted player, press [E] when near him, or use /arrest. \n"+
			"You can engage in police chases if the wanted player is speeding.",
			C_WHITE+"Slujba ta e sa ucizi sau sa arestezi jucatori cautati. \n"+
			"Pentru a aresta un jucator cautat, foloseste tasta [E] sau foloseste /arrest"+
			"Poti intra in urmariri de politie daca jucatorul cautat merge cu viteza.", player);
			break;
		}
		case 2:
		{
			MSGPLR(C_WHITE+"Your job is healing players. \n "+
			"To heal a player, press [E] when near him, or use /heal <player>.",
			C_WHITE+"Slujba ta e sa dai 'heal' la jucatori. \n"+
			"Pentru a vindeca un jucator, apasa tasta [E] cand esti aproape de el, sau foloseste /heal <jucator>", player);
			break;
		}
		case 3:
		{
			MSGPLR(C_WHITE+"Your job is stopping fires around the city. \n "+
			"To stop a fire, enter a firetruck, approach the fire and press [E].",
			C_WHITE+"Slujba ta e sa stingi focurile din oras. \n"+
			"Pentru a opri un foc, intra intr-un camion de pompieri, apropiete de foc, si apasa [E]", player);
			break;
		}
		case 4:
		{
			MSGPLR(C_WHITE+"Your job is collecting trash with your Trashmaster. \n"+
			"To collect trash, collect the garbage and enter your Trashmaster.",
			C_WHITE+"Slujba ta e sa colectezi gunoiul din oras. \n"+
			"Ca sa colectezi gunoiul, colecteaza pickupurile si intra in masina de gunoi.",player);
			break;
		}
		case 5:
		{
			MSGPLR(C_WHITE+"Your job is transporting cash from the bank to an other location or vice versa.\n"+
			"You will also get rewarded for killing players  that are wanted by the cops.",
			C_WHITE+"Slubja ta e sa trasporti bani de la banca la alte locuri sau vice versa. \n"+
			"O sa primesti bani daca omori jucatorii care au wanted level.",player);
			break;
		}
		case 6:
		{
			
		}
		default: break;
	}
}
function Player::GiveJobSkin(g_skin)
{
	local inst = this.GetInst();
	if(this.Skin == 0) inst.Skin = g_skin;
}

function GiveJobReward(player,victim,extra)
{
	switch(PLAYERS[player.ID].Job)
	{
		case 1:
		{
			if(PLAYERS[victim.ID].WantedLevel > 0)
			{
				PLAYERS[player.ID].AddCash(PLAYERS[victim.ID].WantedLevel * 500);
				PLAYERS[victim.ID].WantedLevel = 0;
				MSG(C_GREEN+player.Name+" killed wanted player "+victim.Name,C_GREEN+player.Name+"a omorat jucatorul cautat "+victim.Name);
			}
			else
			{
				player.Disarm();
				PLAYERS[player.ID].Job = 0;
				PLAYERS[player.ID].WantedLevel = 6;
				MSG(C_RED+player.Name+" was kicked from the police force for killing an innocent player",C_RED+player.Name+" a fost dat afara din politie fiindca a omorat un jucator inocent");
			}
		}
		case 2:
		{
			PLAYERS[player.ID].AddCash((100 - victim.Health) * 100);
		}
		case 5:
		{
			if(PLAYERS[victim.ID].WantedLevel > 0)
			{
				PLAYERS[player.ID].AddCash(PLAYERS[victim.ID].WantedLevel * 250);
				PLAYERS[victim.ID].WantedLevel = 0;
				MSG(C_GREEN+player.Name+" killed wanted player "+victim.Name,C_GREEN+player.Name+"a omorat jucatorul cautat "+victim.Name);
			}
		}
		case 8:
		{
			PLAYERS[player.ID].AddCash(1000);
			PLAYERS[player.ID].WantedLevel += 1;
			break;
		}
		default: break;
	}
}
function JobInteract(player)
{
	switch(PLAYERS[player.ID].Job)
	{
		case 1:
		{
			local d = 1000000;
			for(local i =0 ; i < 100;i++)
			{
				local plr = FindPlayer(i);
				if(plr != null)
				{
					if(DistanceFromPoint(player.Pos.x,player.Pos.y,plr.Pos.x,plr.Pos.y) < 5)
					{
						Arrest(plr,player);
						break;
					}
				}
			}
		}
	}
}
function Arrest(robber,cop)
{
	player.Pos = (0,0,0);
	
}