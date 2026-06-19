--Player functions
local metaPly = FindMetaTable( "Player" )
function metaPly:MakeZombie()
	self:StripWeapons()
	self.IsZombie = true
	self:Notify( 0, 6, "You have been zombified!" )
	timer.Simple( 1, function()
		self:EmitSound( "npc/zombie/zombie_voice_idle"..math.random( 1, 14 )..".wav" )
		self:Give( "weapon_zombie" )
	end )
end

function metaPly:ChangeTeam( new, respawn, silent )
	local old = GetJobInfo( self:Team() )
	local tbl = GetJobInfo( new )
	local model = self:GetNWString( "SetPlayermodel_"..new )
	if !tbl then
		self:Notify( 1, 6, "Error changing jobs. Job does not exist." )
		return
	end
	if new == self:Team() then
		self:Notify( 1, 6, "You are already playing as this job." )
		return
	end
	if team.NumPlayers( new ) >= tbl.Max and tbl.Max > 0 then
		self:Notify( 1, 6, "All slots are filled for this job." )
		return
	end
	if self:GetNWBool( "GMAN_BF" ) then
		self:Notify( 1, 6, "Exit your Gman state before changing jobs." )
		return
	end
	if hook.Run( "HLU_CanChangeJobs", self, new, old ) == false then return end

	self:SetNWString( "RPJob", false )
	self:StripWeapons()
	self:StripAmmo()
	self:SetTeam( new )
	if model == "" then
		self:SetModel( table.Random( tbl.Models ) )
	else
		self:SetModel( model )
	end
	if tbl.Bodygroups then
		for _,v in pairs( tbl.Bodygroups ) do
			self:SetBodygroup( v[1], v[2] )
		end
	end
	if !silent then
		BroadcastNotify( 0, 6, self:Nick().." has changed their job to "..tbl.Name.."." )
	end
	if tbl.SpawnFunction then
		tbl.SpawnFunction( self )
	end
	hook.Run( "PlayerLoadout", self )
	if respawn or ( current == 3 and old and old.Category != tbl.Category ) then
		self:Spawn()
	end
	self.JModFriends = {}
	for k,v in ipairs( player.GetAll() ) do
		if v:GetJobCategory() == self:GetJobCategory() then
			table.insert( self.JModFriends, v )
		end
	end
	hook.Run( "HLU_OnChangeJob", self, new, old )
end

--Overrides default function
function metaPly:DropWeapon()
	local wep = self:GetActiveWeapon()
	if IsValid( wep ) then
		if DROP_BLACKLIST[wep:GetClass()] then
			self:Notify( 1, 6, "You can't drop this weapon." )
			return
		end
		local model = wep:GetWeaponWorldModel() or "models/weapons/w_rif_m4a1.mdl"
		local e = ents.Create( "hlu_dropped_weapon" )
		e:SetPos( self:GetPos() + self:GetForward() * 50 + self:GetUp() * 50 )
		e:SetModel( model )
		e:Spawn()
		e.DroppedClass = wep:GetClass()
		wep:Remove()
	end
end

--Entity functions
local metaEnt = FindMetaTable( "Entity" )
function metaEnt:LightUp( color, pos, style, dist )
	if IsValid( self.ActiveLight ) then
		self.ActiveLight:Remove()
	end
	self.ActiveLight = ents.Create( "light_dynamic" )
	self.ActiveLight:SetPos( pos or self:GetPos() )
	self.ActiveLight:SetOwner( self:GetOwner() )
	self.ActiveLight:SetParent( self )
	self.ActiveLight:SetKeyValue( "_light", color )
	self.ActiveLight:SetKeyValue( "distance", dist or "300" )
	self.ActiveLight:SetKeyValue( "style", style or "0" )
	self.ActiveLight:Spawn()
end

--Misc functions
function BroadcastSound( snd )
	for k,v in ipairs( player.GetHumans() ) do
		v:ConCommand( "play "..snd )
	end
end

function Explode( pos, mag, time, stay )
	local realTime = ( time and time >= 0 ) and time or 0
	local e = ents.Create( "env_explosion" )
	e:SetPos( pos )
	e:Spawn()
	e:SetKeyValue( "iMagnitude", mag or 200 )
	if stay then
		e:SetKeyValue( "spawnflags", "2" )
	end
	timer.Simple( time, function()
		e:Fire( "Explode", 0, 0 )
	end )
    return e
end

function CreateEffect( name, pos )
    local ed = EffectData()
	ed:SetOrigin( pos )
	ed:SetNormal( VectorRand() )
	ed:SetMagnitude( 3 )
	ed:SetScale( 1 )
	ed:SetRadius( 3 )
	util.Effect( name, ed, true, true )
end
