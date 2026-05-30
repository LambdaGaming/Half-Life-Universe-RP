AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Cascade Escape Truck"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

if CLIENT then return end

function ENT:Initialize()
    self:SetModel( "models/decay/vehicles/truck_research.mdl" )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:PhysWake()
end

function ENT:Use( ply )
	if ply:GetJobCategory() == "Military" then
		ply:Notify( 0, 6, "Lead Black Mesa staff to this truck to recruit them into the HECU." )
		return
	end
	if team.NumPlayers( TEAM_MARINEBOSS ) == 0 then
		ply:ChangeTeam( TEAM_MARINEBOSS, false, true )
		ply:Notify( 0, 6, "You have successfully escaped the facility! You are now the HECU Captain." )
		return
	end
	ply:ChangeTeam( TEAM_MARINE, false, true )
	ply:Notify( 0, 6, "You have successfully escaped the facility! You are now an HECU Marine." )
end
