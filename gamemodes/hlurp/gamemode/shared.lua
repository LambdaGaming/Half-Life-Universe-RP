
GM.Name = "Half-Life Universe RP"
GM.Author = "Lambda Gaming"
GM.Email = "N/A"
GM.Website = "lambdagaming.github.io"

DeriveGamemode( "sandbox" )

local bmrpmaps = {
	["rp_sectorc_beta"] = true,
	["rp_blackmesa_laboratory"] = true,
	["rp_blackmesa_complex_fixed"] = true,
	["gm_atomic"] = true,
	["rp_bmrf"] = true
}

local city17maps = {
	["rp_city17_build210"] = true,
	["rp_city17_district47"] = true,
	["rp_city24_v2"] = true
}

local outlandmaps = {
	["rp_ineu_valley2_v1a"] = true,
	["gm_boreas"] = true
}

if bmrpmaps[game.GetMap()] then
	SetGlobalInt( "CurrentGamemode", 1 )
elseif city17maps[game.GetMap()] then
	SetGlobalInt( "CurrentGamemode", 2 )
elseif outlandmaps[game.GetMap()] then
	SetGlobalInt( "CurrentGamemode", 3 )
end

HLU_GAMEMODE = {
    [1] = {
        Name = "Black Mesa RP",
		Color = color_orange
    },
    [2] = {
        Name = "City 17 RP",
		Color = color_theme
    },
    [3] = {
        Name = "Outland RP",
		Color = color_green
    }
}

local sciencemodels = {
	"models/player/hdpp/gordon.mdl",
	"models/player/hdpp/male_01.mdl",
	"models/player/hdpp/male_02.mdl",
	"models/player/hdpp/male_03.mdl",
	"models/player/hdpp/male_05.mdl",
	"models/player/hdpp/male_06.mdl",
	"models/player/hdpp/male_09.mdl",
	"models/Player/hdpp/barney.mdl",
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
	"models/DPFilms/Metropolice/Playermodels/pm_HD_Barney.mdl",
	"models/DPFilms/Metropolice/Playermodels/pm_HD_Barney_ep1.mdl",
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
			Name = "Management",
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
			Name = "Other",
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
			Description = "The Visitor is not employed and requires a security escort to get into the Black Mesa Research Facility. This is recommended if you are new to the server.",
			Color = Color( 20, 150, 20, 255 ),
			Models = civimodels,
			Weapons = {},
			Max = 0,
			Category = "Other"
		},
		{
			Name = "Facility Administrator",
			Description = "The Administrator is pretty much the opposite of the visitor. He has access to the entire facility, as well as control over everyone in it. As an administrator, you can escort visitors, command part of the military, call for fire drills, and, if needed, call for an emergency evacuation or lockdown. You talk with your on site-military and security to keep people safe, and you occasionally walk around the facility to check on things. Finally, and most importantly, it is your job to schedule Anomalous Materials tests on Xen specimens using the Anti-Mass Spectrometer (AMS). A test can only happen once every 2 hours real-time, so if you think you are not ready with the specimen, don't schedule a test.",
			Color = color_red,
			Models = { "models/player/breen.mdl" },
			Weapons = { "weapon_leash_police", "weapon_announcement" },
			Max = 1,
			Category = "Administration"
		},
		{
			Name = "Head of Survey Team",
			Description = "As the Head of the Survey Team, your job is to order and plan the trips to Xen. You are also required to go to Xen in the event that one of the other Survey Team members is in trouble. You have permission to use firearms, but only in the event of an alien encounter. You will also be required to report to Sector C if the administrator wants to run a test as you will be the one to handle the specimen.",
			Color = color_orange,
			Models = { "models/jheviv/jhevmk4.mdl" },
			Weapons = { "weapon_stunstick", "weapon_9mmar", "mgs_pickaxe" },
			Max = 1,
			Category = "Science"
		},
		{
			Name = "Survey Member",
			Description = "As a Survey Team member, your Job is to use the Sector A teleportation unit to teleport to Xen and bring crystal samples and live aliens back to Black Mesa for the Biochemist to research. If you fail to bring back any live creatures, don't worry, the Biochemist may have the technology to manually bring in a live creature from Xen. Your job could be highly dangerous, so call the head of the Survey Team if you need assistance. Lastly, you are required to report to the AMS in Sector C when the administrator wants to perform a test if there is no Head of Survey Team to insert the specimen.",
			Color = color_orange,
			Models = { "models/jheviv/jhevmk4.mdl" },
			Weapons = { "weapon_stunstick", "weapon_9mmhandgun", "mgs_pickaxe" },
			Max = 3,
			Category = "Science"
		},
		{
			Name = "Research and Development",
			Description = "As a member of the Research and Development team, your job is to research and develop new technology for use in the B.M.R.F. Use of advanced Wiremod and Gterminal is highly recommended for this job. This job is similar to the Weapons Engineer, except for the fact this job uses simple Wiremod instead of Wiremod turrets and explosives.",
			Color = Color( 128, 0, 128, 255 ),
			Models = sciencemodels,
			Weapons = {},
			Max = 0,
			Category = "Science"
		},
		{
			Name = "Technician",
			Description = "As a technician, your job is to work on all types of computer systems. You can also help other scientists if they have a question about Wiremod or Gterminal. Recommended for advanced Wiremod users.",
			Color = Color( 128, 0, 128, 255 ),
			Models = sciencemodels,
			Weapons = {},
			Max = 2,
			Category = "Science"
		},
		{
			Name = "Biochemist",
			Description = "Your main job is to study the crystals the Survey Team brings back from Xen. If you have the time, you can study other biological and living things. You can study living things by using your NPC spawner tool. This tool is known throughout Black Mesa as a mobile-mini-dimensional-portal. It allows you to spawn any NPC in the game. Don't abuse it by spamming the NPC count though; you may be banned from this job for doing so.",
			Color = Color( 128, 0, 128, 255 ),
			Models = sciencemodels,
			Weapons = {},
			Max = 2,
			Category = "Science"
		},
		{
			Name = "Medic",
			Description = "With your medical knowledge you work to restore players to full health. Left click with the Medical Kit to heal other players. Right click with the Medical Kit to heal yourself.",
			Color = Color( 47, 79, 79, 255 ),
			Models = { "models/player/kleiner.mdl" },
			Weapons = { "weapon_medkit" },
			Max = 2,
			Category = "Management"
		},
		{
			Name = "Service Official",
			Description = "As a Service Official, your job is to clean up the facility by painting over spills/stains, inspecting various machines, extinguishing fires, and cleaning up stray props. This is the only job that has unlimited access to maintenence areas around the facility. You are equipped with a fire extinguisher in case things get out of hand. If a fire does break out, contain it. If you see a fire that is spreading, call in for more service personnel help you contain the fire. You are also required to report any fires to the safety advisor or administrator.",
			Color = Color( 95, 158, 160, 255 ),
			Models = {
				"models/player/hdpp/male_05.mdl",
				"models/player/hdpp/male_06.mdl",
				"models/player/hdpp/male_09.mdl"
			},
			Weapons = { "weapon_extinguisher", "weapon_crowbar_hl", "weapon_pipewrench", "sw_weapon_dumpster", "sw_weapon_trashbag", "broom" },
			Max = 1,
			Category = "Management"
		},
		{
			Name = "Government Man",
			Description = "The Government Man (or G-Man) walks around the facility looking at the conditions of certain things. You should first take a tour with the administrator or head of security, then later talk with the Safety Advisor about things that could be improved. Once you are done with that, you can continue to walk around the facility asking the administrator questions if needed. Once you are free, you can spend the rest of your time looking at certain parts of the facility by yourself.",
			Color = Color( 0, 116, 140, 255 ),
			Models = { "models/player/gman_high.mdl" },
			Weapons = { "telebar" },
			Max = 1,
			Category = "Administration"
		},
		{
			Name = "HECU Marine",
			Description = "WARNING! CASCADE EVENT ONLY! USING THIS JOB WITHOUT ADMIN APPROVAL WILL GET YOU DEMOTED BACK TO CIVILIAN! As a HECU Marine, your job is to protect Black Mesa from major hazards that could mean life or death for Black Mesa personnel. You listen and take orders from the HECU Commander. Having this job is only recommended when security needs backup. Keep in mind that this job can only be accessed by volunteering to become a marine once the HECU Captain has announced that he is recruiting.",
			Color = Color( 56, 118, 29, 255 ),
			Models = { "models/player/gasmask_hecu.mdl" },
			Weapons = { "weapon_shotgun_hl", "weapon_9mmhandgun", "weapon_ram" },
			Max = 3,
			Category = "Military"
		},
		{
			Name = "HECU Captain",
			Description = "WARNING! CASCADE EVENT ONLY! USING THIS JOB WITHOUT ADMIN APPROVAL WILL GET YOU DEMOTED BACK TO CIVILIAN! As the HECU Captain, your job is to set up a team of marines to assist Black Mesa security in major hostile events. You can also command your marines in non-hostile events so they can patrol with security or help a fellow marine in training.",
			Color = Color( 56, 118, 29, 255 ),
			Models = { "models/player/gasmask_hecu.mdl" },
			Weapons = { "weapon_9mmar", "weapon_eagle", "weapon_ram" },
			Max = 1,
			Category = "Military"
		},
		{
			Name = "Weapon Specialist",
			Description = "As a Weapons Specialist, you are in charge of all weapons at Black Mesa. You are to supply your fellow marines as well as the Black Mesa Security Force with weapons. You can also request a custom weapon to be made by the weapons engineer, such as a self-destructing ground unit, or a drone with a mounted weapon.",
			Color = Color( 56, 118, 29, 255 ),
			Models = securitymodels,
			Weapons = { "weapon_shotgun_hl", "weapon_9mmhandgun" },
			Max = 1,
			Category = "Military"
		},
		{
			Name = "Weapons Engineer",
			Description = "As a weapons engineer, your job is to make, test, and modify weapons for the H.E.C.U. to use. If you are not assigned to a specific weapon to work on, have a talk with the H.E.C.U. Weapon Specialist and they will tell you what to work on. A general skill with wiremod turrets is recommended for this job.",
			Color = Color( 128, 0, 128, 255 ),
			Models = sciencemodels,
			Weapons = {},
			Max = 1,
			Category = "Science"
		},
		{
			Name = "Head of Security",
			Description = "As the Head of Security, your job is to command and take control of all security personnel. You are required to report to the Sector C test lab if the administrator calls for a test. You are also one of the few people who are required to pull the fire alarm in the event of an emergency. The fire alarm is in the room located next to the main entrance of Sector C.",
			Color = color_blue,
			Models = securitymodels,
			Weapons = { "weapon_357_hl", "weapon_shotgun_hl", "weapon_leash_police", "weapon_ram" },
			Max = 1,
			Category = "Security",
			IsCop = true
		},
		{
			Name = "Security Officer",
			Description = "As a Security Officer, your job is to protect Black Mesa from anything that may put anyone's life at risk or anything that may get in the way of working. You are permitted to set up checkpoints if you are alone in a Sector and feel that you need it. You can also request HECU assistance if things really get out of hand. If you do call them in though, they have permission to command you, whether you like it or not.",
			Color = color_blue,
			Models = securitymodels,
			Weapons = { "weapon_9mmhandgun", "weapon_leash_police", "weapon_ram" },
			Max = 3,
			Category = "Security",
			IsCop = true
		}
	},
	[2] = { --City 17 RP Jobs
		{
			Name = "Loyal Citizen",
			Description = "Loyal citizens are people who survived the Seven Hour War, and were relocated to City 17 to be forced into a form of slavery. Every loyal citizens top priority is to do what the Combine tells them to do. Local citizens are, as you might expect, loyal to the Combine and will do what they are told, so they are not permitted to craft weapons and fight the Combine.",
			Color = color_green,
			Models = civimodels,
			Weapons = { "rphands", "mgs_pickaxe" },
			Max = 0,
			Category = "Citizens"
		},
		{
			Name = "Refugee",
			Description = "Refugees are civilians of City 17 who have decided to fight against the combine. During City 17 RP , refugees are to start the uprising by crafting weapons and fighting the Combine. During Outland RP, refugees have the option to act as guards for rebel bases, but they can also choose to work by themselves or other refugees to create their own separate rebellion.",
			Color = Color( 28, 54, 9, 255 ),
			Models = civimodels,
			Weapons = { "rphands", "mgs_pickaxe" },
			Max = 0,
			Category = "Citizens"
		},
		{
			Name = "Resistance Leader",
			Description = "The resistance leader is in charge of commanding the rebel force. The resistance leader is also in charge of the rocket at the rebel base and when it launches. While in City 17, however, it is the resistance leader's duty to recruit any refugees who are looking to fight the combine. It is recommended that you say hidden indoors and underground. Since you are one of the highest ranking members of the resistance, you cannot afford to get yourself captured and forced by the combine to give out resistance intel.",
			Color = Color( 28, 54, 9, 255 ),
			Models = leadermodels,
			Weapons = { "weapon_smg1", "weapon_portal_pair", "weapon_agent" },
			Max = 1,
			Category = "Citizens"
		},
		{
			Name = "Scientist",
			Description = "As a scientist, you spawn inside the jails of the citadel. Your task is to follow any orders the Combine gives you and help them research advanced weapons and units through the science locker. If and when the rebels free you from the Combine, your task is then to help the rebels get to the top of the citadel to activate the detonation codes.",
			Color = Color( 128, 0, 128, 255 ),
			Models = sciencemodels,
			Weapons = {},
			Max = 1,
			Category = "Other"
		},
		{
			Name = "Vortigaunt",
			Description = "The vortigaunt is an alien species that has been enslaved by the Combine alongside humanity. Vorts are able to shoot fatal amounts of electricity from their hands and are very strong, allowing them to do things faster and easier compared to humans. By default, Vorts are under the rule of the Combine, but can be put under rebel command if given the opportunity.",
			Color = Color( 83, 107, 47, 255 ),
			Models = { "models/player/vortigaunt.mdl" },
			Weapons = { "swep_vortigaunt_beam", "mgs_pickaxe" },
			Max = 2,
			Category = "Other"
		},
		{
			Name = "Government Man",
			Description = "The Government Man for City 17 RP works like a spy. He can choose a side (combine or rebels) and help them by giving them advantages such as hidden base locations and attack plans. The Government Man can take two sides at once if he pleases. Players can turn on the Government Man if they have reason to believe he is a spy for the enemy, but they must have solid evidence before killing.",
			Color = Color( 0, 116, 140, 255 ),
			Models = { "models/player/gman_high.mdl" },
			Weapons = { "telebar" },
			Max = 1,
			Category = "Other"
		},
		{
			Name = "Earth's Administrator",
			Description = "Earth's Administrator is the former head of Black Mesa, and later named Earth's Admin under the Combine. From his headquarters on Earth in the Citadel of City 17, he is humanity's representative within the Combine.",
			Color = color_red,
			Models = { "models/player/breen.mdl" },
			Weapons = { "weapon_leash_police", "weapon_announcement", "door_ram_combine" },
			Max = 1,
			Category = "Combine"
		},
		{
			Name = "Overwatch Elite",
			Description = "Elites are tougher, achieve better accuracy with their weapons, and inflict more overall damage than regular soldiers do. They typically carry Overwatch Standard Issue Pulse Rifles, and are able to use the weapon's secondary fire Energy Ball. They use this advantage without hesitation and with deadly accuracy. Elites also may be picked to protect the Earth's Admin's office.",
			Color = Color( 255, 255, 187, 255 ),
			Models = { "models/player/combine_super_soldier.mdl" },
			Weapons = { "weapon_ar2", "weapon_frag", "door_ram_combine", "weapon_leash_police" },
			Max = 2,
			Category = "Combine"
		},
		{
			Name = "Cremator",
			Description = "The cremator, much like the HECU in BMRP, are to only be used in the most extreme circumstances that Combine forces cannot handle alone. Cremators are equipped with flamethrowers, a very effective tool especially against the undead.",
			Color = Color( 166, 130, 0, 255 ),
			Models = { "models/player/cremator_player.mdl" },
			Weapons = { "weapon_bp_flamethrower" },
			Max = 1,
			Category = "Combine"
		},
		{
			Name = "Overwatch Guard",
			Description = "The Overwatch Guard is in charge of guarding and maintaining the Citadel and any other places that may have a major Overwatch presence. Guards can also use Combine sniper rifles and stand guard on top of a building.",
			Color = Color( 60, 90, 126, 255 ),
			Models = { "models/player/combine_super_soldier.mdl" },
			Weapons = { "weapon_frag", "weapon_bp_binoculars", "door_ram_combine", "weapon_bp_sniper", "weapon_leash_police", "weapon_pistol", "weapon_medkit" },
			Max = 3,
			Category = "Combine"
		},
		{
			Name = "Overwatch Shotgunner Guard",
			Description = "The Overwatch Guard is in charge of guarding and maintaining the Citadel and any other places that may have a major Overwatch presence. This is a special sub-class of guard that replaces the sniper rifle and pistol with a shotgun. It needs to be unlocked via the Combine science locker to be used.",
			Color = Color( 30, 0, 0, 255 ),
			Models = { "models/player/combine_super_soldier.mdl" },
			Weapons = { "weapon_frag", "weapon_bp_binoculars", "door_ram_combine", "weapon_shotgun", "weapon_leash_police", "weapon_pistol", "weapon_medkit" },
			Max = 3,
			Category = "Combine"
		},
		{
			Name = "Overwatch Soldier",
			Description = "Overwatch Soldiers are the basic trans-human infantry units of the Combine Overwatch, composing the backbone of the Combine's military presence on Earth. In contrast to Civil Protection, whose duties are to enforce order within suppressed population centers, soldiers of the Overwatch are tasked with more hazardous actions requiring skill and tact: from patrolling the treacherous borders of Combine-controlled territory to raiding Resistance-held strongholds.",
			Color = Color( 128, 128, 128, 255 ),
			Models = { "models/player/combine_super_soldier.mdl" },
			Weapons = { "weapon_smg1", "weapon_frag", "weapon_bp_flaregun", "door_ram_combine", "weapon_leash_police" },
			Max = 4,
			Category = "Combine"
		},
		{
			Name = "Manhack Civil Protection",
			Description = "Civil Protection is essentially the Combine's thought police in all urban areas on Earth, including City 17. Part of the Combine Overwatch, CPs are ordinary human volunteers who have 'willingly' joined the Combine, either for more privileges, such as additional food, better living conditions, an increase in authority and status over others, or out of genuine sympathy and identification with the Combine's aims. As such, they are not bio-mechanically modified in any way, unlike the two other Overwatch units. This is a special sub-class of Civil Protection that gives the player access to controllable manhacks. It needs to be unlocked via the Combine science locker to be used.",
			Color = color_black,
			Models = cpmodels,
			Weapons = { "weapon_pistol", "weapon_stunstick", "weapon_bp_flaregun", "door_ram_combine", "weapon_leash_police" },
			Max = 1,
			Category = "Combine",
			IsCop = true
		},
		{
			Name = "Civil Protection",
			Description = "Civil Protection is essentially the Combine's thought police in all urban areas on Earth, including City 17. Part of the Combine Overwatch, CPs are ordinary human volunteers who have 'willingly' joined the Combine, either for more privileges, such as additional food, better living conditions, an increase in authority and status over others, or out of genuine sympathy and identification with the Combine's aims. As such, they are not bio-mechanically modified in any way, unlike the two other Overwatch units.",
			Color = color_black,
			Models = cpmodels,
			Weapons = { "weapon_pistol", "weapon_stunstick", "weapon_bp_flaregun", "door_ram_combine", "weapon_leash_police" },
			Max = 0,
			Category = "Combine",
			IsCop = true
		}
	},
	[3] = { --Outland RP Jobs
		{
			Name = "Refugee",
			Description = "Refugees are civilians of City 17 who have decided to fight against the combine. During City 17 RP , refugees are to start the uprising by crafting weapons and fighting the Combine. During Outland RP, refugees have the option to act as guards for rebel bases, but they can also choose to work by themselves or other refugees to create their own separate rebellion.",
			Color = Color( 28, 54, 9, 255 ),
			Models = civimodels,
			Weapons = { "rphands", "mgs_pickaxe" },
			Max = 0,
			Category = "Rebels",
			IsCop = true
		},
		{
			Name = "Resistance Leader",
			Description = "The resistance leader is in charge of commanding the rebel force. The resistance leader is also in charge of the rocket at the rebel base and when it launches. While in City 17, however, it is the resistance leader's duty to recruit any refugees who are looking to fight the combine. It is recommended that you say hidden indoors and underground. Since you are one of the highest ranking members of the resistance, you cannot afford to get yourself captured and forced by the combine to give out resistance intel.",
			Color = Color( 0, 128, 0, 255 ),
			Models = leadermodels,
			Weapons = { "weapon_smg1", "weapon_portal_pair", "weapon_agent" },
			Max = 1,
			Category = "Rebels",
			IsCop = true
		},
		{
			Name = "Rebel",
			Description = "Rebels are past civilians of City 17 who have joined the rebellion in order to stop the Combine and make the world free once again. Rebels are usually equipped with SMGs, however it is very possible to pick up better weapons dropped by killed Combine Soldiers.",
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
			IsCop = true
		},
		{
			Name = "Rebel Medic",
			Description = "Rebels are past civilians of City 17 who have joined the rebellion in order to stop the Combine and make the world free once again. Rebels are usually equipped with SMGs, however it is very possible to pick up better weapons dropped by killed Combine Soldiers.",
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
			Category = "Rebels"
		},
		{
			Name = "Overwatch Elite",
			Description = "Elites are tougher, achieve better accuracy with their weapons, and inflict more overall damage than regular soldiers do. They typically carry Overwatch Standard Issue Pulse Rifles, and are able to use the weapon's secondary fire Energy Ball. They use this advantage without hesitation and with deadly accuracy. Elites also may be picked to protect the Earth's Admin's office.",
			Color = Color( 255, 255, 187, 255 ),
			Models = { "models/player/combine_super_soldier.mdl" },
			Weapons = { "weapon_ar2", "weapon_frag", "door_ram_combine", "weapon_leash_police" },
			Max = 2,
			Category = "Combine"
		},
		{
			Name = "Overwatch Guard",
			Description = "The Overwatch Guard is in charge of guarding and maintaining the Citadel and any other places that may have a major Overwatch presence. Guards can also use Combine sniper rifles and stand guard on top of a building.",
			Color = Color( 60, 90, 126, 255 ),
			Models = { "models/player/combine_super_soldier.mdl" },
			Weapons = { "weapon_frag", "weapon_bp_binoculars", "door_ram_combine", "weapon_bp_sniper", "weapon_leash_police", "weapon_pistol", "weapon_medkit" },
			Max = 3,
			Category = "Combine"
		},
		{
			Name = "Overwatch Soldier",
			Description = "Overwatch Soldiers are the basic trans-human infantry units of the Combine Overwatch, composing the backbone of the Combine's military presence on Earth. In contrast to Civil Protection, whose duties are to enforce order within suppressed population centers, soldiers of the Overwatch are tasked with more hazardous actions requiring skill and tact: from patrolling the treacherous borders of Combine-controlled territory to raiding Resistance-held strongholds.",
			Color = Color( 128, 128, 128, 255 ),
			Models = { "models/player/combine_super_soldier.mdl" },
			Weapons = { "weapon_smg1", "weapon_frag", "weapon_bp_flaregun", "door_ram_combine", "weapon_leash_police" },
			Max = 0,
			Category = "Combine"
		},
		{
			Name = "Overwatch Shotgunner Guard",
			Description = "The Overwatch Guard is in charge of guarding and maintaining the Citadel and any other places that may have a major Overwatch presence. This is a special sub-class of guard that replaces the sniper rifle and pistol with a shotgun. It needs to be unlocked via the Combine science locker to be used.",
			Color = Color( 30, 0, 0, 255 ),
			Models = { "models/player/combine_super_soldier.mdl" },
			Weapons = { "door_ram_combine", "weapon_shotgun", "weapon_leash_police" },
			Max = 1,
			Category = "Combine"
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
function meta:IsJobCategory( category )
	local curgame = GetGlobalInt( "CurrentGamemode" )
	local job = self:Team()
	local jobtable = HLU_JOB[curgame][job]
	return jobtable.Category == category
end

function GM:Initialize()
	local curgame = GetGlobalInt( "CurrentGamemode" )
	for k,v in pairs( HLU_JOB[curgame] ) do
		team.SetUp( k, v.Name, v.Color )
	end
	if curgame == 1 then
		SetGlobalInt( "BMRP_Budget", 10000 )
	end
end
