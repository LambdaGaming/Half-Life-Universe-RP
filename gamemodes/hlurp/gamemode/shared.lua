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
	["ironbar"] = true,
	["wrench"] = true,
	["crystal_fragment"] = true,
	["crystal_harvested"] = true,
	["wood"] = true
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

local sciencemodels = {
	"models/player/hdpp/gordon.mdl",
	"models/player/hdpp/male_01.mdl",
	"models/player/hdpp/male_02.mdl",
	"models/player/hdpp/male_03.mdl",
	"models/player/hdpp/kleiner.mdl"
}

local civimodels = {
	"models/player/Group01/Female_01.mdl",
	"models/player/Group01/Female_02.mdl",
	"models/player/Group01/Female_03.mdl",
	"models/player/Group01/Female_04.mdl",
	"models/player/Group01/Female_06.mdl",
	"models/player/group01/male_01.mdl",
	"models/player/Group01/Male_02.mdl",
	"models/player/Group01/male_03.mdl",
	"models/player/Group01/Male_04.mdl",
	"models/player/Group01/Male_05.mdl",
	"models/player/Group01/Male_06.mdl",
	"models/player/Group01/Male_07.mdl",
	"models/player/Group01/Male_08.mdl",
	"models/player/Group01/Male_09.mdl"
}

local securitymodels = {
	"models/player/hdpp/security/barney.mdl",
	"models/player/hdpp/security/male_05.mdl",
	"models/player/hdpp/security/male_06.mdl",
	"models/player/hdpp/security/male_09.mdl"
}

local leadermodels = {
	"models/player/barney.mdl",
	"models/player/alyx.mdl",
	"models/player/eli.mdl",
	"models/player/kleiner.mdl",
	"models/player/monk.mdl",
	"models/player/mossman.mdl",
	"models/player/odessa.mdl",
	"models/player/magnusson.mdl"
}

local cpmodels = {
	"models/player/police.mdl",
	"models/player/police_fem.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_arctic_police.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_badass_police.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_biopolice.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_c08cop.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_civil_medic.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_black_police.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_skull_police.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_hl2beta_police.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_hl2concept.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_HDpolice.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_hunter_police.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_phoenix_police.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_police_bt.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_elite_police.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_rtb_police.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_female_police.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_police_fragger.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_policetrench.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_rogue_police.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_resistance_police.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_retrocop.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_steampunk_police.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_tf2_metrocop_red.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_tf2_metrocop_blu.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_tribal_police.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_tron_police_cn.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_tron_police_or.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_urban_police.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_zombie_police.mdl"
}

HLU_JOB_CATEGORY = {
	[1] = { --BMRP Categories
		{
			Name = "Administration",
			Color = color_red
		},
		{
			Name = "Science",
			Color = Color( 90, 0, 120, 255 )
		},
		{
			Name = "Security",
			Color = color_blue
		},
		{
			Name = "Military",
			Color = Color( 56, 118, 29, 255 )
		},
		{
			Name = "Utility",
			Color = Color( 0, 116, 140, 255 )
		},
		{
			Name = "Other",
			Color = color_green
		}
	},
	[2] = { --City 17 RP Categories
		{
			Name = "Citizens",
			Color = color_green
		},
		{
			Name = "Combine",
			Color = Color( 5, 19, 30, 255 )
		},
		{
			Name = "Neutral",
			Color = Color( 135, 206, 235, 255 )
		}
	},
	[3] = { --Outland RP Categories
		{
			Name = "Rebels",
			Color = Color( 0, 128, 0, 255 )
		},
		{
			Name = "Combine",
			Color = Color( 5, 19, 30, 255 )
		}
	}
}

HLU_JOB = {
	[1] = { --BMRP Jobs
		{
			Name = "Visitor",
			Link = "visitor",
			Color = Color( 20, 150, 20, 255 ),
			Models = civimodels,
			Weapons = {},
			Max = 0,
			Category = "Other"
		},
		{
			Name = "Facility Administrator",
			Link = "facilityadmin",
			Color = color_red,
			Models = { "models/player/breen.mdl" },
			Weapons = { "weapon_leash_police" },
			Max = 1,
			Category = "Administration"
		},
		{
			Name = "Head of Survey Team",
			Link = "headofsurveyteam",
			Color = color_orange,
			Models = { "models/jheviv/jhevmk4.mdl" },
			Weapons = { "weapon_stunstick", "weapon_9mmar", "mgs_pickaxe" },
			Max = 1,
			Category = "Science",
			SpawnFunction = function( ply )
				ply:GiveAmmo( 50, "pistol" )
			end
		},
		{
			Name = "Survey Member",
			Link = "surveymember",
			Color = color_orange,
			Models = { "models/jheviv/jhevmk4.mdl" },
			Weapons = { "weapon_stunstick", "weapon_9mmhandgun", "mgs_pickaxe" },
			Max = 3,
			Category = "Science",
			SpawnFunction = function( ply )
				ply:GiveAmmo( 25, "Pistol" )
			end
		},
		{
			Name = "Technician",
			Link = "technician",
			Color = Color( 128, 0, 128, 255 ),
			Models = sciencemodels,
			Weapons = {},
			Max = 0,
			Category = "Science"
		},
		{
			Name = "Biochemist",
			Link = "biochemist",
			Color = Color( 128, 0, 128, 255 ),
			Models = { "models/hazmat/bmhaztechs.mdl" },
			Weapons = {},
			Max = 0,
			Category = "Science"
		},
		{
			Name = "Medic",
			Link = "medic",
			Color = Color( 47, 79, 79, 255 ),
			Models = { "models/player/kleiner.mdl" },
			Weapons = { "weapon_medkit" },
			Max = 2,
			Category = "Utility"
		},
		{
			Name = "Service Official",
			Link = "serviceofficial",
			Color = Color( 95, 158, 160, 255 ),
			Models = {
				"models/player/hdpp/male_05.mdl",
				"models/player/hdpp/male_06.mdl",
				"models/player/hdpp/male_09.mdl"
			},
			Weapons = { "weapon_extinguisher", "weapon_crowbar_hl", "weapon_pipewrench", "trash_wep", "broom" },
			Max = 2,
			Category = "Utility"
		},
		{
			Name = "Government Man",
			Link = "governmentman",
			Color = Color( 0, 116, 140, 255 ),
			Models = { "models/player/gman_high.mdl" },
			Weapons = { "swep_gmanbriefcase" },
			Max = 1,
			Category = "Administration"
		},
		{
			Name = "HECU Marine",
			Link = "hecumarine",
			Color = Color( 56, 118, 29, 255 ),
			Models = { "models/player/gasmask_hecu.mdl" },
			Weapons = { "weapon_shotgun_hl", "weapon_9mmhandgun", "weapon_ram" },
			Max = 3,
			Category = "Military",
			SpawnFunction = function( ply )
				ply:GiveAmmo( 50, "Buckshot" )
				ply:GiveAmmo( 25, "Pistol" )
			end
		},
		{
			Name = "HECU Captain",
			Link = "hecucaptain",
			Color = Color( 56, 118, 29, 255 ),
			Models = { "models/player/gasmask_hecu.mdl" },
			Weapons = { "weapon_9mmar", "weapon_eagle", "weapon_ram" },
			Max = 1,
			Category = "Military",
			SpawnFunction = function( ply )
				ply:GiveAmmo( 50, "Pistol" )
				ply:GiveAmmo( 25, "357" )
			end
		},
		{
			Name = "Weapon Specialist",
			Link = "weaponspecialist",
			Color = Color( 56, 118, 29, 255 ),
			Models = securitymodels,
			Weapons = { "weapon_shotgun_hl", "weapon_9mmhandgun" },
			Max = 1,
			Category = "Military",
			SpawnFunction = function( ply )
				ply:GiveAmmo( 50, "Buckshot" )
				ply:GiveAmmo( 25, "Pistol" )
			end
		},
		{
			Name = "Weapons Engineer",
			Link = "weaponsengineer",
			Color = Color( 128, 0, 128, 255 ),
			Models = sciencemodels,
			Weapons = {},
			Max = 0,
			Category = "Science"
		},
		{
			Name = "Head of Security",
			Link = "headofsecurity",
			Color = color_blue,
			Models = securitymodels,
			Weapons = { "weapon_357_hl", "weapon_shotgun_hl", "weapon_leash_police", "weapon_ram" },
			Max = 1,
			Category = "Security",
			IsCop = true,
			SpawnFunction = function( ply )
				ply:GiveAmmo( 50, "Buckshot" )
				ply:GiveAmmo( 25, "357" )
			end
		},
		{
			Name = "Security Officer",
			Link = "securityofficer",
			Color = color_blue,
			Models = securitymodels,
			Weapons = { "weapon_9mmhandgun", "weapon_leash_police", "weapon_ram" },
			Max = 3,
			Category = "Security",
			IsCop = true,
			SpawnFunction = function( ply )
				ply:GiveAmmo( 25, "Pistol" )
			end
		}
	},
	[2] = { --City 17 RP Jobs
		{
			Name = "Citizen",
			Link = "citizen",
			Color = color_green,
			Models = civimodels,
			Weapons = { "rphands", "mgs_pickaxe" },
			Max = 0,
			Category = "Citizens"
		},
		{
			Name = "Resistance Leader",
			Link = "resistanceleader",
			Color = Color( 28, 54, 9, 255 ),
			Models = leadermodels,
			Weapons = { "weapon_smg1", "weapon_portal_pair", "weapon_agent" },
			Max = 1,
			Category = "Citizens",
			SpawnFunction = function( ply )
				ply:GiveAmmo( 50, "smg1" )
			end
		},
		{
			Name = "Scientist",
			Link = "scientist",
			Color = Color( 128, 0, 128, 255 ),
			Models = sciencemodels,
			Weapons = {},
			Max = 1,
			Category = "Neutral"
		},
		{
			Name = "Vortigaunt",
			Link = "vortigaunt",
			Color = Color( 83, 107, 47, 255 ),
			Models = { "models/CS/Playermodels/vortigaunt.mdl" },
			Weapons = { "swep_vortigaunt_beam", "mgs_pickaxe" },
			Max = 2,
			Category = "Neutral"
		},
		{
			Name = "Government Man",
			Link = "governmentman",
			Color = Color( 0, 116, 140, 255 ),
			Models = { "models/player/gman_high.mdl" },
			Weapons = { "swep_gmanbriefcase" },
			Max = 1,
			Category = "Neutral"
		},
		{
			Name = "Earth's Administrator",
			Link = "earthadmin",
			Color = color_red,
			Models = { "models/player/breen.mdl" },
			Weapons = { "weapon_leash_police", "weapon_ram" },
			Max = 1,
			Category = "Combine"
		},
		{
			Name = "Overwatch Elite",
			Link = "overwatchelite",
			Color = Color( 128, 128, 128, 255 ),
			Models = { "models/player/combine_super_soldier.mdl" },
			Weapons = { "weapon_ar2", "weapon_frag", "weapon_ram", "weapon_leash_police" },
			Max = 2,
			Category = "Combine",
			SpawnFunction = function( ply )
				ply:GiveAmmo( 50, "AR2" )
			end
		},
		{
			Name = "Cremator",
			Link = "cremator",
			Color = Color( 166, 130, 0, 255 ),
			Models = { "models/player/cremator_player.mdl" },
			Weapons = { "weapon_bp_flamethrower" },
			Max = 1,
			Category = "Combine",
			SpawnFunction = function( ply )
				ply:GiveAmmo( 500, "bp_flame" )
			end
		},
		{
			Name = "Overwatch Guard",
			Link = "overwatchguard",
			Color = Color( 60, 90, 126, 255 ),
			Models = { "models/player/combine_soldier_prisonguard.mdl" },
			Weapons = { "weapon_frag", "weapon_bp_binoculars", "weapon_ram", "weapon_bp_sniper", "weapon_leash_police", "weapon_pistol", "weapon_medkit" },
			Max = 3,
			Category = "Combine",
			SpawnFunction = function( ply )
				ply:GiveAmmo( 50, "bp_sniper" )
				ply:GiveAmmo( 25, "Pistol" )
			end
		},
		{
			Name = "Overwatch Shotgunner Guard",
			Link = "overwatchguard",
			Color = Color( 30, 0, 0, 255 ),
			Models = { "models/player/combine_soldier.mdl" },
			Weapons = { "weapon_frag", "weapon_bp_binoculars", "weapon_ram", "weapon_shotgun", "weapon_leash_police", "weapon_pistol", "weapon_medkit" },
			Max = 3,
			Category = "Combine",
			SpawnFunction = function( ply )
				ply:GiveAmmo( 50, "Buckshot" )
				ply:GiveAmmo( 25, "Pistol" )
				ply:SetSkin( 1 )
			end
		},
		{
			Name = "Overwatch Soldier",
			Link = "overwatchsoldier",
			Color = Color( 128, 128, 128, 255 ),
			Models = { "models/player/combine_soldier.mdl" },
			Weapons = { "weapon_smg1", "weapon_frag", "weapon_bp_flaregun", "weapon_ram", "weapon_leash_police" },
			Max = 4,
			Category = "Combine",
			SpawnFunction = function( ply )
				ply:GiveAmmo( 50, "SMG1" )
				ply:SetSkin( 0 )
			end
		},
		{
			Name = "Manhack Civil Protection",
			Link = "metrocop",
			Color = color_black,
			Models = cpmodels,
			Weapons = { "weapon_pistol", "weapon_stunstick", "weapon_bp_flaregun", "weapon_ram", "weapon_leash_police", "weapon_controllable_manhack" },
			Max = 1,
			Category = "Combine",
			IsCop = true,
			SpawnFunction = function( ply )
				ply:GiveAmmo( 25, "Pistol" )
			end
		},
		{
			Name = "Civil Protection",
			Link = "metrocop",
			Color = color_black,
			Models = cpmodels,
			Weapons = { "weapon_pistol", "weapon_stunstick", "weapon_bp_flaregun", "weapon_ram", "weapon_leash_police" },
			Max = 0,
			Category = "Combine",
			IsCop = true,
			SpawnFunction = function( ply )
				ply:GiveAmmo( 25, "Pistol" )
			end
		}
	},
	[3] = { --Outland RP Jobs
		{
			Name = "Refugee",
			Link = "refugee",
			Color = Color( 28, 54, 9, 255 ),
			Models = civimodels,
			Weapons = { "rphands", "mgs_pickaxe" },
			Max = 0,
			Category = "Rebels"
		},
		{
			Name = "Resistance Leader",
			Link = "resistanceleader",
			Color = Color( 0, 128, 0, 255 ),
			Models = leadermodels,
			Weapons = { "weapon_smg1", "weapon_portal_pair", "weapon_agent" },
			Max = 1,
			Category = "Rebels",
			IsCop = true,
			SpawnFunction = function( ply )
				ply:GiveAmmo( 50, "SMG1" )
			end
		},
		{
			Name = "Rebel",
			Link = "rebel",
			Color = Color( 0, 128, 0, 255 ),
			Models = {
				"models/player/Group03/female_01.mdl",
				"models/player/Group03/female_02.mdl",
				"models/player/Group03/female_03.mdl",
				"models/player/Group03/female_04.mdl",
				"models/player/Group03/female_05.mdl",
				"models/player/Group03/female_06.mdl",
				"models/player/Group03/male_01.mdl",
				"models/player/Group03/male_02.mdl",
				"models/player/Group03/male_03.mdl",
				"models/player/Group03/male_04.mdl",
				"models/player/Group03/male_05.mdl",
				"models/player/Group03/male_06.mdl",
				"models/player/Group03/male_07.mdl",
				"models/player/Group03/male_08.mdl",
				"models/player/Group03/male_09.mdl"
			},
			Weapons = { "rphands", "weapon_smg1", "mgs_pickaxe" },
			Max = 0,
			Category = "Rebels",
			IsCop = true,
			SpawnFunction = function( ply )
				ply:GiveAmmo( 50, "SMG1" )
			end
		},
		{
			Name = "Rebel Medic",
			Link = "rebelmedic",
			Color = Color( 0, 128, 0, 255 ),
			Models = {
				"models/player/Group03m/male_01.mdl",
				"models/player/Group03m/male_02.mdl",
				"models/player/Group03m/male_03.mdl",
				"models/player/Group03m/male_04.mdl",
				"models/player/Group03m/male_05.mdl",
				"models/player/Group03m/male_06.mdl",
				"models/player/Group03m/male_07.mdl",
				"models/player/Group03m/male_08.mdl",
				"models/player/Group03m/male_09.mdl",
				"models/player/Group03m/female_01.mdl",
				"models/player/Group03m/female_02.mdl",
				"models/player/Group03m/female_03.mdl",
				"models/player/Group03m/female_04.mdl",
				"models/player/Group03m/female_05.mdl",
				"models/player/Group03m/female_06.mdl"
			},
			Weapons = { "weapon_pistol", "rphands", "mgs_pickaxe", "weapon_medkit" },
			Max = 3,
			Category = "Rebels",
			SpawnFunction = function( ply )
				ply:GiveAmmo( 25, "Pistol" )
			end
		},
		{
			Name = "Overwatch Elite",
			Link = "overwatchelite",
			Color = Color( 128, 128, 128, 255 ),
			Models = { "models/player/combine_super_soldier.mdl" },
			Weapons = { "weapon_ar2", "weapon_frag", "weapon_ram", "weapon_leash_police" },
			Max = 2,
			Category = "Combine",
			SpawnFunction = function( ply )
				ply:GiveAmmo( 50, "AR2" )
			end
		},
		{
			Name = "Overwatch Guard",
			Link = "overwatchguard",
			Color = Color( 60, 90, 126, 255 ),
			Models = { "models/player/combine_soldier_prisonguard.mdl" },
			Weapons = { "weapon_bp_binoculars", "weapon_ram", "weapon_bp_sniper", "weapon_leash_police", "weapon_pistol", "weapon_medkit" },
			Max = 3,
			Category = "Combine",
			SpawnFunction = function( ply )
				ply:GiveAmmo( 50, "bp_sniper" )
				ply:GiveAmmo( 25, "Pistol" )
			end
		},
		{
			Name = "Overwatch Soldier",
			Link = "overwatchsoldier",
			Color = Color( 128, 128, 128, 255 ),
			Models = { "models/player/combine_soldier.mdl" },
			Weapons = { "weapon_smg1", "weapon_frag", "weapon_bp_flaregun", "weapon_ram", "weapon_leash_police" },
			Max = 0,
			Category = "Combine",
			SpawnFunction = function( ply )
				ply:GiveAmmo( 50, "SMG1" )
				ply:SetSkin( 0 )
			end
		},
		{
			Name = "Overwatch Shotgunner Guard",
			Link = "overwatchguard",
			Color = Color( 30, 0, 0, 255 ),
			Models = { "models/player/combine_soldier.mdl" },
			Weapons = { "weapon_ram", "weapon_shotgun", "weapon_leash_police" },
			Max = 1,
			Category = "Combine",
			SpawnFunction = function( ply )
				ply:GiveAmmo( 50, "Buckshot" )
				ply:SetSkin( 1 )
			end
		}
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
