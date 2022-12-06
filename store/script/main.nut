
sX <- GUI.GetScreenSize().X;
sY <- GUI.GetScreenSize().Y;

//-------------------------------------------------------------------
    
function Script::ScriptLoad()
{
	
}

function Script::ScriptProcess()
{
}

function Player::PlayerShoot( player, weapon, hitEntity, hitPosition )
{
}

function Server::ServerData( stream )
{
    local type = stream.ReadByte();
    switch( type )
    {
        default:
        break;
    }
}

function onGameResize( width, height )
{
}

function GUI::GameResize( width, height )
{
}

function GUI::ElementClick( element, mouseX, mouseY )
{
}

function GUI::ElementRelease( element, mouseX, mouseY )
{
}

function GUI::ElementBlur( element )
{
}

function GUI::CheckboxToggle( checkbox, checked )
{
}

function GUI::InputReturn( editbox )
{
}

//-------------------------------------------------------------------

function SendDataToServer( ... )
{
    if( vargv[0] )
    {
        local   byte = vargv[0],
                len = vargv.len();
                
        if( 1 > len ) Console.Print( "ToClent <" + byte + "> No params specified." );
        else
        {
            local pftStream = Stream();
            pftStream.WriteByte( byte );

            for( local i = 1; i < len; i++ )
            {
                switch( typeof( vargv[i] ) )
                {
                    case "integer": pftStream.WriteInt( vargv[i] ); break;
                    case "string": pftStream.WriteString( vargv[i] ); break;
                    case "float": pftStream.WriteFloat( vargv[i] ); break;
                }
            }
            
            Server.SendData( pftStream );
        }
    }
    else Console.Print( "ToClient: Not even the byte was specified..." );
}