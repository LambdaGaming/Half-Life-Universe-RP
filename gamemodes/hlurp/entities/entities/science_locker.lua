AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Combine Science Locker"
ENT.Author = "Lambda Gaming"
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
    local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

local ScienceItems = {
	["Manhack Metrocop"] = function( ply, ent )
		if RestrictedJobs[TEAM_METROCOPMANHACK] then
			RestrictedJobs[TEAM_METROCOPMANHACK] = false
			HLU_Notify( nil, "The Combine has researched the Manhack Civil Protection job!", 0, 6, true )
			ent:SetKeys( ent:GetKeys() - 1 )
			return
		end
		HLU_Notify( ply, "The Manhack Civil Protection job was already researched. Please choose another.", 1, 6 )
	end,
	["Cremator"] = function( ply, ent )
		if RestrictedJobs[TEAM_CREMATOR] then
			RestrictedJobs[TEAM_CREMATOR] = false
			HLU_Notify( nil, "The Combine has researched the Cremator job!", 0, 6, true )
			ent:SetKeys( ent:GetKeys() - 1 )
			return
		end
		HLU_Notify( ply, "The Cremator job was already researched. Please choose another.", 1, 6 )
	end,
	["Overwatch Elite"] = function( ply, ent )
		if RestrictedJobs[TEAM_COMBINEELITE] then
			RestrictedJobs[TEAM_COMBINEELITE] = false
			HLU_Notify( nil, "The Combine has researched the Overwatch Elite job!", 0, 6, true )
			ent:SetKeys( ent:GetKeys() - 1 )
			return
		end
		HLU_Notify( ply, "The Overwatch Elite job was already researched. Please choose another.", 1, 6 )
	end,
	["Overwatch Shotgun Guard"] = function( ply, ent )
		if RestrictedJobs[TEAM_COMBINEGUARDSHOTGUN] then
			RestrictedJobs[TEAM_COMBINEGUARDSHOTGUN] = false
			HLU_Notify( nil, "The Combine has researched the Overwatch Shotgun Guard job!", 0, 6, true )
			ent:SetKeys( ent:GetKeys() - 1 )
			return
		end
		HLU_Notify( ply, "The Overwatch Shotgun Guard job was already researched. Please choose another.", 1, 6 )
	end,
	["Gluon Gun"] = function( ply, ent )
		if ply:HasWeapon( "weapon_egon" ) then
			HLU_Notify( ply, "You already have a Gluon Gun. Drop it to research another.", 1, 6 )
			return
		end
		ply:Give( "weapon_egon" )
		HLU_Notify( ply, "You have researched the Gluon Gun!", 0, 6 )
		ent:SetKeys( ent:GetKeys() - 1 )
	end,
	["Tau Cannon"] = function( ply, ent )
		if ply:HasWeapon( "weapon_gauss" ) then
			HLU_Notify( ply, "You already have a Tau Cannon. Drop it to research another.", 1, 6 )
			return
		end
		ply:Give( "weapon_gauss" )
		HLU_Notify( ply, "You have researched the Tau Cannon!", 0, 6 )
		ent:SetKeys( ent:GetKeys() - 1 )
	end
}

if SERVER then
	util.AddNetworkString( "ScienceLocker" )
	function ENT:Use( ply )
		if ply:Team() != TEAM_SCIENTIST then
			HLU_Notify( ply, "Only scientists can access this locker!", 0, 6 )
			return
		end
		for k,v in pairs( ents.FindInSphere( self:GetPos(), 100 ) ) do
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
		HLU_Notify( ply, "Please insert a key to open the locker.", 1, 6 )
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
    function ENT:Draw()
        self:DrawModel()
    end

	local background = Color( 49, 53, 61, 255 )
	local button = Color( 230, 93, 80, 200 )
	net.Receive( "ScienceLocker", function()
		local ent = net.ReadEntity()
		local ply = LocalPlayer()
		local mainframe = vgui.Create( "DFrame" )
		mainframe:SetTitle( "Select an item to research:" )
		mainframe:SetSize( 300, 300 )
		mainframe:Center()
		mainframe:MakePopup()
		mainframe.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, background )
		end

		local listframe = vgui.Create( "DScrollPanel", mainframe )
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
				mainframe:Close()
			end
		end
	end )
end
