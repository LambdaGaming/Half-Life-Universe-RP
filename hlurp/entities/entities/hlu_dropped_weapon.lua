AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Dropped Weapon"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = false

if SERVER then
	function ENT:Initialize()
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
		
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
		else
			--Create a custom hitbox if the model doesnt have one (from gmod wiki)
			local x0 = -20
			local y0 = -10
			local z0 = -1
			local x1 = 20
			local y1 = 10
			local z1 = 1

			self:PhysicsInitConvex( {
				Vector( x0, y0, z0 ),
				Vector( x0, y0, z1 ),
				Vector( x0, y1, z0 ),
				Vector( x0, y1, z1 ),
				Vector( x1, y0, z0 ),
				Vector( x1, y0, z1 ),
				Vector( x1, y1, z0 ),
				Vector( x1, y1, z1 )
			} )
			self:EnableCustomCollisions( true )

			local phys = self:GetPhysicsObject()
			phys:Wake()
		end

		self.DroppedClass = ""
	end

	function ENT:Use( activator, caller )
		activator:Give( self.DroppedClass )
		self:Remove()
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end
