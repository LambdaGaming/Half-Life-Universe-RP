AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Radioactive Container"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "RadCount" )
end

if SERVER then
	function ENT:Initialize()
		self:SetModel( "models/props_c17/oildrum001.mdl" )
		self:SetMaterial( "models/debug/debugwhite" )
		self:SetColor( Color( 200, 200, 200 ) )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
		self:SetTrigger( true )
		self:PhysWake()
		self.Items = {}
	end

	function ENT:StartTouch( ent )
		local class = ent:GetClass()
		local allowed = {
			radioactive_blob = true,
			organic_matter_radioactive = true,
			xen_iron_radioactive = true,
			crystal_radioactive = true
		}
		if allowed[class] and self:GetRadCount() < 10 then
			table.insert( self.Items, class )
			self:SetRadCount( self:GetRadCount() + 1 )
			ent:Remove()
		end
	end

	function ENT:Use( ply )
		self:EmitSound( "physics/metal/metal_barrel_impact_soft"..math.random( 1, 4 )..".wav" )
		if self:GetRadCount() <= 0 then
			ply:ChatPrint( "Container is empty." )
			return
		end
		local e = ents.Create( self.Items[#self.Items] )
		e:SetPos( self:GetPos() + self:GetRight() * 40 + self:GetUp() * 20 )
		e:Spawn()
		table.remove( self.Items, #self.Items )
		self:SetRadCount( self:GetRadCount() - 1 )
	end
end

if CLIENT then
	surface.CreateFont( "RadContainer", {
		font = "Arial",
		size = 43
	} )

	local triangle = {
		{ x = -100, y = 100 },
		{ x = 0, y = -100 },
		{ x = 100, y = 100 }
	}

	function ENT:Draw()
		self:DrawModel()
		local count = self:GetRadCount()
		local rad = 255 - count * 25.5
		local ang = self:GetAngles()
		local pos = self:GetPos() + self:GetUp() * 26 + self:GetRight() * 14
		ang:RotateAroundAxis( self:GetAngles():Forward(), 90 )
		cam.Start3D2D( pos, ang, 0.1 )
			surface.SetDrawColor( 255, rad, rad )
			draw.NoTexture()
			surface.DrawPoly( triangle )
			draw.SimpleText( count.." / 10", "RadContainer", 0, 10, color_black, 1, 1 )
		cam.End3D2D()
	end
end
