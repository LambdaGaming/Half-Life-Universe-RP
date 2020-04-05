
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Combine Science Locker"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Science Locker"

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
    self:SetModel( "models/props_c17/Lockers001a.mdl" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetMaterial( "models/props_combine/metal_combinebridge001" )
	if SERVER then
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
	end
 
    local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end

	self:SetNWBool( "HasKey", false )
end

local function ChooseResearch( ply )
	local rand = math.random( 1, 6 )
	if rand == 1 then
		if !RestrictedJobs[TEAM_METROCOPMANHACK] then ChooseResearch( ply ) return end
		RestrictedJobs[TEAM_METROCOPMANHACK] = false
		HLU_Notify( nil, "The Combine has researched the Manhack Civil Protection job!", 0, 6, true )
	elseif rand == 2 then
		if !RestrictedJobs[TEAM_CREMATOR] then ChooseResearch( ply ) return end
		RestrictedJobs[TEAM_CREMATOR] = false
		HLU_Notify( nil, "The Combine has researched the Cremator job!", 0, 6, true )
	elseif rand == 3 then
		if !RestrictedJobs[TEAM_COMBINEELITE] then ChooseResearch( ply ) return end
		RestrictedJobs[TEAM_COMBINEELITE] = false
		HLU_Notify( nil, "The Combine has researched the Overwatch Elite job!", 0, 6, true )
	elseif rand == 4 then
		if !RestrictedJobs[TEAM_COMBINEGUARDSHOTGUN] then ChooseResearch( ply ) return end
		RestrictedJobs[TEAM_COMBINEGUARDSHOTGUN] = false
		HLU_Notify( nil, "The Combine has researched the Overwatch Shotgun Guard job!", 0, 6, true )
	elseif rand == 5 then
		if ply:HasWeapon( "weapon_egon" ) then ChooseResearch( ply ) return end
		ply:Give( "weapon_egon" )
		HLU_Notify( ply, "You have researched the Gluon Gun!", 0, 6 )
	else
		if ply:HasWeapon( "weapon_gauss" ) then ChooseResearch( ply ) return end
		ply:Give( "weapon_gauss" )
		HLU_Notify( ply, "You have researched the Tau Cannon!", 0, 6 )
	end
end

function ENT:Use( activator, caller )
	if activator:Team() != TEAM_SCIENTIST then
		HLU_Notify( activator, "Only scientists can access this locker!", 0, 6 )
		return
	end
	for k,v in pairs( ents.FindInSphere( self:GetPos(), 100 ) ) do
		if v:GetClass() == "locker_key" then
			v:Remove()
			self:SetNWBool( "HasKey", true )
			break
		end
	end
	if self:GetNWBool( "HasKey" ) then
		if !pcall( ChooseResearch, activator ) then --Prevents stack overflows if all items have been researched
			HLU_Notify( activator, "All items have been researched!", 0, 6 )
			return
		end
		self:SetNWBool( "HasKey", false )
	else
		HLU_Notify( activator, "You need to craft a key to open the locker! Ask the Earth Administrator for a combine crafting table.", 1, 6 )
	end
end

function ENT:StartTouch( ent )
	if ent:GetClass() == "locker_key" then
		ent:Remove()
		self:SetNWBool( "HasKey", true )
	end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end