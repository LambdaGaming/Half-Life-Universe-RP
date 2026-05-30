AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Portal Event Fixer"
ENT.Author = "OPGman"
ENT.Spawnable = false

if CLIENT then return end

function ENT:Initialize()
    self:SetModel( "models/props/hl10props/amsmachine02.mdl" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetTrigger( true )
	self:PhysWake()
	self:SetHealth( 0 )
	self:SetMaxHealth( 100 )
	self.broke = false
end

function ENT:Use( caller, activator )
	if self.broke then
		if caller:Team() != TEAM_SERVICE then
			HLU_Notify( caller, "The portal is broken. Use your wrench to attempt repairs.", 1, 6 )
		else
			HLU_Notify( caller, "The portal is broken. Contact a custodian to have it fixed.", 1, 6 )
		end
	else
		HLU_Notify( caller, "You visually inspect the portal but find nothing out of the ordinary.", 0, 6 )
	end
end

function ENT:Think()
	local rand = math.random( 1, 8 )
	if self.broke and rand == 7 then
		local pos = self:GetPos() + self:GetUp() * math.random( 10, 25 )
		CreateEffect( "Sparks", pos )
		self:EmitSound( "ambient/energy/spark"..math.random( 1, 6 )..".wav" )
	end
end

function ENT:OnTakeDamage( dmg )
	if self.broke then
		local ply = dmg:GetAttacker()
		if ply:GetActiveWeapon():GetClass() == "weapon_hlof_pipewrench_ch" then
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
