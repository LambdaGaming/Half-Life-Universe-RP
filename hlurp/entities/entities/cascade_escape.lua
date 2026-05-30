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
		HLU_Notify( ply, "Lead Black Mesa staff to this truck to recruit them into the HECU.", 0, 6 )
		return
	end
	if team.NumPlayers( TEAM_MARINEBOSS ) == 0 then
		ply:ChangeTeam( TEAM_MARINEBOSS, false, true )
		HLU_Notify( ply, "You have successfully escaped the facility! You are now the HECU Captain.", 0, 6 )
		return
	end
	ply:ChangeTeam( TEAM_MARINE, false, true )
	HLU_Notify( ply, "You have successfully escaped the facility! You are now an HECU Marine.", 0, 6 )
end
