
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )
include( "cascade_player.lua" )
include( "cascade_positions.lua" )
include( "cascade_round.lua" )
include( "cascade_hooks.lua" )

print( "Loading cascade init..." )

RunConsoleCommand( "sbox_maxprops", "30" )

function GM:InitPostEntity() --Removes original map spawns and creates new ones in the waiting room
	timer.Simple( 3, function()
		for k,v in pairs( ents.FindByClass( "info_player_start" ) ) do
			v:Remove()
		end
		for k,v in ipairs( CASCADE_DEADPOS ) do
			local e = ents.Create( "info_player_start" )
			e:SetPos( v )
			e:SetAngles( Angle( 0, 90, 0 ) )
			e:Spawn()
		end
	end )
end