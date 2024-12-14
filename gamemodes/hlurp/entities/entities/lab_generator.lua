AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Electric Generator"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

if SERVER then
	function ENT:Initialize()
		sound.Add( {
			name = "lab_generator_idle",
			channel = CHAN_STATIC,
			volume = 1.0,
			level = 60,
			pitch = { 95, 110 },
			sound = "ambient/machines/engine1.wav"
		} )

		self:SetModel("models/props/portedprops1/battery.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		local phys = self:GetPhysicsObject()
		phys:Wake()

		self:EmitSound( "lab_generator_idle" )
	end

	function ENT:OnRemove()
		self:StopSound( "lab_generator_idle" )
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end
