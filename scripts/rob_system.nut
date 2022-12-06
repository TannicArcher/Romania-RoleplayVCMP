class RobPoint
{
	constructor(name,pos)
	{
		PID = ::CreatePickup(408,0,1,pos,255,true).ID;
		Name = name;
		Pos = pos;
	}
	PID = -1;
	Name = null;
	Pos = null;
}

function CreateRobPoints()
{
	local q = QuerySQL(DB,"SELECT * FROM RobPoints");
	if(q == null) return;
	CreateFromQuery(q,0);
	for(local i = 1 ; GetSQLNextRow(q) ; i++)
	{
		CreateFromQuery(q,i);
	}
	FreeSQLQuery(q);
}

function CreateRobPoint(name,pos)
{
	for(local i =0 ; i < 300;i++)
	{
		if(ROBPOINTS[i] == null)
		{
			ROBPOINTS[i] = RobPoint(name,pos);
			AddRobPoint(name,pos);
			return;
		}
	}
}

function AddRobPoint(name,pos)
{
	::QuerySQL(DB,"INSERT INTO RobPoints VALUES ('"+escapeSQLString(name)+"',"+pos.x+","+pos.y+","+pos.z+")");
}

function CreateFromQuery(q,i)
{
	local name = GetSQLColumnData(q,0);
	local x = GetSQLColumnData(q,1);
	local y = GetSQLColumnData(q,2);
	local z = GetSQLColumnData(q,3);
	ROBPOINTS[i] = RobPoint(name,Vector(x,y,z));
}

function RobPointPickup(pickup,player)
{
	for(local i =0 ; i < 300; i++)
	{
		if(ROBPOINTS[i] != null)
		{
			if(pickup.ID == ROBPOINTS[i].PID)
			{
				ROBPOINTS[i].Rob(player);
			}
		}
	}
}

function RobPoint::Rob(player)
{
	local robrand = rand() % 5000
	if(PLAYERS[player.ID].Job == 1)
	{
		PLAYERS[player.ID].Job = 0;
		PLAYERS[player.ID].WantedLevel += 10;
	}
	PLAYERS[player.ID].Cash += 5000 + robrand;
	PLAYERS[player.ID].WantedLevel++;
	PLAYERS[player.ID].UpdateInst();
	::FindPickup(this.PID).RespawnTime = 90000;
	::MSG(C_RED+player.Name+" a jefuit "+this.Name+" si a furat "+robrand+"$",C_RED+player.Name+" robbed "+this.Name+" and got "+robrand+"$")
}

ROBPOINTS <- array(300,null);