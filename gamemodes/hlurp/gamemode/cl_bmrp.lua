if GetGlobalInt( "CurrentGamemode" ) != 1 then return end

net.Receive( "SendID", function()
	local ply = net.ReadEntity()
	local plyteam = ply:Team()
	local teamcolor = team.GetColor( plyteam )
	chat.AddText( teamcolor, ply:Nick(), color_white, " presents their identification. It reads: ", teamcolor, HLU_JOB[1][plyteam].Name )
end )

local themecolor = ColorAlpha( HLU_GAMEMODE[1].Color, 40 )
local whitelist = {
	[TEAM_SURVEYBOSS] = true,
	[TEAM_SURVEY] = true,
	[TEAM_TECH] = true,
	[TEAM_BIO] = true,
	[TEAM_MEDIC] = true,
	[TEAM_SERVICE] = true,
	[TEAM_WEPBOSS] = true,
	[TEAM_SECURITYBOSS] = true,
	[TEAM_SECURITY] = true
}

surface.CreateFont( "TaskFont", {
	font = "Arial",
	size = 16,
} )

--Text wrap functions for HUD elements, credit goes to the DarkRP developers
local function safeText( text )
    return string.match( text, "^#([a-zA-Z_]+)$" ) and text .. " " or text
end

local function DrawNonParsedText( text, font, x, y, color, xAlign )
    return draw.DrawText( safeText( text ), font, x, y, color, xAlign )
end

local function charWrap( text, remainingWidth, maxWidth )
    local totalWidth = 0
    text = text:gsub( ".", function( char )
        totalWidth = totalWidth + surface.GetTextSize( char )
        --Wrap around when the max width is reached
        if totalWidth >= remainingWidth then
            --totalWidth needs to include the character width because it's inserted in a new line
            totalWidth = surface.GetTextSize( char )
            remainingWidth = maxWidth
            return "\n" .. char
        end
        return char
    end )
    return text, totalWidth
end

local function TextWrap( text, font, maxWidth )
    local totalWidth = 0
    surface.SetFont( font )
    local spaceWidth = surface.GetTextSize( ' ' )
    text = text:gsub( "(%s?[%S]+)", function( word )
            local char = string.sub( word, 1, 1 )
            if char == "\n" or char == "\t" then
                totalWidth = 0
            end

            local wordlen = surface.GetTextSize( word )
            totalWidth = totalWidth + wordlen

            --Wrap around when the max width is reached
            if wordlen >= maxWidth then --Split the word if the word is too big
                local splitWord, splitPoint = charWrap( word, maxWidth - ( totalWidth - wordlen ), maxWidth )
                totalWidth = splitPoint
                return splitWord
            elseif totalWidth < maxWidth then
                return word
            end

            -- Split before the word
            if char == ' ' then
                totalWidth = wordlen - spaceWidth
                return '\n' .. string.sub( word, 2 )
            end
            totalWidth = wordlen
            return '\n' .. word
        end )
    return text
end

local color = ColorAlpha( color_orange, 75 )
hook.Add( "HUDPaint", "DrawTaskBox", function()
	local ply = LocalPlayer()
	local job = ply:Team()
	local task = BMRP_CURRENT_TASKS[job] or "None"
	if whitelist[job] then
		draw.RoundedBox( 5, 15, 15, 300, 100, color )
		DrawNonParsedText( TextWrap( "Current Task: "..task, "TaskFont", 285 ), "TaskFont", 30, 20, color_white )
	end
end )

local function DrawCustomTaskMenu( finish )
	local ply = LocalPlayer()
	local job = 0
	local mainframe = vgui.Create( "DFrame" )
	mainframe:SetTitle( "Enter custom task:" )
	mainframe:SetSize( 500, 100 )
	mainframe:Center()
	mainframe:MakePopup()
	mainframe.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, themecolor )
	end
	mainframe.OnClose = function()
		ply.MenuOpen = false
	end

	local jobs = vgui.Create( "DComboBox", mainframe )
	jobs:Dock( TOP )
	jobs:SetText( "Choose target job" )
	for k,v in pairs( HLU_JOB[1] ) do
		if whitelist[k] then
			jobs:AddChoice( v.Name, k )
		end
	end
	function jobs:OnSelect( index, text, data )
		job = data
	end

	if finish then
		mainframe:SetSize( 500, 150 )
		local label = vgui.Create( "DLabel", mainframe )
		label:SetFont( "Trebuchet18" )
		label:SetColor( color_white )
		label:SetText( "Enter the amount of funds you would like to award: (Max 1000)" )
		label:Dock( TOP )
		label:DockMargin( 0, 10, 0, 0 )
		local wang = vgui.Create( "DNumberWang", mainframe )
		wang:SetMin( 1 )
		wang:SetMax( 1000 )
		wang:Dock( TOP )
		wang:SetSize( nil, 26 )
		local button = vgui.Create( "DButton", mainframe )
		button:SetText( "Submit" )
		button:SetSize( nil, 26 )
		button:Dock( TOP )
		button:DockMargin( 0, 10, 0, 0 )
		button.DoClick = function()
			net.Start( "GetTask" )
			net.WriteInt( job, 8 )
			net.WriteString( "None" )
			net.WriteInt( wang:GetValue(), 11 )
			net.SendToServer()
		end
	else
		local txt = vgui.Create( "DTextEntry", mainframe )
		txt:Dock( FILL )
		txt:SetMaximumCharCount( 300 )
		txt:SetPlaceholderText( "Enter custom task" )
		txt.OnEnter = function( self )
			net.Start( "GetTask" )
			net.WriteInt( job, 8 )
			net.WriteString( self:GetValue() )
			net.SendToServer()
		end
	end
	ply.MenuOpen = true
end

local function DrawEventMenu()
	if GetGlobalInt( "CurrentGamemode" ) != 1 then return end
	local ply = LocalPlayer()
	local plyteam = ply:Team()
	local gman = TEAM_GMAN
	local admin = TEAM_ADMIN

	if ply:Team() != gman and ply:Team() != admin then return end

	local mainframe = vgui.Create( "DFrame" )
	if plyteam == gman then
		mainframe:SetTitle( "Select an event to start:" )
	else
		mainframe:SetTitle( "Select a task to assign:" )
	end
	mainframe:SetSize( 500, 500 )
	mainframe:Center()
	mainframe:MakePopup()
	mainframe.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, themecolor )
	end
	mainframe.OnClose = function()
		ply.MenuOpen = false
	end

	local tbl
	if plyteam == gman then
		tbl = BMRP_EVENTS
	else
		tbl = BMRP_TASKS
	end

	local listframe = vgui.Create( "DScrollPanel", mainframe )
	listframe:Dock( FILL )

	if ply:Team() == admin then
		local mainbuttons = vgui.Create( "DButton", listframe )
		mainbuttons:SetText( "Set Custom Task" )
		mainbuttons:SetTextColor( color_white )
		mainbuttons:SetFont( "JobTitle" )
		mainbuttons:Dock( TOP )
		mainbuttons:SetSize( 450, 50 )
		mainbuttons:DockMargin( 0, 0, 0, 10 )
		mainbuttons.Paint = function( self, w, h )
			surface.SetDrawColor( ColorAlpha( themecolor, 255 ) )
			surface.DrawRect( 0, 0, w, h )
		end
		mainbuttons.DoClick = function()
			mainframe:Close()
			DrawCustomTaskMenu()
		end

		local mainbuttons = vgui.Create( "DButton", listframe )
		mainbuttons:SetText( "Clear Task & Award Funds" )
		mainbuttons:SetTextColor( color_white )
		mainbuttons:SetFont( "JobTitle" )
		mainbuttons:Dock( TOP )
		mainbuttons:SetSize( 450, 50 )
		mainbuttons:DockMargin( 0, 0, 0, 10 )
		mainbuttons.Paint = function( self, w, h )
			surface.SetDrawColor( ColorAlpha( themecolor, 255 ) )
			surface.DrawRect( 0, 0, w, h )
		end
		mainbuttons.DoClick = function()
			mainframe:Close()
			DrawCustomTaskMenu( true )
		end
	end
	
	for k,v in pairs( tbl ) do
		local itembackground = vgui.Create( "DPanel", listframe )
		itembackground:SetSize( 450, 100 )
		itembackground:Dock( TOP )
		itembackground:Center()
		itembackground:DockMargin( 0, 0, 0, 10 )
		itembackground.Paint = function( self, w, h )
			surface.SetDrawColor( Color( 45, 45, 45 ) )
			surface.DrawRect( 0, 0, w, h )
		end

		local mainbuttons = vgui.Create( "DButton", itembackground )
		mainbuttons:SetText( v.Name )
		mainbuttons:SetTextColor( color_white )
		mainbuttons:SetFont( "JobTitle" )
		mainbuttons:Dock( LEFT )
		mainbuttons:SetSize( 125, nil )
		mainbuttons:SetWrap( true )
		mainbuttons.Paint = function( self, w, h )
			surface.SetDrawColor( ColorAlpha( themecolor, 255 ) )
			surface.DrawRect( 0, 0, w, h )
		end
		mainbuttons.DoClick = function()
			if plyteam == gman then
				net.Start( "NudgeEvent" )
				net.WriteInt( k, 8 )
				net.SendToServer()
			else
				net.Start( "GetTask" )
				net.WriteInt( k, 8 )
				net.SendToServer()
			end
			mainframe:Close()
		end

		local itemdesc = vgui.Create( "DLabel", itembackground )
		itemdesc:SetFont( "Trebuchet18" )
		itemdesc:SetColor( color_white )
		if plyteam == gman then
			itemdesc:SetText( "Affected Job: "..HLU_JOB[1][v.Required].Name.."\n"..v.Description )
		else
			local affected = ""
			local first = true
			for k,v in pairs( v.Required ) do
				local name = HLU_JOB[1][v].Name
				if first then
					affected = name
				else
					affected = affected..", "..name
				end
				first = false
			end
			itemdesc:SetText( "Affected Job(s): "..affected.."\n"..v.Description )
		end
		itemdesc:Dock( RIGHT )
		itemdesc:SetWrap( true )
		itemdesc:SetSize( 320, 110 )
	end
	ply.MenuOpen = true
end

net.Receive( "UpdateTask", function()
	local tbl = net.ReadTable()
	BMRP_CURRENT_TASKS = tbl
end )

local function HLUButtons( ply, button )
	if IsFirstTimePredicted() and !ply.MenuOpen then
		if button == KEY_F1 then
			DrawEventMenu()
		end
	end
end
hook.Add( "PlayerButtonDown", "OpenEventMenu", HLUButtons )
