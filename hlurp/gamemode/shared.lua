GM.Name = "Half-Life Universe RP"
GM.Author = "Lambda Gaming"
GM.Email = "N/A"
GM.Website = "lambdagaming.github.io"

DeriveGamemode( "sandbox" )

local bmrpmaps = {
	["gm_atomic"] = true,
	["rp_bmrf"] = true
}

local city17maps = {
	["rp_city17_build210"] = true,
	["rp_city24_v4"] = true
}

local outlandmaps = {
	["rp_mezs"] = true
}

if bmrpmaps[game.GetMap()] then
	SetGlobalInt( "CurrentGamemode", 1 )
elseif city17maps[game.GetMap()] then
	SetGlobalInt( "CurrentGamemode", 2 )
elseif outlandmaps[game.GetMap()] then
	SetGlobalInt( "CurrentGamemode", 3 )
end

GLOBAL_WHITELIST = { --Global entity whitelist currently used by the trash swep and the pocket
	["organic_matter"] = true,
	["organic_matter_cooked"] = true,
	["mediaplayer_tv"] = true,
	["organic_matter_rare"] = true,
	["xen_iron"] = true,
	["xen_iron_refined"] = true,
	["ucs_iron"] = true,
	["crystal_fragment"] = true,
	["crystal_harvested"] = true,
	["crystal_pure"] = true,
	["ucs_wood"] = true,
	["rp_food"] = true,
	["rp_chips"] = true,
	["rp_soda"] = true
}

HLU_GAMEMODE = {
    {
        Name = "Black Mesa RP",
		Color = color_orange
    },
    {
        Name = "City 17 RP",
		Color = color_theme
    },
    {
        Name = "Outland RP",
		Color = color_green
    }
}

function FindTeamByName( name )
	local curgame = GetGlobalInt( "CurrentGamemode" )
	local inputlower = string.lower( name )
	for k,v in pairs( HLU_JOB[curgame] ) do
		local outputlower = string.lower( v.Name )
		if outputlower == inputlower then return k end
	end
end

local meta = FindMetaTable( "Player" )
function meta:GetJobCategory()
	if !IsValid( self ) then return "Unknown" end
	local curgame = GetGlobalInt( "CurrentGamemode" )
	local job = self:Team()
	local jobtable = HLU_JOB[curgame][job]
	return jobtable.Category
end

function meta:GetJobName()
	if !IsValid( self ) then return "Unknown" end
	local curgame = GetGlobalInt( "CurrentGamemode" )
	local job = self:Team()
	local jobtable = HLU_JOB[curgame][job]
	return self:GetNWString( "RPJob", false ) or jobtable.Name
end

function meta:GetJobColor()
	if !IsValid( self ) then return color_transparent end
	local curgame = GetGlobalInt( "CurrentGamemode" )
	local job = self:Team()
	local jobtable = HLU_JOB[curgame][job]
	return jobtable.Color
end

--Similar to what DarkRP does for overriding player names
meta.SteamName = meta.SteamName or meta.Name
function meta:Name()
	return self:GetNWString( "RPName", false ) or self:SteamName()
end
meta.GetName = meta.Name
meta.Nick = meta.Name

function GM:Initialize()
	local curgame = GetGlobalInt( "CurrentGamemode" )
	for k,v in pairs( HLU_JOB[curgame] ) do
		team.SetUp( k, v.Name, v.Color )
	end
	if curgame == 1 then
		SetGlobalInt( "BMRP_Budget", 10000 )
	end
end
