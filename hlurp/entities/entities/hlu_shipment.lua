AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Weapon Box"
ENT.Author = "OPGman"
ENT.Spawnable = false

if SERVER then
	function ENT:Initialize()
		self:SetModel( "models/Items/item_item_crate.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
		self:SetNWString( "WepName", "None" )
		self:SetNWInt( "NumWeapons", 10 )
		self:PhysWake()
	end

	function ENT:Use( ply )
		local num = self:GetNWInt( "NumWeapons" )
		if !self.WepClass then
			HLU_Notify( ply, "This weapon box hasn't been properly initialized. Weapons will not spawn from it.", 1, 6 )
			return
		end
		if ply:HasWeapon( self.WepClass ) then
			HLU_Notify( ply, "You already have this weapon.", 1, 6 )
			return
		end
		ply:Give( self.WepClass )
		self:SetNWInt( "NumWeapons", num - 1 )
		if num <= 0 then
			self:Remove()
		end
	end
end

if CLIENT then
	surface.CreateFont( "HLU_BoxFont", {
		font = "Arial",
		size = 30
	} )
	function ENT:Draw()
		self:DrawModel()
		local plyShootPos = LocalPlayer():GetShootPos()
		if self:GetPos():DistToSqr( plyShootPos ) < 562500 then
			local numweapons = self:GetNWInt( "NumWeapons" )
			local wepname = self:GetNWString( "WepName" )
			surface.SetFont( "HLU_BoxFont" )
			local title = wepname.." Weapon Box"
			local title2 = "Amount: "..numweapons
			local ang = self:GetAngles()
			ang:RotateAroundAxis( self:GetAngles():Right(), 270 )
			ang:RotateAroundAxis( self:GetAngles():Forward(), 90 )
			local pos = self:GetPos() + ang:Right() * -5 + ang:Up() * 17 + ang:Forward() * -25
			cam.Start3D2D( pos, ang, 0.1 )
				draw.RoundedBox( 0, 60, -120, 350, 100, color_theme )
				draw.SimpleText( title, "HLU_BoxFont", 240, -100, color_white, 1, 1 )
				draw.SimpleText( title2, "HLU_BoxFont", 240, -70, color_white, 1, 1 )
			cam.End3D2D()
		end
	end
end
