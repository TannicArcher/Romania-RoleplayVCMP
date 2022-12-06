class Player
{
	constructor(id)
	{
		ID = id;
		Name = ""+FindPlayer(id).Name;
		Language = 0;
		Cash = 0;
		BankCash = 0;
		AdminLvl = 0;
		Clan = "";
		Job = 0;
		Skin = 15;
		Prop = -1;
	}
	ID = 0;
	Name = null;
	Password = null;
	Language = 0; // 0 - eng, 1 - romana
	Cash = 0;
	WantedLevel = 0;
	Skin = 0;
	BankCash = 0;
	AdminLvl = 0;
	Clan = "";
	Job = 0;
	RobSkill = 0;
	CopSkill = 0;
	MedicSkill = 0;
	FiremanSkill = 0;
	HunterSkill = 0;
	BankGuardSkill = 0;
	TruckerSkill = 0;
	TerroristSkill = 0;
	GangsterSkill =0;
	ArmsDealerSkill = 0;
	RacesFinished = 0;
	EventsFinished = 0;
	VIP = 0;
	Kills = 0;
	Deaths = 0;
	Skin = 0;
	Hunger = 100;
	
	Prop = -1;

	SpamMessages = 0;
	Logged = false;
	LoginAttempts = 0;
	IP = null;
	
	JobQuantity = 0;
	ArrestTime = 0;
}
//Functii interene
function Player::GetInst()
{
	return ::FindPlayer(this.ID);
}


//Functii data de baze
function Player::GetPassword()
{
	local n = ::escapeSQLString(this.Name);
	local q = ::QuerySQL(DB,"SELECT Parola FROM Cont WHERE Nume = '"+n+"'");
	if(q)
	{
		local pass = ::GetSQLColumnData(q,0);
		::FreeSQLQuery(q);
		return pass;
	}
	return null;
}

function Player::Register(password)
{
	if(password == null) return false;
	local p = ::escapeSQLString(password);
	local n = ::escapeSQLString(this.Name);
	if(this.GetPassword() == null)
	{
		::QuerySQL(DB,"INSERT INTO Cont(Nume , Parola , AdminLvl , Limba ) VALUES('"+n+"','"+p+"', 0 , 0 )");
		::QuerySQL(DB,"INSERT INTO Status(Nume ,Bani ,BaniBanca , Clan ,Job ,"+
"RobSkill ,CopSkill ,MedicSkill ,FiremanSkill ,HunterSkill ,BankGuardSkill ,TruckerSkill ,"+
"TerroristSkill ,GangsterSkill ,ArmsDealerSkill ,RacesFinished ,EventsFinished ,VIPLvl ,Hunger, Skin, Kills, Deaths, Prop,WantedLevel ) VALUES "+
"('"+n+"','0','0','','0','0','0','0','0','0','0','0','0','0','0','0','0','0','100','15','0','0','-1','0')");
		this.Logged = true;
		return true;
	}
	return false;
}
function Player::Login(password)
{
	if(this.GetPassword() == null) return 2;
	if(password == this.GetPassword())
	{
		this.Logged = true;
		return true;
	}
	return false;
}
function Player::Message(romana,engleza)
{
	switch(this.Language)
	{
		case 0:
			::MessagePlayer(engleza,this.GetInst());
			break;
		default:
			::MessagePlayer(romana,this.GetInst());
			break;
	}
}

function Player::Load()
{
	local n = ::escapeSQLString(this.Name);
	local q = ::QuerySQL(DB,"SELECT * FROM Status WHERE Nume = '"+n+"'");
	if(q)
	{
		this.Cash = ::GetSQLColumnData(q,1);
		this.BankCash = ::GetSQLColumnData(q,2);
		this.Clan = ::GetSQLColumnData(q,3);
		this.Job = ::GetSQLColumnData(q,4);
		this.RobSkill = ::GetSQLColumnData(q,5);
		this.CopSkill = ::GetSQLColumnData(q,6);
		this.MedicSkill = ::GetSQLColumnData(q,7);
		this.FiremanSkill = ::GetSQLColumnData(q,8);
		this.HunterSkill = ::GetSQLColumnData(q,9);
		this.BankGuardSkill = ::GetSQLColumnData(q,10);
		this.TruckerSkill = ::GetSQLColumnData(q,11);
		this.TerroristSkill = ::GetSQLColumnData(q,12);
		this.GangsterSkill = ::GetSQLColumnData(q,13);
		this.ArmsDealerSkill = ::GetSQLColumnData(q,14);
		this.RacesFinished = ::GetSQLColumnData(q,15);
		this.EventsFinished = ::GetSQLColumnData(q,16);
		this.VIP = ::GetSQLColumnData(q,17);
		this.Hunger = ::GetSQLColumnData(q,18);
		this.Skin = ::GetSQLColumnData(q,19);
		this.Kills = ::GetSQLColumnData(q,20);
		this.Deaths = ::GetSQLColumnData(q,21);
		this.Prop = ::GetSQLColumnData(q,22);
		this.WantedLevel = ::GetSQLColumnData(q,23);
		::FreeSQLQuery(q);
	}
	this.RefreshIP();
	this.UpdateInst();
}

function Player::SaveStats()
{
	local p = ::escapeSQLString(this.Name);
	::QuerySQL(DB,"UPDATE Status SET Bani = "+this.Cash+" ,BaniBanca = "+this.BankCash+" , Clan = '"+this.Clan+"' ,Job = "+this.Job+" ,"+
"RobSkill = "+this.RobSkill+" ,CopSkill = "+this.CopSkill+" ,MedicSkill = "+this.MedicSkill+" ,FiremanSkill = "+this.FiremanSkill+",HunterSkill = "+this.HunterSkill+" ,BankGuardSkill = "+this.BankGuardSkill+",TruckerSkill = "+this.TruckerSkill+" ,"+
"TerroristSkill = "+this.TerroristSkill+" ,GangsterSkill = "+this.GangsterSkill+" ,ArmsDealerSkill = "+this.ArmsDealerSkill+",RacesFinished = "+this.RacesFinished+" ,EventsFinished = "+this.EventsFinished+" ,VIPLvl = "+this.VIP+",Hunger = "+
this.Hunger+" ,Skin = "+this.Skin+",Kills = "+this.Kills+",Deaths = "+this.Deaths+",Prop = '"+this.Prop+"' WantedLevel = "+this.WantedLevel+" WHERE Nume = '"+p+"'");
	::QuerySQL(DB,"UPDATE Cont SET IP = '"+this.IP+"' WHERE Nume = '"+p+"'");
}


/*

	FUNCTII MESAJE

*/
function MSG(romana,engleza)
{
	for(local i =0 ; i < 100;i++)
	{
		if(::PLAYERS[i] != null)
		{
			::PLAYERS[i].Message(romana,engleza);
		}
	}
}
function MSGPLR(romana,engleza,plr)
{
	PLAYERS[plr.ID].Message(romana,engleza);
}
function ANNPLR(romana,engleza,plr)
{
	PLAYERS[plr.ID].Announce(romana,engleza)	

}
function Player::Announce(romana,engleza)
{
	switch(this.Language)
	{
		case 0:
			::Announce(engleza,this.GetInst());
			break;
		default:
			::Announce(romana,this.GetInst());
			break;
	}
}
function Player::GetRobRankEN()
{
	if(this.RobSkill == 0) return "Legit citizen";
	if(this.RobSkill <= 5) return "Mice";
	if(this.RobSkill >= 5 && this.RobSkill <= 10) return "Rat";
	if(this.RobSkill >= 10 && this.RobSkill <= 25) return "Dirty Rat";
	if(this.RobSkill >= 25 && this.RobSkill <= 50) return "Fat Rat";
	if(this.RobSkill >= 50 && this.RobSkill <= 75) return "Hobo";
	if(this.RobSkill >= 75 && this.RobSkill <= 100) return "Stalker";
	if(this.RobSkill >= 100 && this.RobSkill <= 125) return "Low lifer";
	if(this.RobSkill >= 125 && this.RobSkill <= 150) return "Low life robber";
	if(this.RobSkill >= 150 && this.RobSkill <= 175) return "N00b robber";
	if(this.RobSkill >= 175 && this.RobSkill <= 200) return "Amateur robber";
	if(this.RobSkill >= 200 && this.RobSkill <= 250) return "Common robber";
	if(this.RobSkill >= 250 && this.RobSkill <= 300) return "Experienced robber";
	if(this.RobSkill >= 300 && this.RobSkill <= 400) return "Professional robber";
	if(this.RobSkill >= 500) return "King of the streets";
}
function Player::GetRobRankRO()
{
	if(this.RobSkill == 0) return "Cetatean legitim";
	if(this.RobSkill <= 5) return "Soarece";
	if(this.RobSkill >= 5 && this.RobSkill <= 10) return "Sobolan";
	if(this.RobSkill >= 10 && this.RobSkill <= 25) return "Sobolan murdar";
	if(this.RobSkill >= 25 && this.RobSkill <= 50) return "Sobolan gras";
	if(this.RobSkill >= 50 && this.RobSkill <= 75) return "Homalau";
	if(this.RobSkill >= 75 && this.RobSkill <= 100) return "Spion";
	if(this.RobSkill >= 100 && this.RobSkill <= 125) return "Drogat";
	if(this.RobSkill >= 125 && this.RobSkill <= 150) return "Hot drogat";
	if(this.RobSkill >= 150 && this.RobSkill <= 175) return "Hot b00b";
	if(this.RobSkill >= 175 && this.RobSkill <= 200) return "Hot amator";
	if(this.RobSkill >= 200 && this.RobSkill <= 250) return "Hot comun";
	if(this.RobSkill >= 250 && this.RobSkill <= 300) return "Hot cu experienta";
	if(this.RobSkill >= 300 && this.RobSkill <= 400) return "Hot profesionist";
	if(this.RobSkill >= 500) return "Regele strazilor";
}
function Player::GetCopRankEN()
{
	if(this.CopSkill == 0) return "Citizen";
	if(this.CopSkill <= 5) return "Agent";
	if(this.CopSkill >= 5 && this.CopSkill <= 10) return "Principal Agent";
	if(this.CopSkill >= 10 && this.CopSkill <= 25) return "Agent Deputy Chief";
	if(this.CopSkill >= 25 && this.CopSkill <= 50) return "Agent Chief";
	if(this.CopSkill >= 50 && this.CopSkill <= 75) return "Agent Main Chief";
	if(this.CopSkill >= 75 && this.CopSkill <= 100) return "Subinspector";
	if(this.CopSkill >= 100 && this.CopSkill <= 125) return "Inspector";
	if(this.CopSkill >= 125 && this.CopSkill <= 150) return "Principal Inspector";
	if(this.CopSkill >= 150 && this.CopSkill <= 175) return "Subcomissar";
	if(this.CopSkill >= 175 && this.CopSkill <= 200) return "Comissar";
	if(this.CopSkill >= 200 && this.CopSkill <= 250) return "Comissar Cheif";
	if(this.CopSkill >= 250 && this.CopSkill <= 300) return "Chestor";
	if(this.CopSkill >= 300 && this.CopSkill <= 400) return "Principal Chestor";
	if(this.CopSkill >= 400 && this.CopSkill <= 500) return "Chestor Cheif";
	if(this.CopSkill >= 500) return "Chestor General";
}
function Player::GetMedicRankEN()
{
	if(this.MedicSkill == 0) return "Citizen";
	if(this.MedicSkill <= 5) return "Student";
	if(this.MedicSkill >= 5 && this.MedicSkill <= 10) return "PhD";
	if(this.MedicSkill >= 10 && this.MedicSkill <= 25) return "Medic";
	if(this.MedicSkill >= 25 && this.MedicSkill <= 50) return "Specialized medic";
	if(this.MedicSkill >= 50 && this.MedicSkill <= 75) return "Surgeon";
	if(this.MedicSkill >= 75 ) return "Specialized surgeon";
}
function Player::GetMedicRankRO()
{
	if(this.MedicSkill == 0) return "Cetatean";
	if(this.MedicSkill <= 5) return "Student";
	if(this.MedicSkill >= 5 && this.MedicSkill <= 10) return "Student cu doctorat";
	if(this.MedicSkill >= 10 && this.MedicSkill <= 25) return "Medic";
	if(this.MedicSkill >= 25 && this.MedicSkill <= 50) return "Medic specializat";
	if(this.MedicSkill >= 50 && this.MedicSkill <= 75) return "Chirurg";
	if(this.MedicSkill >= 75 ) return "Chirurg specializat";
}
function Player::GetHunterRankEN()
{
	if(this.HunterSkill == 0) return "Citizen";
	if(this.HunterSkill <= 5) return "n00b silver sh00ter";
	if(this.HunterSkill >= 5 && this.HunterSkill <= 10) return "n00b sh00ter";
	if(this.HunterSkill >= 10 && this.HunterSkill <= 25) return "Amateur";
	if(this.HunterSkill >= 25 && this.HunterSkill <= 50) return "Common hunter";
	if(this.HunterSkill >= 50 && this.HunterSkill <= 75) return "HUNTer";
	if(this.HunterSkill >= 75 && this.HunterSkill <= 100) return "Experienced Hunter";
	if(this.HunterSkill >= 100 && this.HunterSkill <= 125) return "Snipp";
	if(this.HunterSkill >= 125 && this.HunterSkill <= 150) return "n00b sniper";
	if(this.HunterSkill >= 150 && this.HunterSkill <= 175) return "Sniper";
	if(this.HunterSkill >= 175 && this.HunterSkill <= 200) return "Experienced sniper";
	if(this.HunterSkill >= 200 && this.HunterSkill <= 250) return "King of the forest";
	if(this.HunterSkill >= 300 && this.HunterSkill <= 400) return "King of the savanna";
	if(this.HunterSkill >= 400 && this.HunterSkill <= 500) return "King of the jungle";
	if(this.HunterSkill >= 500) return "King of the nature";
}
function Player::GetHunterRankRO()
{
	if(this.HunterSkill == 0) return "Cetatean";
	if(this.HunterSkill <= 5) return "n00b silver sh00ter";
	if(this.HunterSkill >= 5 && this.HunterSkill <= 10) return "n00b sh00ter";
	if(this.HunterSkill >= 10 && this.HunterSkill <= 25) return "Amator";
	if(this.HunterSkill >= 25 && this.HunterSkill <= 50) return "Vanator comun";
	if(this.HunterSkill >= 50 && this.HunterSkill <= 75) return "HUNTer";
	if(this.HunterSkill >= 75 && this.HunterSkill <= 100) return "Vanator cu experienta";
	if(this.HunterSkill >= 100 && this.HunterSkill <= 125) return "Snipp";
	if(this.HunterSkill >= 125 && this.HunterSkill <= 150) return "lunetist n00b";
	if(this.HunterSkill >= 150 && this.HunterSkill <= 175) return "Lunetist";
	if(this.HunterSkill >= 175 && this.HunterSkill <= 200) return "Lunetist cu experienta";
	if(this.HunterSkill >= 200 && this.HunterSkill <= 250) return "Rege al padurii";
	if(this.HunterSkill >= 300 && this.HunterSkill <= 400) return "Rege al savanei";
	if(this.HunterSkill >= 400 && this.HunterSkill <= 500) return "Rege al junglei";
	if(this.HunterSkill >= 500) return "Rege al naturii";
}

/*

	FUNCTII LEGATE DE EVENIMENTELE VCMP

*/

function Player::Spawn()
{
	local p = this.GetInst();
	if(this.Prop != -1) p.Pos = PROPS[this.Prop].Pos;
	p.Skin = this.Skin;
}
function Player::Quit()
{
	this.SaveStats();
}

/*
	ALTE CHESTII
*/
function Player::Buy(value)
{
	if(this.Cash > value)
	{
		this.Cash -= value;
		this.UpdateInst();
		::MessagePlayer(::C_RED+"-"+value+" $",this.GetInst());
		return true;
	}
	else return false;
}
function Player::SetCash(c)
{
	this.Cash = c;
	this.UpdateInst();
}
function Player::UpdateInst()
{
	local inst = this.GetInst();
	inst.Skin = this.Skin;
	inst.Cash = this.Cash;
	inst.WantedLevel = this.WantedLevel;
}
function Player::Autologin()
{
	local CurrentIP = this.GetInst().IP;
	this.RefreshIP();
	if(this.IP == CurrentIP)
	{
		this.Logged = true;
		return true;
	}
	this.IP = CurrentIP;
	return false;
}
function Player::RefreshIP()
{
	local n = ::escapeSQLString(this.Name);
	local q = ::QuerySQL(DB,"SELECT IP FROM Cont WHERE Nume = '"+n+"'");
	if(q)
	{
		this.IP = ::GetSQLColumnData(q,0);
		::FreeSQLQuery(q);
	}
}
function Player::PasswordChange(newpass)
{
	local n = ::escapeSQLString(this.Name);
	if(newpass != null)
	{
		if(this.Logged) 
		{
			::QuerySQL(DB,"UPDATE Cont SET Parola = '"+::escapeSQLString(newpass)+"' WHERE Nume= '"+n+"'");
			return 0;
		}
		return 1;
	}
	return 2;
}
function Player::AddCash(c)
{
	this.Cash += c;
	this.UpdateInst();
	MessagePlayer(C_GREEN+"+"+c+" $",this.GetInst());
}
function Player::ShowStats()
{
	
}
function Player::UpdateMinute()
{
	this.Hunger -= 1;
	this.Thirst -= 2;
	if(this.Hunger < 0)
	{
		local i = this.GetInst();
	}
}
function CPlayer::Kill()
{
	this.Eject();
	this.Health = 0;
	this.Armour = 0;
	this.Immunity = 0;
}