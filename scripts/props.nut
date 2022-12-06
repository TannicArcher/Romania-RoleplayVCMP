PROPS <- array(300,null);

class Prop
{
	constructor(name,pos,price)
	{
		Name = name;
		Pos = pos;
		Price = price;
		P_ID = CreatePickup().ID;
	}
	Name = null;
	Pos = null;
	Owner = null;
	Price = 0;
	Shared1 = null;
	Shared2 = null;
	Shared3 = null;
	P_ID = -1;
}

function AddProp(prop)
{
	for(local i = 0; i < 300;i++)
	{
		if(PROPS[i] == null)
		{
			PROPS[i] = prop;
			return true;
		}
	}
	return false;
}

function Prop::CreateNew()
{
	::QuerySQL(DB,"INSERT INTO Props( Nume , Price, PosX ,PosY ,PosZ ) VALUES ("+name+","+price+","+Pos.X+","+Pos.y+","+Pos.z")");
}
function Prop::Buy(player)
{
	if(this.Owner != null)
	{
		if(PLAYERS[player.ID].Buy(this.Price))
		{
			this.Owner = player.Name;
			this.SaveOwner();
			return 1;
		}
		else return 0;
	}
	else return 2;
}
function Prop::Sell(player)
{
	if(player != null)
	{
		PLAYERS[player.ID].AddCash(this.Price/2);
	}
	if(this.Owner != player.Name) return false;
	this.Owner = null;
	this.Shared1 = null;
	this.Shared2 = null;
	this.Shared3 = null;
	::QuerySQL(DB,"UPDATE Props SET Nume = NULL, Shared1 = NULL, Shared2 = NULL, Shared3 = NULL WHERE Nume = "+this.GetSafeName());
}
function Prop::DetailString()
{
	return this.Name+", $ "+this.Price+" Owner"+this.Owner;
}
function Prop::Detail2String()
{
	local s1 = " ",s2 = " " ,s3 = " ";
	if(this.Shared1 != null) s1 = this.Shared1;
	if(this.Shared2 != null) s1 = this.Shared2;
	if(this.Shared3 != null) s1 = this.Shared3;
	return this.Name+", $ "+this.Price+" Owner"+this.Owner+" Shared: "+s1+" "+s2+" "+s3;
}
function Prop::SaveOwner()
{
	local name = this.GetSafeName();
	::QuerySQL(DB,"UPDATE Props SET Owner = "+name+" WHERE Nume = "+name);
}

function Prop::GetSafeName()
{
	return ::escapeSQLString(this.Owner);
}

function Prop::SaveShared1()
{
	local sh1 = ::escapeSQLString(this.Shared1);
	::QuerySQL(DB,"UPDATE Props SET Shared1 = "+sh1+" WHERE Nume = "+this.GetSafeName());
}
function Prop::SaveShared2()
{
	local sh2 = ::escapeSQLString(this.Shared2);
	::QuerySQL(DB,"UPDATE Props SET Shared1 = "+sh2+" WHERE Nume ="+this.GetSafeName());
}
function Prop::SaveShared3()
{
	local sh3 = ::escapeSQLString(this.Shared3);
	::QuerySQL(DB,"UPDATE Props SET Shared3 = "+sh3+" WHERE Nume = "+this.GetSafeName());
}

function Prop::DeleteShared1()
{
	this.Shared1 = null;
	::QuerySQL(DB,"UPDATE Props SET Shared1 = NULL WHERE Nume = "+this.GetSafeName());
}
function Prop::DeleteShared1()
{
	this.Shared2 = null;
	::QuerySQL(DB,"UPDATE Props SET Shared2 = NULL WHERE Nume = "+this.GetSafeName());
}
function Prop::DeleteShared1()
{
	this.Shared2 = null;
	::QuerySQL(DB,"UPDATE Props SET Shared3 = NULL WHERE Nume = "+this.GetSafeName());
}

function Prop::Share(player)
{
	if(Shared1 == null)
	{
		this.Shared1 = player.Name;
		this.SaveShared1();
		return;
	}
	if(Shared2 == null)
	{
		this.Shared2 = player.Name;
		this.SaveShared2();
		return;
	}
	if(Shared3 == null)
	{
		this.Shared3 = player.Name;
		this.SaveShared3();
		return;
	}
}
function Prop::UnShare1()
{
	if(Shared1 != null)
	{
		this.Shared1 = player.Name;
		this.DeleteShared1();
		return;
	}
	if(Shared2 != null)
	{
		this.Shared2 = player.Name;
		this.DeleteShared2();
		return;
	}
	if(Shared3 != null)
	{
		this.Shared3 = player.Name;
		this.DeleteShared3();
		return;
	}
}