AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Trash Compactor"
ENT.Author = "OPGman"
ENT.Category = "HLU RP"
ENT.Spawnable = true
ENT.AdminOnly = true

if CLIENT then return end

function ENT:Initialize()
	self:SetModel( "models/props/halflifeoneprops4/radmachine.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetTrigger( true )
	self:SetUseType( SIMPLE_USE )
	self:PhysWake()
end

function ENT:Use( ply )
	local totalbags = 0
	for k,v in ipairs( ents.FindInSphere( self:GetPos(), 500 ) ) do
		if v:GetClass() == "trash_ent" then
			v:Remove()
			totalbags = totalbags + 1
		end
	end
	if totalbags > 0 then
		local totalmoney = totalbags * 10
		timer.Simple( 4.4, function()
			self:EmitSound( "ambient/energy/weld2.wav" )
			self:LightUp( "255 255 0 255", self:GetPos(), "0", "1000" )
		end )
		timer.Simple( 5, function() self.ActiveLight:Remove() end )
		self:EmitSound( "HL1/ambience/particle_suck2.wav" )
		ply:AddFunds( totalmoney )
		HLU_Notify( ply, "You have made $"..totalmoney.." disposing of "..totalbags.." trash bag(s).", 0, 6 )
	end
end
