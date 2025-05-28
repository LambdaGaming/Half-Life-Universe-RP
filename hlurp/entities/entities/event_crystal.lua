AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Crystal Event"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = false

local models = {
	"models/props/bm/crystalstrappedroom2.mdl",
	"models/props/bm/crystalstrappedroom3.mdl",
	"models/props/bm/crystalstrappedroom4.mdl",
	"models/props/bm/crystalstrappedroom5.mdl",
	"models/props/xenprops/crystal.mdl",
	"models/props/xenprops/crystal1.mdl",
	"models/props/xenprops/crystal2.mdl"
}

function ENT:Initialize()
    self:SetModel( table.Random( models ) )
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
end

function ENT:Use( caller, activator )
	if caller:Team() == TEAM_SURVEYBOSS or caller:Team() == TEAM_SURVEY then
		caller:AddFunds( 200 )
		HLU_Notify( caller, "You have been awarded $200 for securing the lost crystal.", 0, 6 )
		SecureCrystal()
		self:Remove()
	else
		HLU_Notify( caller, "The crystal appears as if it doesn't belong here. Contacting the survey team would be a good idea.", 0, 6 )
	end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end