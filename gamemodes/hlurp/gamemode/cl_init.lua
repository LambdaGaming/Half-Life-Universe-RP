
include( "shared.lua" )
include( "cl_hlu_chat.lua" )
include( "sh_bmrp.lua" )
include( "cl_bmrp.lua" )
include( "sh_c17.lua" )
include( "sh_outland.lua" )

local themecolor = ColorAlpha( HLU_GAMEMODE[GetGlobalInt( "CurrentGamemode" )].Color, 30 )
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

surface.CreateFont( "JobDesc", {
	font = "Arial",
	size = 20
} )

function GM:DrawDeathNotice()
	return false
end

--Credit to the DarkRP devs for these text wrap functions
local function charWrap(text, remainingWidth, maxWidth)
    local totalWidth = 0
    text = text:gsub(".", function(char)
        totalWidth = totalWidth + surface.GetTextSize(char)
        if totalWidth >= remainingWidth then
            totalWidth = surface.GetTextSize(char)
            remainingWidth = maxWidth
            return "\n" .. char
        end
        return char
    end)
    return text, totalWidth
end

local function textWrap(text, font, maxWidth)
    local totalWidth = 0
    surface.SetFont(font)
    local spaceWidth = surface.GetTextSize(' ')
    text = text:gsub("(%s?[%S]+)", function(word)
            local char = string.sub(word, 1, 1)
            if char == "\n" or char == "\t" then
                totalWidth = 0
            end
            local wordlen = surface.GetTextSize(word)
            totalWidth = totalWidth + wordlen
            if wordlen >= maxWidth then
                local splitWord, splitPoint = charWrap(word, maxWidth - (totalWidth - wordlen), maxWidth)
                totalWidth = splitPoint
                return splitWord
            elseif totalWidth < maxWidth then
                return word
            end
            if char == ' ' then
                totalWidth = wordlen - spaceWidth
                return '\n' .. string.sub(word, 2)
            end
            totalWidth = wordlen
            return '\n' .. word
        end)
    return text
end

function DrawJobMenu()
	local ply = LocalPlayer()
	local mainframe = vgui.Create( "DFrame" )
	mainframe:SetTitle( "Choose a Job:" )
	mainframe:SetSize( ScrW() * 0.75, ScrH() * 0.75 )
	mainframe:Center()
	mainframe:MakePopup()
	mainframe.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, themecolor )
	end
	mainframe.OnClose = function()
		ply.MenuOpen = false
	end
	local mainframescroll = vgui.Create( "DScrollPanel", mainframe )
	mainframescroll:Dock( FILL )
	for a,b in ipairs( HLU_JOB_CATEGORY[GetGlobalInt( "CurrentGamemode" )] ) do
		local categorybutton = vgui.Create( "DButton", mainframescroll )
		categorybutton:SetSize( nil, 50 ) --X is ignored since it's docked to the frame already
		categorybutton:SetText( b.Name )
		categorybutton:SetFont( "JobCategory" )
		categorybutton:SetTextColor( color_white )
		categorybutton:Dock( TOP )
		if a > 1 then
			categorybutton:DockMargin( 0, 60, 0, 5 )
		else
			categorybutton:DockMargin( 0, 0, 0, 5 )
		end
		categorybutton.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, b.Color )
		end
		for k,v in ipairs( HLU_JOB[GetGlobalInt( "CurrentGamemode" )] ) do
			if v.Category != b.Name then --Puts jobs into their respective categories
				continue
			end
			local max
			if v.Max > 0 then
				max = v.Max
			else
				max = "∞"
			end
			local mainbuttons = vgui.Create( "DButton", mainframescroll )
			mainbuttons:SetSize( nil, 100 )
			mainbuttons:SetText( v.Name..": "..team.NumPlayers( k ).."/"..max )
			mainbuttons:SetTextInset( 0, -30 )
			mainbuttons:SetFont( "JobTitle" )
			mainbuttons:SetTextColor( color_white )
			mainbuttons:Dock( TOP )
			mainbuttons:DockMargin( 0, 0, 0, 5 )
			mainbuttons.Paint = function( self, w, h )
				draw.RoundedBox( 0, 0, 0, w, h, v.Color )
			end
			mainbuttons.DoClick = function()
				net.Start( "HLU_ChangeJob" )
				net.WriteInt( k, 32 )
				net.SendToServer()
				mainframe:Close()
			end
			local buttontext = vgui.Create( "DLabel", mainbuttons )
			buttontext:Dock( BOTTOM )
			buttontext:DockMargin( 5, 5, 5, 5 )
			buttontext:SetSize( mainbuttons:GetSize() )
			buttontext:SetText( textWrap( "Description: "..v.Description, "JobDesc", ScrW() * 0.75 ) )
			buttontext:SizeToContents()
		end
	end
	ply.MenuOpen = true
end

local function HLUButtons( ply, button )
	local f4 = KEY_F4
	local f3 = KEY_F3
	if !IsFirstTimePredicted() then return end
	if button == f4 and !ply.MenuOpen then
		DrawJobMenu()
	end
	if button == f3 then
		gui.OpenURL( "https://lambdagaming.github.io/hlurp/lambda_hlu_main.html" )
	end
end
hook.Add( "PlayerButtonDown", "HP_ChangeTeam", HLUButtons )