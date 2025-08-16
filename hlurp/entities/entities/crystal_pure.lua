AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Pure Crystal"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

if SERVER then
	function ENT:Initialize()
		--Hacky fix for the pocket not saving the crystal type
		if self:GetModel() == "models/error.mdl" then
			local rand = math.random( 1, 2 )
			if rand == 1 then
				self:SetModel( "models/props/xenprops/crystal2.mdl" )
				self:SetNWString( "CType", "C17" )
			else
				self:SetModel( "models/props/xenprops/crystal1.mdl" )
				self:SetNWString( "CType", "C24" )
			end
		else
			if self:GetModel() == "models/props/xenprops/crystal2.mdl" then
				self:SetNWString( "CType", "C17" )
			else
				self:SetNWString( "CType", "C24" )
			end
		end
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
		self:PhysWake()
	end

	function ENT:Use( ply )
		HLU_Notify( ply, "This is the purest sample we've seen yet! Take it to the AMS in Sector C so it can be tested!", 0, 6 )
	end
end

if CLIENT then
	local offset = Vector( 0, 0, 30 )
    function ENT:Draw()
		local type = self:GetNWString( "CType", "Error" )
		self:DrawModel()
		self:DrawOverheadText( "Sample "..type, offset )
    end
end
