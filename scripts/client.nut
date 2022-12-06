enum StreamData
{
	
}

function onClientScriptData( player )
{
	
}

function SendDataToClient( player, ... )
{
    if( vargv[0] )
    {
        local byte = vargv[0],
              len = vargv.len();
                
        if( 1 > len ) print( "ToClent <" + byte + "> No params specified." );
        else
        {
            Stream.StartWrite();
            Stream.WriteByte( byte );

            for( local i = 1; i < len; i++ )
            {
                switch( typeof( vargv[i] ) )
                {
                    case "integer": Stream.WriteInt( vargv[i] ); break;
                    case "string": Stream.WriteString( vargv[i] ); break;
                    case "float": Stream.WriteFloat( vargv[i] ); break;
                }
            }
            
            if( player == null ) Stream.SendStream( null );
            else if( typeof( player ) == "instance" ) Stream.SendStream( player );
            else print( "ToClient <" + byte + "> Player is not online." );
        }
    }
    else print( "ToClient: Even the byte wasn't specified..." );
}