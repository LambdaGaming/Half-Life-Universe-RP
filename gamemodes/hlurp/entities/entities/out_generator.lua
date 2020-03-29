AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Outland Generator"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

function ENT:SpawnFunction( ply, tr, name )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( name )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel( "models/props_wasteland/laundry_washer003.mdl" )
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

if GetGlobalInt( "CurrentGamemode" ) == 3 then --Prevents script errors on other gamemodes that don't have the jobs in the table below
	local rebeljobs = {
		[TEAM_REBEL] = true,
		[TEAM_REBELMEDIC] = true,
		[TEAM_RESISTANCELEADER] = true
	}

	function ENT:Use( caller, activator )
		if self.hascodes and rebeljobs[caller:Team()] then
			HLU_Notify( nil, "The codes for the combine portal were found near a generator! "..caller:Nick().." now has them!", 0, 6, true )
			self.hascodes = nil
			caller.hascodes = true
			return
		end
		HLU_Notify( caller, "You searched around the generator but found nothing of use.", 1, 6 )
	end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end