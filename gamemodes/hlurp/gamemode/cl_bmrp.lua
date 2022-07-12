if GetGlobalInt( "CurrentGamemode" ) != 1 then return end

net.Receive( "SendID", function()
	local ply = net.ReadEntity()
	local plyteam = ply:Team()
	local teamcolor = team.GetColor( plyteam )
	chat.AddText( teamcolor, ply:Nick(), color_white, " presents their identification. It reads: ", teamcolor, HLU_JOB[1][plyteam].Name )
end )

hook.Add( "InitPostEntity", "BMRP_SoundFix", function()
	if game.GetMap() == "rp_sectorc_beta" then
		RunConsoleCommand( "snd_restart" ) --Fixes ambient and door sounds not being heard on this map
	end
end )

local whitelist = {
	[TEAM_SURVEYBOSS] = true,
	[TEAM_SURVEY] = true,
	[TEAM_TECH] = true,
	[TEAM_BIO] = true,
	[TEAM_MEDIC] = true,
	[TEAM_SERVICE] = true,
	[TEAM_WEPBOSS] = true,
	[TEAM_WEPMAKER] = true,
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
