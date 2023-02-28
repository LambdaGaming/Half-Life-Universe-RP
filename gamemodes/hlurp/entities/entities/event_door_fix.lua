AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Tram Event Fixer"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = false

function ENT:Initialize()
	self:SetModel( "models/props/hazardous/generator.mdl" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	if SERVER then
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
	end
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self.broke = false
end

if SERVER then
	function ENT:Use( caller, activator )
		if self.broke then
			if caller:Team() == TEAM_SERVICE then
				self:EmitSound( "vehicles/Airboat/fan_motor_start1.wav" )
				TramFix()
				self.broke = false
				HLU_Notify( caller, "You pull the cord and the generator starts right up. (+200)", 0, 6 )
				caller:AddFunds( 200 )
			else
				HLU_Notify( caller, "The generator has stalled. Contact a service official to have it fixed.", 1, 6 )
			end
		else
			HLU_Notify( caller, "You listen to the generator. It sounds like it's running normally.", 0, 6 )
		end
	end
end
