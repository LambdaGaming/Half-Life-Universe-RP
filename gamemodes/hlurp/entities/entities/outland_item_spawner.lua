AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Outland Item Spawner"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

if SERVER then
	function ENT:Initialize()
		self:SetModel( "models/props_debris/concrete_spawnplug001a.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )

		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
		end
		
		local items = {
			"ent_jack_gmod_ezammo",
			"ent_jack_gmod_ezbattery",
			"ent_jack_gmod_eznutrients",
			"ent_jack_gmod_ezmedsupplies"
		}
		
		timer.Create( "ItemSpawner"..self:EntIndex(), 180, 0, function()
			for k,v in pairs( ents.FindInSphere( self:GetPos(), 200 ) ) do
				if table.HasValue( items, v:GetClass() ) then
					return
				end
			end
			local spawnitem = ents.Create( table.Random( items ) )
			spawnitem:SetPos( self:GetPos() + Vector( 0, 0, 20 ) )
			spawnitem:Spawn()
		end )
	end
end

function ENT:OnRemove()
	timer.Remove( "ItemSpawner"..self:EntIndex() )
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end
