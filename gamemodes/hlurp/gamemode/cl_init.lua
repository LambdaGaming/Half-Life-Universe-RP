include( "shared.lua" )
include( "sh_jobs.lua" )
include( "sh_bmrp.lua" )
include( "sh_bmrp_events.lua" )
include( "sh_c17.lua" )
include( "sh_outland.lua" )
include( "cl_chat.lua" )
include( "cl_bmrp.lua" )
include( "cl_menus.lua" )
include( "modules/sh_crafting_items.lua" )
include( "modules/sh_npc_items.lua" )
include( "modules/sh_door_config.lua" )

local current = GetGlobalInt( "CurrentGamemode" )
local themecolor = ColorAlpha( HLU_GAMEMODE[current].Color, 40 )
surface.CreateFont( "JobCategory", {
	font = "Arial",
	size = 30,
	weight = 900
} )

surface.CreateFont( "JobTitle", {
	font = "Arial",
	size = 20,
	weight = 900
} )

surface.CreateFont( "QuestionMark", {
	font = "Arial",
	size = 50,
	weight = 900
} )

function GM:DrawDeathNotice()
	return false
end

--Luminance calculator
function IsDarkColor( color )
	return 0.2126 * color.r + 0.7152 * color.g + 0.0722 * color.b < 255 / 3
end

scoreboard = scoreboard or {}
function scoreboard:show()
	local main = vgui.Create( "DFrame" )
	main:SetSize( 800, 600 )
	main:Center()
	main:ShowCloseButton( false )
	main:MakePopup()
	main:SetDraggable( false )
	main:SetTitle( "Lambda Gaming Half-Life Universe RP" )
	main.Paint = function( self, w, h )
		draw.RoundedBox( 2, 0, 0, w, h, themecolor )
	end

	local plylist = vgui.Create( "DListView", main )
	plylist:Dock( FILL )
	plylist:AddColumn( "Name" ):SetWidth( 175 )
	plylist:AddColumn( "Job" ):SetWidth( 175 )
	plylist:AddColumn( "Health" ):SetWidth( 50 )
	plylist:AddColumn( "Kills" ):SetWidth( 50 )
	plylist:AddColumn( "Deaths" ):SetWidth( 50 )
	plylist:AddColumn( "Ping" ):SetWidth( 50 )
	plylist:SetDataHeight( 30 )
	plylist.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, color_transparent )
	end

	for k,v in ipairs( player.GetAll() ) do
		local row = plylist:AddLine( v:Nick(), v:GetJobName(), v:Health(), v:Frags(), v:Deaths(), v:Ping() )
		row:SetCursor( "hand" )
		for i=1,6 do
			if IsDarkColor( v:GetJobColor() ) then
				row.Columns[i]:SetTextColor( color_white )
			end
		end
		function row:Paint( w, h )
			draw.RoundedBox( 0, 0, 0, w, h, v:GetJobColor() )
		end
		function row:OnSelect()
			gui.OpenURL( "https://steamcommunity.com/profiles/"..v:SteamID64() )
		end
	end
	function scoreboard:hide()
		main:Close()
	end
end

function GM:ScoreboardShow()
	scoreboard:show()
end

function GM:ScoreboardHide()
	scoreboard:hide()
end

surface.CreateFont( "EntitySignFont", {
	font = "Roboto",
	size = 400,
	antialias = true
} )
local meta = FindMetaTable( "Entity" )
local offset = Vector( 0, 0, 80 )
function meta:DrawOverheadText( text, override )
	local origin = self:GetPos()
	local ply = LocalPlayer()
	if ply:GetPos():DistToSqr( origin ) >= 589824 then return end

	local pos = origin + ( override or offset )
	local ang = ( ply:EyePos() - pos ):Angle()
	ang.p = 0
	ang:RotateAroundAxis( ang:Right(), 90 )
	ang:RotateAroundAxis( ang:Up(), 90 )
	ang:RotateAroundAxis( ang:Forward(), 180 )
	cam.Start3D2D( pos, ang, 0.035 )
		draw.SimpleText( text, "EntitySignFont", 0, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
	cam.End3D2D()
end
