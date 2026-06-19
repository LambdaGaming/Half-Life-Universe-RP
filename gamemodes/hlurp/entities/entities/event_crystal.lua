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
		ply:Notify( 0, 6, "You have been awarded $200 for securing the lost crystal." )
		SecureCrystal()
		self:Remove()
	else
		ply:Notify( 0, 6, "This crystal shouldn't be here. You should probably contact the survey team." )
	end
end
