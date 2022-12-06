CARS <- array(1000,null);

class Car
{
	constructor(id)
	{
		ID = id;
	}
	ID = 0;
	dbID = -1;
	Owner = null; //pointer nul (sir de caractere)
	Model = 0; //{get; private set;} pls
	SpawnPosX = 0.0;
	SpawnPosY = 0.0;
	SpawnPosZ = 0.0;
	SpawnQuaternionX = 0.0;
	SpawnQuaternionY = 0.0;
	SpawnQuaternionZ = 0.0;
	SpawnQuaternionW = 0.0;
	Color1 = 1;
	Color2 = 1;
	Fuel = 100;
	NOS = 1000;
}
function Car::ShowStats()
{
	local i = this.GetInst();
	return "ID "+i.ID+" Owner:"+this.Owner+" Fuel"+this.Fuel+" NOS:"+this.NOS;
}
function Car::GetInst()
{
	return ::FindVehicle(this.ID);
}
function Car::Owner_SafeText()
{
	if(Owner != null) return Owner;
	else return "For Sale";
}
function Car::FuelClamp()
{
	if(this.Fuel < 0) this.Fuel = 0;
	if(this.Fuel > 100) this.Fuel = 100;
}
function Car::NOSClamp()
{
	if(this.NOS < 0) this.NOS = 0;
	if(this.NOS > 1000) this.NOS = 1000;
}
function Car::MinuteUpdate()
{
	this.Fuel -= 1;
	this.FuelClamp();
	if(this.Fuel == 0) this.DisableEngine();
}
function Car::EnableEngine()
{
	local car = this.GetInst();
	//TODO: Scrie Codul ca sa resetezi acceleratia si viteza maxima la vehicul
}
function Car::DisableEngine()
{
	local car = this.GetInst();
	///TODO: Scrie codul ca sa nu mai functioneze masina
}
function Car::AddFuel(val)
{
	if((this.Fuel == 0 ) && (val > 0))
	{
		this.Fuel += val;
		this.FuelClamp();
		this.EnableEngine();
	}
}
function Car::ActivateNos()
{
	local c = this.GetInst();
	//aaaaaaaaaaaaaaa
}
function Car::DisableNos()
{
	local c = this.GetInst();
	//bbbbbbbbbbbbbbbbbbb
}
function Car::Buy(classplayer)
{
	if(classplayer.Buy(this.GetPrice()) == true)
	{
		this.Owner = classplayer.Name;
		this.SaveStats();
		return true;
	}
	return false;
}
function Car::CreateNew()
{
	local name = ::escapeSQLString(this.Owner);
	::QuerySQL(DB, "INSERT INTO Masini(ModelID ,PosX ,PosY ,PosZ ,RotX ,RotY ,RotZ ,RotW ,Color1 ,Color2 ,Fuel ,Nitro ,Owner ) VALUES("+this.Model+","+this.SpawnPosX+","+this.SpawnPosY+","+this.SpawnPosZ+","+this.SpawnQuaternionX+","+
	this.SpawnQuaternionY+","+this.SpawnQuaternionZ+","+this.SpawnQuaternionW+","+this.Color1+","+this.Color2+","+this.Fuel+","+this.NOS+",'"+name+"')");
}
function Car::CreateInst()
{
	local veh = ::CreateVehicle(this.Model,0,SpawnPosX,SpawnPosY,SpawnPosZ,0,Color1,Color2);
	if(veh == null) return;
	veh.Rotation = Quaternion(this.SpawnQuaternionX,this.SpawnQuaternionY,this.SpawnQuaternionZ,this.SpawnQuaternionW);
	this.ID = veh.ID;
}
function LoadCar(i,a)
{
	CARS[i] = Car(0);
	CARS[i].dbID = ::GetSQLColumnData(a,0);
	CARS[i].Model = ::GetSQLColumnData(a,1);
	CARS[i].SpawnPosX = ::GetSQLColumnData(a,2);
	CARS[i].SpawnPosY = ::GetSQLColumnData(a,3);
	CARS[i].SpawnPosZ = ::GetSQLColumnData(a,4);
	CARS[i].SpawnQuaternionX = ::GetSQLColumnData(a,5);
	CARS[i].SpawnQuaternionY = ::GetSQLColumnData(a,6);
	CARS[i].SpawnQuaternionZ = ::GetSQLColumnData(a,7);
	CARS[i].SpawnQuaternionW = ::GetSQLColumnData(a,8);
	CARS[i].Color1 = ::GetSQLColumnData(a,9);
	CARS[i].Color2 = ::GetSQLColumnData(a,10);
	CARS[i].Fuel = ::GetSQLColumnData(a,11);
	CARS[i].NOS = ::GetSQLColumnData(a,12);
	CARS[i].Owner = ::GetSQLColumnData(a,13);
}
function Car::SaveStats()
{
	local name = ::escapeSQLString(this.Owner);
	::QuerySQL(DB,"UPDATE Masini SET Owner ='"+name+"',PosX = "+this.SpawnPosX+" ,PosY = "+this.SpawnPosY+" ,PosZ = "+this.SpawnPosZ+" ,RotX = "+
	this.SpawnQuaternionX+" ,RotY = "+this.SpawnQuaternionY+",RotZ = "+this.SpawnQuaternionZ+" ,RotW = "+this.SpawnQuaternionW+" ,Color1 = "+this.Color1+" ,Color2 = "+this.Color2+
	" ,Fuel = "+this.Fuel+" ,Nitro = "+this.NOS+" WHERE CarID="+this.dbID);
	::print("UPDATE Masini SET Owner ='"+name+"',PosX = "+this.SpawnPosX+" ,PosY = "+this.SpawnPosY+" ,PosZ = "+this.SpawnPosZ+" ,RotX = "+
	this.SpawnQuaternionX+" ,RotY = "+this.SpawnQuaternionY+",RotZ = "+this.SpawnQuaternionZ+" ,RotW = "+this.SpawnQuaternionW+" ,Color1 = "+this.Color1+" ,Color2 = "+this.Color2+
	" ,Fuel = "+this.Fuel+" ,Nitro = "+this.NOS+" WHERE CarID="+this.dbID);
}
function Car::Park() 
{
	this.Update();
	this.SaveStats();
}
function Car::Update()
{
	local inst = this.GetInst();
	this.SpawnPosX = inst.Pos.x;
	this.SpawnPosY = inst.Pos.y;
	this.SpawnPosZ = inst.Pos.z;
	this.SpawnQuaternionX = inst.Rotation.x;
	this.SpawnQuaternionY = inst.Rotation.y;
	this.SpawnQuaternionZ = inst.Rotation.z
	this.SpawnQuaternionW = inst.Rotation.w;
	this.Color1 = inst.Colour1;
	this.Color2 = inst.Colour2;
	inst.SpawnPos = inst.Pos;
}
function Car::Spawn()
{
	local inst = this.GetInst();
	inst.Pos.x = this.SpawnPosX;
	inst.Pos.y = this.SpawnPosY;
	inst.Pos.z = this.SpawnPosZ;
	inst.Rotation.x = this.SpawnQuaternionX;
	inst.Rotation.y = this.SpawnQuaternionY;
	inst.Rotation.z = this.SpawnQuaternionZ;
	inst.Rotation.w = this.SpawnQuaternionW;
	inst.Colour1 = this.Color1;
	inst.Colour2 = this.Color2;
}
function Car::SetColors(c1,c2)
{
	local inst = this.GetInst();
	inst.Colour1 = c1;
	inst.Colour2 = c2;
	this.Color1 = c1;
	this.Color2 = c2;
	//perhaps use:
	//this.Color1 = inst.Colour1 = c1; ?
	//this.Color2 = inst.Colour2 = c2; ?
}

function CreateCars()
{
	local a = ::QuerySQL(DB,"SELECT * FROM Masini");
	LoadCar(0,a);
	CARS[0].CreateInst();
	for(local i =1 ; GetSQLNextRow(a) ;i++)
	{
		LoadCar(i,a);
		CARS[i].CreateInst();
	}
	::FreeSQLQuery(a);
}