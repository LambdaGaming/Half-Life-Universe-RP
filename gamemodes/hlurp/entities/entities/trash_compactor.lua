AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Trash Compactor"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

if SERVER then
	function ENT:SpawnFunction( ply, tr, name )
		if !tr.Hit then return end
		local SpawnPos = tr.HitPos + tr.HitNormal * 1
		local ent = ents.Create( name )
		ent:SetPos( SpawnPos )
		ent:Spawn()
		ent:Activate()
		return ent
	end

	function ENT:Initialize()
		self:SetModel( "models/props/halflifeoneprops4/radmachine.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetTrigger( true )
		self:SetUseType( SIMPLE_USE )
	
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
		end
	end

	function ENT:Use( activator, caller )
		local totalbags = 0
		for k,v in pairs( ents.FindInSphere( self:GetPos(), 500 ) ) do
			if v:GetClass() == "trash_ent" then
				v:Remove()
				totalbags = totalbags + 1
			end
		end
		if totalbags > 0 then
			local totalmoney = totalbags * 10
			timer.Simple( 4.4, function()
				self:EmitSound( "ambient/energy/weld2.wav" )
				self.greenlight = ents.Create( "light_dynamic" )
				self.greenlight:SetPos( self:GetPos() )
				self.greenlight:SetParent(self)
				self.greenlight:SetKeyValue( "_light", "255 255 0 255" )  
				self.greenlight:SetKeyValue( "distance", "1000" )
				self.greenlight:SetKeyValue( "brightness", "2" )
				self.greenlight:Spawn()
			end )
			timer.Simple( 5, function() self.greenlight:Remove() end )
			self:EmitSound( "HL1/ambience/particle_suck2.wav" )
			ChangeBudget( totalmoney )
			HLU_Notify( caller, "You have made $"..totalmoney.." disposing of "..totalbags.." trash bag(s).", 0, 6 )
		end
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end