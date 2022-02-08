AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Tram Controller"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

function ENT:SpawnFunction( ply, tr, name )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal
	local ent = ents.Create( name )
	ent:SetPos( SpawnPos + ent:GetUp() * 10 )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel( "models/props/reqprops/supercomputer.mdl" )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	if SERVER then
		self:SetUseType( SIMPLE_USE )
	end
	self.tramenabled = false
end

function ENT:Use( caller, activator )
	if GetGlobalInt( "PreRound" ) == 0 or GetGlobalInt( "MainRound" ) == 0 then
		Error( "Something went wrong. Tram tried to be enabled but the round didnt start." )
		return
	end
	if !self.tramenabled then
		for k,v in pairs( ents.FindByClass( "func_button" ) ) do
			if v:EntIndex() == 1273 then
				v:Fire( "PressOut" )
			end
		end
		for a,b in ipairs( player.GetAll() ) do
			b:ChatPrint( "The transit system has been activated!" )
		end
		self.tramenabled = true
		self:EmitSound( "buttons/button18.wav" )
	else
		for k,v in pairs( ents.FindByClass( "func_button" ) ) do
			if v:EntIndex() == 1273 then
				v:Fire( "PressIn" )
			end
		end
		for a,b in ipairs( player.GetAll() ) do
			b:ChatPrint( "The transit system has been disabled!" )
		end
		self.tramenabled = false
		self:EmitSound( "buttons/button10.wav" )
	end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end