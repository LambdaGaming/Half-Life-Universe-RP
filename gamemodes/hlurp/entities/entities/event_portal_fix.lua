AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Portal Event Fixer"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = false

function ENT:Initialize()
    self:SetModel( "models/props/hl10props/amsmachine02.mdl" )
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetTrigger( true )
	end
 
    local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	
	if SERVER then
		self:SetHealth( 0 )
		self:SetMaxHealth( 100 )
	end
	self.broke = false
end

function ENT:Use( caller, activator )
	if self.broke then
		if caller:Team() != TEAM_SERVICE then
			HLU_Notify( caller, "The portal is broken. Use your wrench to attempt repairs.", 1, 6 )
		else
			HLU_Notify( caller, "The portal is broken. Contact a service official to have it fixed.", 1, 6 )
		end
	else
		HLU_Notify( caller, "You visually inspect the portal but find nothing out of the ordinary.", 0, 6 )
	end
end

function ENT:Think()
	if self.broke then
		if math.random( 1, 8 ) == 7 then
			local effectdata = EffectData()
			effectdata:SetOrigin( self:GetPos() + self:GetUp() * math.random( 10, 25 ) )
			effectdata:SetNormal( VectorRand() )
			effectdata:SetMagnitude( 3 )
			effectdata:SetScale( 1 )
			effectdata:SetRadius( 3 )
			util.Effect( "Sparks", effectdata, true, true )
			self:EmitSound( "ambient/energy/spark"..math.random( 1, 6 )..".wav" )
		end
	end
end

function ENT:OnTakeDamage( dmg )
	if self.broke then
		local ply = dmg:GetAttacker()
		if ply:GetActiveWeapon():GetClass() == "weapon_pipewrench" then
			self:SetHealth( self:Health() + 10 )
			ply:ChatPrint( "Portal repairs: "..self:Health().."%" )
			if self:Health() >= 100 then
				self.broke = false
				PortalFix()
				self:SetHealth( 0 )
				HLU_Notify( ply, "You rewire a few circuits and reboot the system, it appears to be working now. (+500)", 0, 6 )
				ply:AddFunds( 500 )
			end
		end
	end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end