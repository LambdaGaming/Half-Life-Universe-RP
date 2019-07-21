
GM.Name 	= "Half-Life Universe RP"
GM.Author 	= "Lambda Gaming" 
GM.Email 	= "N/A" 
GM.Website 	= "N/A" 

DeriveGamemode( "sandbox" )

print( "Loading cascade shared..." )

TEAM_VISITOR = {
	ID = 1,
	Playermodel = {
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
}

TEAM_MEDIC = {
	ID = 2,
	Playermodel = {
		"models/player/kleiner.mdl"
	}
}

TEAM_SCIENTIST = {
	ID = 3,
	Playermodel = {
		"models/player/hdpp/gordon.mdl",
		"models/player/hdpp/male_01.mdl",
		"models/player/hdpp/male_02.mdl",
		"models/player/hdpp/male_03.mdl",
		"models/player/hdpp/male_05.mdl",
		"models/player/hdpp/male_06.mdl",
		"models/player/hdpp/male_09.mdl",
		"models/Player/hdpp/barney.mdl",
		"models/player/hdpp/kleiner.mdl",
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
		"models/player/Group01/Male_09.mdl",
		"models/player/sgg/hev_helmet.mdl",
		"models/hazmat/bmhaztechs.mdl"
	}
}

TEAM_MARINE = {
	ID = 4,
	Playermodel = {
		"models/player/gasmask_hecu.mdl"
	}
}

TEAM_SECURITY = {
	ID = 5,
	Playermodel = {
		"models/player/hdpp/security/male_05.mdl",
		"models/player/hdpp/security/male_06.mdl",
		"models/player/hdpp/security/male_09.mdl",
		"models/player/hdpp/security/barney.mdl"
	}
}

TEAM_ADMIN = {
	ID = 6,
	Playermodel = {
		"models/player/breen.mdl"
	}
}

TEAM_ZOMBIE = {
	ID = 7,
	Playermodel = {
		"models/player/zombie_classic.mdl"
	}
}

TEAM_VORT = {
	ID = 8,
	Playermodel = {
		"models/player/vortigaunt.mdl"
	}
}

function GM:CreateTeams()
	team.SetUp( 1, "Visitor", Color( 20, 150, 20, 255 ), true )
	team.SetUp( 2, "Medic", Color( 47, 79, 79, 255 ), true )
	team.SetUp( 3, "Scientist", Color( 128, 0, 128, 255 ), true )
	team.SetUp( 4, "HECU Marine", Color( 56, 118, 29, 255 ), true )
	team.SetUp( 5, "Security Officer", Color( 0, 0, 255, 255 ), true )
	team.SetUp( 6, "Facility Administrator", Color( 255, 0, 0, 255 ), true )
	team.SetUp( 7, "Zombie", Color( 138, 143, 9, 255 ), true )
	team.SetUp( 8, "Vortigaunt", Color( 106, 194, 119, 255 ), true )
end