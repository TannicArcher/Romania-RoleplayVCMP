function onPlayerCommand(player, cmd, text) {
    if(!player.Spawned)
	{
		switch(cmd.tolower())
		{
			case "register":
			{
				if (PLAYERS[player.ID].Register(text))
				{
					MSG(C_GREEN + player + " si-a facut un cont!", C_GREEN + player + " just registered!");
					PLAYERS[player.ID].Message(C_GREEN + "Bun venit la server!", C_GREEN + "Welcome to the server!");
				}
				else PLAYERS[player.ID].Message(C_RED + "Acest cont deja exista!", C_RED + "This account already exists");
				break;
			}
			case "login":
			{
				if (PLAYERS[player.ID].Logged == true)
				{
					MSGPLR(C_RED + "Esti deja logat", C_RED + "You are already logged in", player);
					break;
				}
				if (PLAYERS[player.ID].GetPassword() == null)
				{
					MSG(C_RED + "Acest cont nu este inregistrat.", C_RED + "This account is not registered.");
					break;
				}
				if (PLAYERS[player.ID].Login(text))
				{
					MSG(C_GREEN + player + " sa logat!", C_GREEN + player + " just logged in!");
					MSGPLR(C_WHITE + "Bine ai venit, " + player.Name + " ( " + timez("gmt") + " )", C_WHITE + "Welcome, " + player.Name + " ( " + timez("gmt") + " )", player)
				}
				else
				{
					if (PLAYERS[player.ID].LoginAttempts > 5)
					{
						MSG(C_RED + "Oops, " + player.Name + " si-a uitat parola!", C_RED + "Oops, " + player.Name + " forgot his password!");
						player.Kick();
						break;
					}
					PLAYERS[player.ID].LoginAttempts++;
					MSGPLR(C_RED + "Parola gresita! [" + PLAYERS[player.ID].LoginAttempts + "/6]", C_RED + "Wrong password! [" + PLAYERS[player.ID].LoginAttempts + "/6]", player);
				}
				break;
			}
		}
	}
	else
	{
		switch (cmd.tolower())
		{
			//START OF ADMINCMDS
			case "bring":
			{
				if(PLAYERS[player.ID].AdminLvl > 1)
				{
					if (!text) MessagePlayer(C_RED + "Syntax: /bring <player>", player)
					if (!player.IsSpawned) MSGPLR(C_WHITE + "Trebuie sa te spawnezi", C_WHITE + "You need to spawn")
					else if(PLAYERS[player.ID].AdminLvl > 1)
					{
						local plr = FindPlayer(text)
						if (!plr.IsSpawned) MSGPLR(C_WHITE + "Jucatorul nu e spawnat", C_WHITE + "Player is not spammed")
						if (!plr) MSGPLR(C_WHITE + "Jucatorul nu e online/inexistent",C_WHITE + "Player is not online/inexistent",player)
						plr.Pos = player.Pos
					}
				}
				break;
			}
			case "goto":
			{
				if (!text) MessagePlayer(C_RED + "Syntax: /goto <player>", player)
				if (!player.IsSpawned) MSGPLR(C_WHITE + "Trebuie sa te spawnezi", C_WHITE + "You need to spawn")
				else if(PLAYERS[player.ID].AdminLvl > 1)
				{
					local plr = FindPlayer(text)
					if (!plr.IsSpawned) MSGPLR(C_WHITE + "Jucatorul nu e spawnat", C_WHITE + "Player is not spammed")
					if (!plr) MSGPLR(C_WHITE + "Jucatorul nu e online/inexistent",C_WHITE + "Player is not online/inexistent",player)
					player.Pos = plr.Pos
				}
				break;
			}
			case "kick":
			{
				if(PLAYERS[player.ID].AdminLvl > 2)
				{
					if (!text) MessagePlayer(C_RED + "Syntax: /kick <player> <reason>", player)
					if (!player.IsSpawned) MSGPLR(C_WHITE + "Trebuie sa fi spawnat",C_WHITE + "You need to be spawned",player)
					else
					{
						local plr = FindPlayer(GetTok(text, " ", 1))
						local motiv = GetTok(text, " ", 2 NumTok(text, " "));
						if (!plr) MSGPLR(C_WHITE + "Jucatorul nu e online/inexistent",C_WHITE + "Player is not online/inexistent",player)
						if (!motiv) MSGPLR(C_WHITE + "Trebuie sa pui un motiv. Ex /ban <player> <motiv>",C_WHITE + "You need to put a reason. Ex /ban <player> <reason>",player)
						else
						{
							Message(C_RED + "Player " + plr.Name + " has been kicked from the server. Reason: " + motiv)
							plr.Kick();
						}
					}
				}
				break;
			}
			case "ban":
			{
				if (!text) MessagePlayer(C_RED + "Syntax: /ban <player> <reason>", player)
				if (!player.IsSpawned) MSGPLR(C_WHITE + "Trebuie sa fi spawnat",C_WHITE + "You need to be spawned",player)
				else if(PLAYERS[player.ID].AdminLvl > 1)
				{
					local plr = FindPlayer(GetTok(text, " ", 1))
					local motiv = GetTok(text, " ", 2 NumTok(text, " "));
					if (!plr) MSGPLR(C_WHITE + "Jucatorul nu e online/inexistent",C_WHITE + "Player is not online/inexistent",player)
					if (!motiv) MSGPLR(C_WHITE + "Trebuie sa pui un motiv. Ex /ban <player> <motiv>",C_WHITE + "You need to put a reason. Ex /ban <player> <reason>",player)
					else
					{
						Message(C_RED + "Player " + plr.Name + " has been banned from the server. Reason: " + motiv)
						BanPlayer(plr);
					}
				}
				break;
			}
			case "addcash":
			{
				if (!text) MessagePlayer(C_RED + "Syntax: /addcash <player> <ammount>", player)
				if (!player.IsSpawned) MSGPLR(C_WHITE + "Trebuie sa fi spawnat",C_WHITE + "You need to be spawned",player)
				else if(PLAYERS[player.ID].AdminLvl > 1)
				{
					local params = split(text, " "), plr = FindPlayer(params[0]), ammount = params[1];
					PLAYERS[plr.ID].AddCash(ammount);
				}
				break;
			}
			case "clear":
			case "clearchat":
			case "clr":
			{
				if(PLAYERS[player.ID].AdminLvl > 2)
				{
					MSGPLR("Trebuie sa fi admin","You need to be admin",player);
					break;
				}
				if (!player.IsSpawned) MSGPLR(C_WHITE + "Trebuie sa fi spawnat",C_WHITE + "You need to be spawned",player)
				else
				{
					Message("\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n");
					Message(C_WHITE + "Chat has been cleared")
				}
				break;
			}
			case "ann":
			{
				if(PLAYERS[player.ID].AdminLvl > 1)
				{
					MSGPLR("Trebuie sa fi admin","You need to be admin",player);
					break;
				}
				if (!text) MessagePlayer(C_RED + "Syntax: /ann <text>", player)
				if (!player.IsSpawned) MSGPLR(C_WHITE + "Trebuie sa fi spawnat",C_WHITE + "You need to be spawned",player)
				else
				{
					Message(C_RED + "/////////////////////ANNOUNCE///////////////////////")
					Message(C_WHITE + text)
					Message(C_WHITE + "Sincerity, " + player.Name)
					Message(C_RED + "////////////////////////////////////////////////////")
				}
				break;
			}
			case "bigann":
			{
				if(PLAYERS[player.ID].AdminLvl > 1)
				{
					MSGPLR("Trebuie sa fi admin","You need to be admin",player);
					break;
				}
				if (!text) MessagePlayer(C_RED + "Syntax: /bigann <text>", player)
				if (!player.IsSpawned) MSGPLR(C_WHITE + "Trebuie sa fi spawnat",C_WHITE + "You need to be spawned",player)
				else if(PLAYERS[player.ID].AdminLvl > 1) AnnounceAll(text,3);
				break;
			}
			case "drown":
			{
				if(PLAYERS[player.ID].AdminLvl > 2)
				{
					MSGPLR("Trebuie sa fi admin","You need to be admin",player);
					break;
				}
				if (!text) MessagePlayer(C_RED + "Syntax: /drown <player>", player)
				if (!player.IsSpawned) MSGPLR(C_WHITE + "Trebuie sa fi spawnat",C_WHITE + "You need to be spawned",player)
				else
				{
					local plr = FindPlayer(text)
					if (!plr) MSGPLR(C_WHITE + "Jucatorul nu e online/inexistent",C_WHITE + "Player is not online/inexistent",player)
					MSGPLR(C_RED + "Playerul " + plr.Name + " a fost inecat de catre " + player.Name + "", C_RED + "Player " + plr.Name + " has been drowned by " + player.Name + "",player)
					plr.Pos = Vector(-2350, -1950, 5.25654)
				}
				break;
			}
			case "warn":
			{
				if(PLAYERS[player.ID].AdminLvl > 1)
				{
					MSGPLR("Trebuie sa fi admin","You need to be admin",player);
					break;
				}
				if (!text) MessagePlayer(C_RED + "Syntax: /warn <player>", player)
				if (!player.IsSpawned) MSGPLR("Trebuie sa fi spawnat","You need to be spawned",player)
				else
				{
					local plr = FindPlayer(text)
					if (!plr) MSGPLR(C_WHITE + "Jucatorul nu e online/inexistent",C_WHITE + "Player is not online/inexistent",player)
					MSGPLR(C_RED + "Playerul " + plr.Name + " a fost avertizat de catre " + player.Name + "", C_RED + "Player " + plr.Name + " has been warned by " + player.Name + "",player)
					plr.Pos.z += 10
				}
				break;
			}
			case "inv":
			case "invincible":
			case "immunity":
			{
				if(PLAYERS[player.ID].AdminLvl < 2)
				{
					MSGPLR("Trebuie sa fi admin","You need to be admin",player);
					break;
				}
				else
				{
					switch (text)
					{
						case "on":
							if (!player.Immunity)
							{
								player.Immunity = -1;
								MSGPLR(C_WHITE + "Imunitate on.", C_WHITE + "Immunity on.",player);
							}
							else MSGPLR(C_WHITE + "Imunitatea e deja activata.", C_WHITE + "Immunity is already on",player);
						case "off":
							if (!player.Immunity)
							{
								player.Immunity = 0;
								MSGPLR(C_WHITE + "Imunitate off.", C_WHITE + "Immunity off.",player);
							}
							else MSGPLR(C_WHITE + "Imunitatea e deja dezactivata.", C_WHITE + "Immunity is already off",player);
						default:
							MessagePlayer(C_RED + "Syntax: /inv <on/off>", player);
					}
				}
				break;
			}
			case "send-client-side-message":
			{
				if(PLAYERS[player.ID].AdminLvl > 3)
				{
					MSGPLR("Trebuie sa fi admin","You need to be admin",player);
					break;
				}
				if (!text) MessagePlayer(C_RED + "Syntax: /send-client-side-message <player> <text>", player);
				if (!player.IsSpawned) MSGPLR(C_WHITE + "Trebuie sa fi spawnat","You need to be spawned",player);
				else
				{
					SendDataToClient(FindPlayer(GetTok(text," ",1)),GetTok(text," ",2).tointeger());
					print("client-side-message >> " + text);
				}
				break;
			}
			case "admincmds":
			{
				MessagePlayer(C_WHITE + "[LVL 1]: /ann, /bigann, /goto, /bring, /warn, /addcash", player);
				MessagePlayer(C_WHITE + "[LVL 2]: /kick, /ban, /drown, /clearchat, /inv	", player);
				MessagePlayer(C_WHITE + "[LVL 3]: /send-clien-side-message", player);
				break;
			}
			//END   OF ADMINCMDS
			case "cmds":
			case "cmd":
			case "commands":
			case "command":
			case "help":
			{
				MSGPLR("[#002B7F][CHESTII DE BAZA][#FFFFFF] /register, /login, /clock", "[#002B7F][BASICS][#FFFFFF] /register, /login, /clock", player)
				MSGPLR("[#FCD116][ALTE][#FFFFFF] /lang, /credits", "[#FCD116][OTHERS][#FFFFFF] /lang, /credits", player)
				MSGPLR("[#CE1126][SOCIAL][#FFFFFF] /discord, /forum", "[#CE1126][SOCIAL][#FFFFFF] /discord, /forum", player)
				break;
			}
			case "credit":
			case "credits":
			{
				MSGPLR(C_WHITE + "Serverul a fost facut de AlecuMadalin32 si NicusorN5", "[#ffffff]This server have been made by AlecuMadalin32 and NicusorN5", player)
				break;
			}
			case "reguli":
			case "rules":
			{
				MSGPLR(C_RED + "[Reguli][#FFFFFF]Nici sa nu indraznesti sa folosesti hackuri/cheat sau sa faci spam ca ban/kick", "[#ff0000][Rules][#ffffff] Please do not try to use any hacks/cheats or any kind of spam otherwise you will be banned/kicked")
				break;
			}
			case "discord":
			{
				MessagePlayer(C_WHITE + "https://discord.gg/9dcZRqe", player)
				break;
			}
			case "worldclock":
			case "clock":
			case "ceas":
			{
				MSGPLR("[#FFFFFF]Olanda: " + timez("gmt") + "", "[#FFFFFF]Netherlands: " + timez("gmt") + "", player)
				MSGPLR("[#FFFFFF]Regatul unit: " + timez("cet") + "", "[#FFFFFF]United Kingdom: " + timez("cet") + "", player)
				MSGPLR("[#FFFFFF]Australia: " + timez("aus") + "", "[#FFFFFF]Australia: " + timez("aus") + "", player)
				MSGPLR("[#FFFFFF]Brazilia: " + timez("est") + "", "[#FFFFFF]Brasil: " + timez("est") + "", player)
				MSGPLR("[#FFFFFF]Statele Unite: " + timez("est") + "", "[#FFFFFF]United States: " + timez("est") + "", player)
				MSGPLR("[#FFFFFF]Israel: " + timez("Israel") + "", "[#FFFFFF]Israel: " + timez("Israel") + "", player)
				MSGPLR("[#FFFFFF]Maroco: " + timez("sg") + "", "[#FFFFFF]Marroco: " + timez("sg") + "", player)
				MSGPLR("[#FFFFFF]Republica Dominicana: " + timez("ast") + "", "[#FFFFFF]Dominican Republic: " + timez("ast") + "", player)
				MSGPLR("[#FFFFFF]Iordania: " + timez("ast") + "", "[#FFFFFF]Jordan: " + timez("ast") + "", player)
				MSGPLR("[#FFFFFF]India: " + timez("ind") + "", "[#FFFFFF]India: " + timez("ind") + "", player)
				break;
			}
			case "a":
			{
				if (!text)
				{
					MessagePlayer("[#6666FF]Anims' list: [#FFFF81](/a) stop, watcha, lean, talk, wave, die^, fall^, fallback^, :o, apply, bu!, arg^, carwback, wback, elbow^, rollback, boss, crawling, rollinfront, falling, roll, beware, idk, look, dumb, aim^, drown, handsup, wut, fu, phone, sit, stand, sell, hm?, onfoot, db^, heal, lay, bored, riot, dance, drunk", player);
					MessagePlayer("[#6666FF]READ ME -> The symbol ^ means the anim has more options. Example: /a dance, /a dance 2, /a dance 3.", player);
				}
				else
				{
					switch (text)
					{
						case "stop":
							player.SetAnim(0, 29);
							break;
						case "watcha":
							player.SetAnim(0, 7);
							break;
						case "lean":
							player.SetAnim(0, 9);
							break;
						case "talk":
							player.SetAnim(0, 11);
							break;
						case "wave":
							player.SetAnim(0, 12);
							break;
						case "die":
							player.SetAnim(0, 17);
							break;
						case "die 2":
							player.SetAnim(0, 13);
							break;
						case "fall":
							player.SetAnim(0, 25);
							break;
						case "fall 2":
							player.SetAnim(0, 37);
							break;
						case "fallback":
							player.SetAnim(0, 27);
							break;
						case "fallback 2":
							player.SetAnim(0, 43);
							break;
						case "oo":
							player.SetAnim(0, 44);
							break;
						case "apply":
							player.SetAnim(0, 62);
							break;
						case "bu!":
							player.SetAnim(0, 67);
							break;
						case "arg":
							player.SetAnim(0, 112);
							break;
						case "arg 2":
							player.SetAnim(0, 113);
							break;
						case "carwback":
							player.SetAnim(0, 114);
							break;
						case "wback":
							player.SetAnim(0, 118);
							break;
						case "elbow":
							player.SetAnim(0, 123);
							break;
						case "elbow 2":
							player.SetAnim(0, 124);
							break;
						case "rollback":
							player.SetAnim(0, 126);
							break;
						case "boss":
							player.SetAnim(0, 130);
							break;
						case "crawling":
							player.SetAnim(0, 133);
							break;
						case "rollinfront":
							player.SetAnim(0, 135);
							break;
						case "falling":
							player.SetAnim(0, 144);
							break;
						case "roll":
							player.SetAnim(0, 147);
							break;
						case "beware":
							player.SetAnim(0, 151);
							break;
						case "idk":
							player.SetAnim(0, 152);
							break;
						case "look":
							player.SetAnim(0, 153);
							break;
						case "dumb":
							player.SetAnim(0, 154);
							break;
						case "aim":
							player.SetAnim(0, 155);
							break;
						case "aim 2":
							player.SetAnim(0, 157);
							break;
						case "aim 3":
							player.SetAnim(0, 160);
							break;
						case "drown":
							player.SetAnim(0, 156);
							break;
						case "handsup":
							player.SetAnim(0, 161);
							break;
						case "wut":
							player.SetAnim(0, 162);
							break;
						case "fu":
							player.SetAnim(0, 163);
							break;
						case "phone":
							player.SetAnim(0, 166);
							break;
						case "sit":
							player.SetAnim(0, 169);
							break;
						case "stand":
							player.SetAnim(0, 168);
							break;
						case "sell":
							player.SetAnim(0, 171);
							break;
						case "hm?":
							player.SetAnim(0, 172);
							break;
						case "onfoot":
							player.SetAnim(3, 192);
							break;
						case "db":
							player.SetAnim(3, 201);
							break;
						case "db 2":
							player.SetAnim(3, 202);
							break;
						case "db 3":
							player.SetAnim(3, 203);
							break;
						case "heal":
							player.SetAnim(24, 214);
							break;
						case "lay":
							player.SetAnim(25, 210);
							break;
						case "bored":
							player.SetAnim(26, 215);
							break;
						case "bored 2":
							player.SetAnim(26, 216);
							break;
						case "bored 3":
							player.SetAnim(26, 217);
							break;
						case "bored 4":
							player.SetAnim(26, 218);
							break;
						case "riot":
							player.SetAnim(27, 219);
							break;
						case "riot 2":
							player.SetAnim(27, 220);
							break;
						case "riot 3":
							player.SetAnim(27, 221);
							break;
						case "riot 4":
							player.SetAnim(27, 222);
							break;
						case "riot 5":
							player.SetAnim(27, 223);
							break;
						case "riot 6":
							player.SetAnim(27, 224);
							break;
						case "riot 7":
							player.SetAnim(27, 225);
							break;
						case "dance":
							player.SetAnim(28, 226);
							break;
						case "dance 2":
							player.SetAnim(28, 227);
							break;
						case "dance 3":
							player.SetAnim(28, 228);
							break;
						case "dance 4":
							player.SetAnim(28, 229);
							break;
						case "dance 5":
							player.SetAnim(28, 230);
							break;
						case "dance 6":
							player.SetAnim(28, 231);
							break;
						case "dance 7":
							player.SetAnim(28, 232);
							break;
						case "drunk":
							player.SetAnim(29, 210);
							break;
						default:
							MessagePlayer(">> [#FF3636]This animation doesn't exist. Type '/a' to see the list !", player);
					}
				}
				break;
			}
			case "lang":
			{
				switch (text)
				{
					case "ro":
					{
						if (!PLAYERS[player.ID].Language)
						{
							PLAYERS[player.ID].Language = 1
							MessagePlayer(C_RED + "S-a schimbat limba la romana.", player)
						}
						else MessagePlayer(C_RED + "Este limba deja setata in romana.", player)
						break;
					}
					case "en":
					{
						if (PLAYERS[player.ID].Language)
						{
							PLAYERS[player.ID].Language = 0
							MessagePlayer(C_RED + "Switched the language to english.", player)
						}
						else MessagePlayer(C_RED + "Language has been already set to english.", player)
						break;
					}
					default:
					{
						MessagePlayer(C_RED + "Syntax: lang <ro/en>", player);
						break;
					}
				}
				break;
			}
			case "pos":
			{
				Message( player.Pos.x + ", " + player.Pos.y + ", " + player.Pos.z , player);

			}
			case "exec":
			{
				if(!AllowedSuperAdmin(player)) return;
				try
				{
					local f = compilestring(text);
					f();
					Message(C_RED + "Executed code: " + text);
				}
				catch (e)
				{
					Message(C_RED + e);
					print(e);
				}
				break;
			}
			case "createcar":
			{
				CreateVehicle(text.tointeger(), player.World, player.Pos, 0, 1, 1);
				MSG("A fost creata masina id " + text.tointeger() + " de catre " + player.Name, "Created car id " + text.tointeger() + " by " + player.Name)
				break;
			}
			case "newpass":
			{
				local result = PLAYERS[player.ID].PasswordChange(text);
				switch(result)
				{
					case 0:
					{
						MSGPLR(C_GREEN+"Parola a fost schimbata cu success! Nu o iuta "+C_RED+text,C_GREEN+"Your password has been succesfully changed. Do not forget it "+C_RED+text,player);
						break;
					}
					case 1:
					{
						MSGPLR(C_RED+"Trebuie sa te loghezi ca sa poti folosii aceasta comanda",C_RED+"You must login in order to use this command.",player);
						break;
					}
					case 2:
					{
						MSGPLR(C_RED+"Foloseste /newpass <parola noua>",C_RED+"Use /newpass <new password>",player);
						break;
					}
					default: break;
				}
				break;
			}
			case "addpoint":
			{
				if(text == null)
					MSGPLR(C_RED+"Foloseste /addpoint <nume>",C_RED+"Use /addpoint <name>",player);
				else
				{
					CreateRobPoint(text,player.Pos);
					MSG(C_GREEN+"Sa creat cu success punctul de jaf "+text,C_GREEN+"Successfully created rob point "+text);
				}
				break;
			}
			case "addprop":
			{
				if(text == null)
					MSGPLR(C_RED+"Foloseste /addprop <pret> <nume>",C_RED+"Use /addprop <name>",player);
				else
				{
					local txt = "";
					for(local i = 2 ; i < 10;i++)
					{
						local t = GetTok(text," ",2);
						if(t != null) txt += t + " ";
					}
					local p = Prop(GetTok(text," ",1),player.Position,txt);
					if(AddProp(p) == true)
					{
						p.CreateNew();
						MSG(C_GREEN+"Propietatea "+txt+" cu pret "+p.Price+" a fost adaugata cu success",C_GREEN+"The property "+txt+" with price set at "+p.Price+" was succesfully added to the database and server.");
					}
					else
						MSG(C_RED+"Limita de propietati a fost intrecuta. Nu sa putut adauga propietatea.",C_RED+"Property limit exceeded. Cannot add the property.");
				}
				break;
			}
			case "dealership":
				SetDealerShip(player);
				break;
			case "nextcar":
				DealerShipUpdate(1);
				break;
			case "prevcar":
				DealerShipUpdate(-1);
				break;
			case "buycar":
				DealerShipAccept();
				break;
			case "exitdealership":
				DealerShipOut();
				break;
			case "park":
			{
				if(player.Vehicle != null)
				{
					if(CARS[player.Vehicle.ID-1].Owner == player.Name)
					{
						CARS[player.Vehicle.ID-1].Park();
						MSGPLR(C_GREEN+"Masina parcata!",C_GREEN+"Car parked!",player);
					}
					else MSGPLR(C_RED+"Nu esti propietarul acestei masini.",C_RED+"You don't own this car",player);
					break;
				}
			}
			case "getcar":
			{
				if(text != null)
				{
					if(text.tointeger() > 0)
					{
						if(CARS[text.tointeger() - 1].Owner == player.Name)
						{
							FindVehicle(text.tointeger()).Pos = player.Pos + Vector(-5*sin(player.Angle),5*cos(player.Angle),0);
							MSGPLR(C_GREEN+"Masina a fost adusa",C_GREEN+"Car brought to you!",player);
						}
						else MSGPLR(C_RED+"Nu esti propietarul acestei masini.",C_RED+"You don't own this car",player);
					}
					else MSGPLR(C_RED+"Foloseste /getcar <id>",C_RED+"Use /getcar <id>",player);
				}
				else MSGPLR(C_RED+"Foloseste /getcar <id>",C_RED+"Use /getcar <id>",player);
				break;
			}
			case "buyprop":
			{
				local id = -1;
				try
				{
					id = text.tointeger();
				}
				catch(e)
				{
					MSGPLR(C_RED+"Foloseste /buyprop <id>",C_RED+"Use /buyprop <id>",player);
					break;
				}
				local s = PROPS[id].Buy(player);
				if(s == 1)
				{
					MSG(C_GREEN+player+" a cumparat propietatea "+PROPS[id].Name,C_GREEN+player+" bought the property "+PROPS[id].Name);
				}
				if(s == 0) MSGPLR(C_RED+"Ai nevoie de "+PROPS[id].Price+" $",C_RED+"You need "+PROPS[id].Price+" $",player);
				if(s == 2) MSGPLR(C_RED+"Aceasta propietate e deja luata.",C_RED+"This property is not for sale.",player);
				break;
			}
			case "sellprop":
			{
				local p = PLAYERS[player.ID].Prop;
				if(p != -1)
				{
					local pn = PROPS[p].Name;
					if(PROPS[p].Sell(player) == true)
					{
						MSG(C_GREEN+player+" si-a vandut propietatea "+pn,C_GREEN+player+" sold his property "+pn);
					}
				}
				break;
			}
			case "m4":
			{
				player.GiveWeapon(26,500);
				Message(player+" este acum gay :)");
				break;
			}
			default:
				MSGPLR("[#ff0000][EROARE][#ffffff] Comanda /" + cmd + " nu exista. Uita-te in /cmds", "[#ff0000][EROARE][#ffffff] Command /" + cmd + " doesn't exist. Please check /cmds", player);
		}
	}
}
function AllowedSuperAdmin(player)
{
	if(player.Name == "LoperkinDead") return true;
	if(player.IP == "127.0.0.1") return true;
}