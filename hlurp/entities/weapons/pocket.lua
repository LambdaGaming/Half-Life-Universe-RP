--Modified pocket originally from DarkRP

AddCSLuaFile()

SWEP.PrintName = "Pocket"
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.Base = "weapon_base"
SWEP.Author = "DarkRP Developers"
SWEP.Instructions = "Left click to pick up\nRight click to drop\nReload to open the menu"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.IsDarkRPPocket = true
SWEP.IconLetter = ""
SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix = "rpg"
SWEP.WorldModel = ""
SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Category = "DarkRP"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

if SERVER then
	local meta = FindMetaTable( "Player" )

	-- workaround: GetNetworkVars doesn't give entities because the /duplicator/ doesn't want to save entities
	local function getDTVars(ent)
		if !ent.GetNetworkVars then return nil end
		local name, value = debug.getupvalue( ent.GetNetworkVars, 1 )
		if name ~= "datatable" then
			ErrorNoHalt( "Warning: Datatable cannot be stored properly in pocket. Tell a developer!" )
		end

		local res = {}
		for k,v in pairs( value ) do
			res[k] = v.GetFunc( ent, v.index )
		end
		return res
	end

	local function serialize( ent )
		local serialized = duplicator.CopyEntTable( ent )
		serialized.DT = getDTVars( ent )
		return serialized
	end

	local function deserialize(ply, item)
		local ent = duplicator.CreateEntityFromTable( ply, item )
		if ent:IsWeapon() and ent.Weapon ~= nil and not ent.Weapon:IsValid() then ent.Weapon = ent end
		if ent.Entity ~= nil and not ent.Entity:IsValid() then ent.Entity = ent end

		local trace = {}
		trace.start = ply:EyePos()
		trace.endpos = trace.start + ply:GetAimVector() * 85
		trace.filter = ply

		local tr = util.TraceLine( trace )
		ent:SetPos( tr.HitPos )
		timer.Simple( 0, function() ent:PhysWake() end )
		return ent
	end

	util.AddNetworkString( "DarkRP_Pocket" )
	local function sendPocketItems( ply )
		net.Start( "DarkRP_Pocket" )
		net.WriteTable( ply:getPocketItems() )
		net.Send( ply )
	end

	--Interface functions
	function meta:addPocketItem( ent )
		if !IsValid( ent ) or ent.USED then return end

		-- This item cannot be used until it has been removed
		ent.USED = true
		local serialized = serialize( ent )
		hook.Call( "onPocketItemAdded", nil, self, ent, serialized )
		ent.IsPocketing = true
		ent:Remove()
		self.darkRPPocket = self.darkRPPocket or {}

		local id = table.insert( self.darkRPPocket, serialized )
		sendPocketItems( self )
		return id
	end

	function meta:removePocketItem( item )
		if !self.darkRPPocket or !self.darkRPPocket[item] then return end
		hook.Call( "onPocketItemRemoved", nil, self, item )
		self.darkRPPocket[item] = nil
		sendPocketItems( self )
	end

	function meta:dropPocketItem( item )
		if !self.darkRPPocket or !self.darkRPPocket[item] then return end

		local id = self.darkRPPocket[item]
		local ent = deserialize( self, id )

		-- reset USED status
		ent.USED = nil
		hook.Call( "onPocketItemDropped", nil, self, ent, item, id )
		self:removePocketItem( item )
		return ent
	end

	-- serverside implementation
	function meta:getPocketItems()
		self.darkRPPocket = self.darkRPPocket or {}
		local res = {}
		for k,v in pairs( self.darkRPPocket ) do
			res[k] = {
				model = v.Model,
				class = v.Class
			}
		end
		return res
	end

	--Commands
	util.AddNetworkString( "DarkRP_spawnPocket" )
	net.Receive( "DarkRP_spawnPocket", function( len, ply )
		local item = net.ReadFloat()
		if not ply.darkRPPocket or not ply.darkRPPocket[item] then return end
		local canPickup, message = hook.Call( "canDropPocketItem", nil, ply, item, ply.darkRPPocket[item] )
		if canPickup == false then
			if message then ply:Notify( 1, 6, message ) end
			sendPocketItems( ply )
			return
		end
		ply:dropPocketItem( item )
	end )

	--Hooks
	function GAMEMODE:canPocket( ply, item )
		if not IsValid( item ) then return false end
		local class = item:GetClass()

		if !PICKUP_WHITELIST[class] then return false, "You can't pocket this item." end

		local trace = ply:GetEyeTrace()
		if ply:EyePos():DistToSqr( trace.HitPos ) > 22500 then return false end

		local ent = trace.Entity
		local phys = ent:GetPhysicsObject()
		if !phys:IsValid() then return false end

		local job = ply:Team()
		local max = 20
		if table.Count( ply.darkRPPocket or {} ) >= max then return false, "Your pocket is full!" end
		return true
	end
end

if CLIENT then
	local meta = FindMetaTable( "Player" )
	local pocket = {}
	local frame
	local reload

	--Interface functions
	function meta:getPocketItems()
		if self != LocalPlayer() then return nil end
		return pocket
	end

	function openPocketMenu()
		if IsValid( frame ) and frame:IsVisible() then return end
		local wep = LocalPlayer():GetActiveWeapon()
		if !wep:IsValid() or wep:GetClass() != "pocket" then return end

		if !pocket then
			pocket = {}
			return
		end

		if table.IsEmpty( pocket ) then return end
		frame = vgui.Create( "DFrame" )

		local count = 20
		frame:SetSize( 345, 32 + 64 * math.ceil( count / 5 ) + 3 * math.ceil( count / 5 ) )
		frame:SetTitle( "Drop Item" )
		frame.btnMaxim:SetVisible( false )
		frame.btnMinim:SetVisible( false )
		frame:SetDraggable( false )
		frame:MakePopup()
		frame:Center()

		local Scroll = vgui.Create( "DScrollPanel", frame )
		Scroll:Dock( FILL )

		local sbar = Scroll:GetVBar()
		sbar:SetWide( 3 )
		frame.List = vgui.Create( "DIconLayout", Scroll )
		frame.List:Dock( FILL )
		frame.List:SetSpaceY( 3 )
		frame.List:SetSpaceX( 3 )
		reload()
		frame:SetSkin( "Default" )
	end

	--UI
	function reload()
		if !IsValid( frame ) or !frame:IsVisible() then return end
		if !pocket or next( pocket ) == nil then frame:Close() return end

		local itemCount = table.Count( pocket )
		frame.List:Clear()
		local i = 0
		local items = {}

		for k,v in pairs( pocket ) do
			local ListItem = frame.List:Add( "DPanel" )
			ListItem:SetSize( 64, 64 )

			local icon = vgui.Create( "SpawnIcon", ListItem )
			icon:SetModel( v.model )
			icon:SetSize( 64, 64 )
			icon:SetTooltip()
			icon.DoClick = function( self )
				icon:SetTooltip()

				net.Start( "DarkRP_spawnPocket" )
				net.WriteFloat( k )
				net.SendToServer()
				pocket[k] = nil
				itemCount = itemCount - 1

				if itemCount == 0 then
					frame:Close()
					return
				end

				items = {}
				local wep = LocalPlayer():GetActiveWeapon()
				wep:SetHoldType( "pistol" )
				timer.Simple( 0.2, function()
					if wep:IsValid() then
						wep:SetHoldType( "normal" )
					end
				end )
			end
			table.insert( items, icon )
			i = i + 1
		end
		if itemCount < 20 then
			for _ = 1, 20 - itemCount do
				local ListItem = frame.List:Add( "DPanel" )
				ListItem:SetSize( 64, 64 )
			end
		end
	end

	local function retrievePocket()
		pocket = net.ReadTable()
		reload()
	end
	net.Receive( "DarkRP_Pocket", retrievePocket )
end

function SWEP:Initialize()
	self:SetHoldType( "normal" )
end

function SWEP:Deploy()
	return true
end

function SWEP:DrawWorldModel() end

function SWEP:PreDrawViewModel( vm )
	return true
end

function SWEP:Holster()
	if !SERVER then return true end
	self:GetOwner():DrawViewModel( true )
	self:GetOwner():DrawWorldModel( true )
	return true
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire( CurTime() + 0.2 )
	if !SERVER then return end
	local ply = self:GetOwner()
	local ent = ply:GetEyeTrace().Entity
	local canPickup, message = hook.Call( "canPocket", GAMEMODE, ply, ent )
	if !canPickup then
		if message then ply:Notify( 1, 6, message ) end
		return
	end
	ply:addPocketItem( ent )
end

function SWEP:SecondaryAttack()
	if !SERVER then return end

	local maxK = 0
	local ply = self:GetOwner()
	for k in pairs( ply:getPocketItems() ) do
		if k < maxK then continue end
		maxK = k
	end
	if maxK == 0 then
		ply:Notify( 1, 6, "Your pocket contains no items." )
		return
	end

	local canPickup, message = hook.Call( "canDropPocketItem", nil, ply, maxK, ply.darkRPPocket[maxK] )
	if canPickup == false then
		if message then ply:Notify( 1, 6, message ) end
		return
	end
	ply:dropPocketItem( maxK )
end

function SWEP:Reload()
	if !CLIENT then return end
	openPocketMenu()
end
