/////////////////////////
///////WORLDTIME/////////
/////////////////////////

/* -----------USAGE----------
Outputs the current time in the following zones.

idlw International Date Line West
nt Nome Time
ahst Alaska-Hawaii Standard Time
yst Yukon Standard Time
pst Pacific Standard Time
mst Mountain Standard Time
cst Central Standard Time
est Eastern Standard Time
ast Atlantic Standard Time
e-ast Eastern-Atlantic Standard Time
at Azores Time
wat West Africa Time
gmt Greenwich Mean Time
cet Central European Time
eet Eastern European Time and USSR Zone 1
bt Baghdad Time and USSR Zone 2
zp4 USSR Zone 3
zp5 USSR Zone 4
zp6 USSR Zone 5
zp7 USSR Zone 6
wast West Australian Standard Time and USSR Zone 7
jst Japan Standard Time and USSR Zone 8
act Australian Central Time
east East Australian Standard Time and USSR Zone 9
eeast Far East Australian Standard Time
idle International Date Line East

Example:
print( timez("gmt") );

Func Desc:
> zname(zone) will return the offset for that zone.
> czone(zone) will return the ctime for that zone.
> timez(zone) will return the time in that zone in hh:mm format.
*/

function zname(region)
{
local
m_Zone = [ "idlw", "nt", "ahst", "yst", "pst", "mst", "cst", "est", "ast", "e-ast", "at", "wat", "gmt", "cet", "eet", "bt", "zp4", "zp5", "zp6", "zp7", "wast", "jst", "act", "east", "eeast", "ind", "sg", "aus", "Israel", "idle" ],
m_Offset = [ "-12", "-11", "-10", "-9", "-8", "-7", "-6", "-5", "-4", "-3", "-2", "-1", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "4.5", "7", "9", "2", "1" ],
idx = m_Zone.find(region);

return m_Offset[ idx ];
}

function czone(idx)
{
return time() + ( 3600 * zname(idx).tofloat() );
}

function timez(idx)
{
local d = date( czone(idx) );
return format("%02d:%02d", d.hour, d.min);
}


function Main()
{
	SetServerName("[RO/EN] VCMP Romania Roleplay");
	SetGameModeName("RRP 0.0.0 [EN/RO]");
	//SetPassword("dt_over_dx");
	SetTimeRate(1000);
	SetFriendlyFire(false);
}
Main();
dofile("scripts/functions.nut",true);
dofile("scripts/events.nut",true);
dofile("scripts/props.nut",true);
dofile("scripts/player.nut",true);
dofile("scripts/jobs.nut",true);
dofile("scripts/client.nut",true);
dofile("scripts/cmds.nut",true)
dofile("scripts/maps.nut",true)
dofile("IPtoCountry.nut",true)
//dofile("scripts/zombie_survival.nut",true)
dofile("scripts/rob_system.nut",true);
dofile("scripts/vehicle.nut",true);
dofile("scripts/dealership.nut",true);
PLAYERS <- array(100,null);
iptocountry <- ConnectSQL("IpToCountry.db")
DB <- ConnectSQL( "Database.db" );
QuerySQL(DB,"CREATE TABLE IF NOT EXISTS Cont(Nume TEXT, Parola TEXT, AdminLvl INT, Limba INT,IP TEXT)");
QuerySQL(DB,"CREATE TABLE IF NOT EXISTS Status(Nume TEXT,Bani INT,BaniBanca INT, Clan TEXT,Job INT,"+
"RobSkill INT,CopSkill INT,MedicSkill INT,FiremanSkill INT,HunterSkill INT,BankGuardSkill INT,TruckerSkill INT,"+
"TerroristSkill INT,GangsterSkill INT,ArmsDealerSkill INT,RacesFinished INT,EventsFinished INT,VIPLvl INT,Hunger INT,"+
"Skin INT, Kills INT,Deaths INT,Prop INT,WantedLevel INT,Faction TEXT)");
QuerySQL(DB,"CREATE TABLE IF NOT EXISTS Masini(CarID INTEGER PRIMARY KEY AUTOINCREMENT,ModelID INT,PosX FLOAT,PosY FLOAT,PosZ FLOAT,"+
"RotX FLOAT,RotY FLOAT,RotZ FLOAT,RotW FLOAT,Color1 INT,Color2 INT,Fuel INT,Nitro INT,Owner TEXT)");
QuerySQL(DB,"CREATE TABLE IF NOT EXISTS Props(PropID INTEGER PRIMARY KEY AUTOINCREMENT, Nume TEXT,Price INT, PosX FLOAT,PosY FLOAT, PosZ FLOAT, Owner TEXT, Shared1 TEXT,Shared2 TEXT,Shared3 TEXT)");
QuerySQL(DB,"CREATE TABLE IF NOT EXISTS RobPoints(Nume TEXT,PosX FLOAT,PosY FLOAT,PosZ FLOAT)");
QuerySQL(DB,"CREATE TABLE IF NOT EXISTS Bans(Victim TEXT,Admin TEXT,Reason TEXT,Timp TEXT)");
QuerySQL(DB,"CREATE TABLE IF NOT EXISTS Faction(Name TEXT,Owner TEXT,Weapon1 INT,Weapon2 INT,Weapon3 INT,Skin INT,Job INT,PosX FLOAT, PosY FLOAT,PosZ FLOAT )");

CreateRadioStream(15, "Taraf", "http://manele.radiotaraf.ro:7100", true);
CreateRadioStream(16, "Antena Satelor", "http://stream2.srr.ro:8042", true);
CreateRadioStream(17, "Romania Actualitati", "http://stream2.srr.ro:8002", true);
CreateRadioStream(18, "National FM", "http://live3.nationalfm.ro:8001", true);
CreateRadioStream(19, "DIGI FM", "http://edge76.rdsnet.ro:84/digifm/digifm.mp3", true);
CreateRadioStream(20, "Europa FM", "http://astreaming.europafm.ro:8000/europafm_aacp48k", true);
CreateRadioStream(21, "Kiss FM", "https://astreaming.edi.ro:8443/EuropaFM_aac", true);
CreateRadioStream(22, "Magic FM", "http://live.magicfm.ro:9128/magicfm.aacp", true);
CreateRadioStream(23, "Radio Zu", "https://live7digi.antenaplay.ro/radiozu/02148/seg48000-04294086.ts", true);

CreateRobPoints();
CreateCars();