AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Crystal Event"
ENT.Author = "OPGman"
ENT.Spawnable = false

if CLIENT then return end

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
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:PhysWake()
end

function ENT:Use( ply )
	if ply:Team() == TEAM_SURVEYBOSS or ply:Team() == TEAM_SURVEY then
		ply:AddFunds( 200 )
		HLU_Notify( ply, "You have been awarded $200 for securing the lost crystal.", 0, 6 )
		SecureCrystal()
		self:Remove()
	else
		HLU_Notify( ply, "The crystal appears as if it doesn't belong here. Contacting the survey team would be a good idea.", 0, 6 )
	end
end
