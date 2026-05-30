AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Combine Science Locker"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "Keys" )
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
	self:PhysWake()
end

local ScienceItems = {
	["Manhack Metrocop"] = function( ply, ent )
		if RestrictedJobs[TEAM_METROCOPMANHACK] then
			RestrictedJobs[TEAM_METROCOPMANHACK] = false
			BroadcastNotify( 0, 6, "The Combine has researched the Manhack Civil Protection job!" )
			ent:SetKeys( ent:GetKeys() - 1 )
			return
		end
		ply:Notify( 1, 6, "The Manhack Civil Protection job was already researched. Please choose another." )
	end,
	["Cremator"] = function( ply, ent )
		if RestrictedJobs[TEAM_CREMATOR] then
			RestrictedJobs[TEAM_CREMATOR] = false
			BroadcastNotify( 0, 6, "The Combine has researched the Cremator job!" )
			ent:SetKeys( ent:GetKeys() - 1 )
			return
		end
		ply:Notify( 1, 6, "The Cremator job was already researched. Please choose another." )
	end,
	["Overwatch Elite"] = function( ply, ent )
		if RestrictedJobs[TEAM_COMBINEELITE] then
			RestrictedJobs[TEAM_COMBINEELITE] = false
			BroadcastNotify( 0, 6, "The Combine has researched the Overwatch Elite job!" )
			ent:SetKeys( ent:GetKeys() - 1 )
			return
		end
		ply:Notify( 1, 6, "The Overwatch Elite job was already researched. Please choose another." )
	end,
	["Overwatch Shotgun Guard"] = function( ply, ent )
		if RestrictedJobs[TEAM_COMBINEGUARDSHOTGUN] then
			RestrictedJobs[TEAM_COMBINEGUARDSHOTGUN] = false
			BroadcastNotify( 0, 6, "The Combine has researched the Overwatch Shotgun Guard job!" )
			ent:SetKeys( ent:GetKeys() - 1 )
			return
		end
		ply:Notify( 1, 6, "The Overwatch Shotgun Guard job was already researched. Please choose another." )
	end,
	["Gluon Gun"] = function( ply, ent )
		if ply:HasWeapon( "weapon_hlmmod_c_egon" ) then
			ply:Notify( 1, 6, "You already have a Gluon Gun. Drop it to research another." )
			return
		end
		ply:Give( "weapon_hlmmod_c_egon" )
		ply:Notify( 0, 6, "You have researched the Gluon Gun!" )
		ent:SetKeys( ent:GetKeys() - 1 )
	end,
	["Tau Cannon"] = function( ply, ent )
		if ply:HasWeapon( "weapon_hlmmod_c_gauss" ) then
			ply:Notify( 1, 6, "You already have a Tau Cannon. Drop it to research another." )
			return
		end
		ply:Give( "weapon_hlmmod_c_gauss" )
		ply:Notify( 0, 6, "You have researched the Tau Cannon!" )
		ent:SetKeys( ent:GetKeys() - 1 )
	end
}

if SERVER then
	util.AddNetworkString( "ScienceLocker" )
	function ENT:Use( ply )
		if ply:Team() != TEAM_SCIENTIST then
			ply:Notify( 0, 6, "Only scientists can access this locker!" )
			return
		end
		for k,v in ipairs( ents.FindInSphere( self:GetPos(), 100 ) ) do
			if v:GetClass() == "locker_key" then
				v:Remove()
				self:SetKeys( self:GetKeys() + 1 )
				break
			end
		end
		if self:GetKeys() > 0 then
			net.Start( "ScienceLocker" )
			net.WriteEntity( self )
			net.Send( ply )
			return
		end
		ply:Notify( 1, 6, "Please insert a key to open the locker." )
	end
	
	function ENT:StartTouch( ent )
		if ent:GetClass() == "locker_key" then
			ent:Remove()
			self:SetKeys( self:GetKeys() + 1 )
		end
	end

	net.Receive( "ScienceLocker", function( len, ply )
		local ent = net.ReadEntity()
		local key = net.ReadString()
		ScienceItems[key]( ply, ent )
	end )
end

if CLIENT then
	local background = Color( 49, 53, 61, 255 )
	local button = Color( 230, 93, 80, 200 )
	net.Receive( "ScienceLocker", function()
		local ent = net.ReadEntity()
		local ply = LocalPlayer()
		local main = vgui.Create( "DFrame" )
		main:SetTitle( "Select an item to research:" )
		main:SetSize( 300, 300 )
		main:Center()
		main:MakePopup()
		main.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, background )
		end

		local listframe = vgui.Create( "DScrollPanel", main )
		listframe:Dock( FILL )
		for k,v in pairs( ScienceItems ) do
			local buttons = vgui.Create( "DButton", listframe )
			buttons:SetText( k )
			buttons:SetTextColor( color_white )
			buttons:SetFont( "JobTitle" )
			buttons:Dock( TOP )
			buttons:DockMargin( 0, 0, 0, 20 )
			buttons.Paint = function( self, w, h )
				surface.SetDrawColor( button )
				surface.DrawRect( 0, 0, w, h )
			end
			buttons.DoClick = function()
				net.Start( "ScienceLocker" )
				net.WriteEntity( ent )
				net.WriteString( k )
				net.SendToServer()
				main:Close()
			end
		end
	end )
end
