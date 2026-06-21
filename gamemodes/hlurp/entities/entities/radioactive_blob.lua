AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Radioactive Blob"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

if SERVER then
	function ENT:Initialize()
		self:SetModel( "models/props_phx/gibs/flakgib1.mdl" )
		self:SetMaterial( "models/props_c17/FurnitureMetal001a" )
		self:SetRenderMode( RENDERMODE_TRANSALPHA )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
		self:PhysWake()
	end

	local nextGeiger = 0
	local nextHurt = 0
	local immune = {
		[TEAM_BIO] = true,
		[TEAM_SURVEYBOSS] = true,
		[TEAM_SURVEY] = true
	}
	function ENT:Think()
		if self.IsTicking and nextGeiger < CurTime() then
			self:EmitSound( "player/geiger"..math.random( 1, 3 )..".wav" )
			nextGeiger = nextGeiger + math.random( 1, 3 )
		end
		for k,v in ipairs( ents.FindInSphere( self:GetPos(), 200 ) ) do
			if v:IsPlayer() and nextHurt < CurTime() and !immune[v:Team()] then
				v:TakeDamage( math.random( 2, 10 ) )
				v:EmitSound( "player/geiger"..math.random( 1, 3 )..".wav" )
				nextHurt = CurTime() + 1
			end
		end
		self:NextThink( CurTime() + 0.5 )
		return true
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
		local wave = 95 * ( 1 + math.sin( CurTime() * 1 ) )
		local color = Color( 0, wave, 100 )
		self:SetColor( color )
	end

	hook.Add( "PreDrawHalos", "RadioactiveBlobHalo", function()
		local wave = 55 * ( 1 + math.sin( CurTime() * 1 ) )
		local color = Color( 0, wave, 100 )
		local blobs = ents.FindByClass( "radioactive_blob" )
		halo.Add( blobs, color, 10, 10, 2 )
	end )
end
