AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Combine Base Central Core"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

function ENT:Initialize()
	self:SetModel( "models/props_combine/combine_monitorbay.mdl" )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	if SERVER then
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
		self.Destroyed = false
		self:SetHealth( 5000 )
	end
end

if SERVER then
	function ENT:Use( ply )
		if ply:GetJobCategory() == "Combine" then
			HLU_Notify( ply, "This is the base's central core. It must be protected from the rebels at all costs.", 0, 6 )
		else
			HLU_Notify( ply, "Damage the central core to destroy it and cripple the Combine!", 0, 6 )
		end
	end

	function ENT:Destroy()
		self.Destroyed = true
		self:SetColor( Color( 30, 30, 30 ) )
		local e = ents.Create( "env_explosion" )
		e:SetPos( self:GetPos() )
		e:Spawn()
		e:Fire( "Explode" )
		self:Remove()
		timer.Simple( 120, function() ents.GetMapCreatedEntity( 2677 ):Fire( "Press" ) end )
		HLU_ChatNotifySystem( "Outland RP", color_green, "Combine base infilatrated......2 minutes until portal closes." )
		HLU_Notify( nil, "Combine base infilatrated......2 minutes until portal closes.", 0, 10, true )
		timer.Create( "KickTimer", 150, 1, function()
			for k,v in ipairs( player.GetAll() ) do
				v:Kick( "\n--END OF SESSION--\nBase destruction ending chosen, server shutting down.\nThanks for playing!" )
			end
		end )
	end

	function ENT:OnTakeDamage( dmg )
		local hp = self:Health()
		if dmg:IsDamageType( DMG_BLAST ) then
			self:SetHealth( hp - 500 )
		else
			self:SetHealth( hp - 2 )
		end
		if self:Health() <= 0 and !self.Destroyed then
			self:Destroy()
		end
	end
else
	local offset = Vector( -6, 0, -30 )
	function ENT:Draw()
		self:DrawModel()
		self:DrawNPCText( "Central Core", offset )
	end
end
