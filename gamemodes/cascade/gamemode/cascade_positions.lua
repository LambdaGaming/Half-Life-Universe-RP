
--Positions where the HECU spawn
CASCADE_HECUPOS = {
	Vector( 4210, -1645, 704 ),
	Vector( 4211, -1584, 704 ),
	Vector( 4350, -1582, 704 ),
	Vector( 4351, -1650, 704 ),
	Vector( 4331, -1862, 704 ),
	Vector( 4525, -628, 704 ),
	Vector( 9068, -5845, 192 )
}

--Positions where players spawn when they die
CASCADE_DEADPOS = {
	Vector( -724, -1965, 64 ),
	Vector( -624, -1965, 64 ),
	Vector( -524, -1965, 64 ),
	Vector( -424, -1965, 64 ),
	Vector( -324, -1965, 64 )
}

--Positions where scientists spawn
CASCADE_SCIENTISTSPAWN = {
	Vector( -1086, -1909, 64 ),
	Vector( -1017, -1019, 64 ),
	Vector( 860, -2160, 64 ),
	Vector( -213, -996, 64 ),
	Vector( -1073, -2991, -1440 ),
	Vector( -3483, -3845, -1440 ),
	Vector( -3519, -4408, -1440 ),
	Vector( -2469, -4108, -1120 ),
	Vector( -2249, -2880, 288 ),
	Vector( -1012, -2844, 352 ),
	Vector( -972, -1983, 352 ),
	Vector( -1245, -707, 352 ),
	Vector( -761, -1480, 352 ),
	Vector( 9, -1083, 352 ),
	Vector( -634, -454, 382 ),
	Vector( 9379, -5841, 192 )
}

--Positions where the facility administrator spawns
CASCADE_ADMINPOS = {
	Vector( 997, -3727, 400 ),
	Vector( -1302, -4262, 352 ),
	Vector( 410, 2213, -64 ),
	Vector( -387, 2333, -63 ),
	Vector( 1116, 2350, -64 ),
	Vector( 9058, -3825, 192 )
}

--Positions where medics spawn
CASCADE_MEDICPOS = {
	Vector( -462, 1619, -63 ),
	Vector( -380, 2907, -64 ),
	Vector( 7313, -6358, 352 ),
	Vector( 8742, -3819, 192 ),
	Vector( -5157, 333, -112 )
}

--Positions where security spawns
CASCADE_SECURITYPOS = {
	Vector( 6230, -6011, 353 ),
	Vector( 7481, -5277, 353 ),
	Vector( 8677, -5687, 193 ),
	Vector( 5856, -375, -64 ),
	Vector( 5306, 355, 0 ),
	Vector( 4622, -284, -64 ),
	Vector( -5157, 70, -112 ),
	Vector( -9477, -1876, -64 )
}

--Positions where vortigaunts spawn
CASCADE_VORTPOS = {
	Vector( -14724, -14524, -14940 ),
	Vector( -14492, -13579, -14907 ),
	Vector( -13810, -14585, -14936 ),
	Vector( 935, -1573, 80 )
}

--Class names for primary weapons
CASCADE_PRIMARYCLASS = {
	"weapon_9mmar",
	"weapon_crossbow_hl",
	"weapon_m249",
	"weapon_rpg_hl",
	"weapon_shotgun_hl",
	"weapon_sniperrifle"
}

--Primary weapon spawns
CASCADE_PRIMARYPOS = {
	Vector( -6144, -146, -80 ),
	Vector( -3527, 2184, -4 ),
	Vector( -724, 2390, -28 ),
	Vector( 513, 2241, -28 ),
	Vector( -985, -1648, 389 ),
	Vector( 6200, -5975, 352 ),
	Vector( -642, -3385, -1440 )
}

--Class names for secondary weapons
CASCADE_SECONDARYCLASS = {
	"weapon_eagle",
	"weapon_9mmhandgun",
	"weapon_357_hl",
	"weapon_satchel",
	"weapon_tripmine",
	"weapon_handgrenade",
	"weapon_crowbar_hl",
	"weapon_knife",
	"weapon_pipewrench"
}

--Secondary weapon spawns
CASCADE_SECONDARYPOS = {
	Vector( -9487, -1969, -64 ),
	Vector( -6066, -1678, -64 ),
	Vector( -5489, -1077, -74 ),
	Vector( -4287, 2120, -27 ),
	Vector( -1093, 2404, 288 ),
	Vector( 615, 2953, -32 ),
	Vector( -304, 2873, -28 ),
	Vector( -201, -923, 160 ),
	Vector( -1043, -1399, 400 ),
	Vector( -1447, -2681, 400 ),
	Vector( -946, -4178, 388 ),
	Vector( 8677, -4834, 196 ),
	Vector( -2336, -4229, -1098 ),
	Vector( 1281, -2981, -1403 )
}

--Class names for special weapons
CASCADE_SPECIALCLASS = {
	"weapon_barnacle",
	"weapon_chumtoad",
	"weapon_displacer",
	"weapon_egon",
	"weapon_flechettegrenade",
	"weapon_freezinggun",
	"weapon_gauss",
	"weapon_hornetgun",
	"weapon_penguin",
	"weapon_shockrifle",
	"weapon_snark",
	"weapon_sporelauncher"
}

--Special weapon spawns
CASCADE_SPECIALPOS = {
	Vector( 86, -2506, -48 ),
	Vector( -485, -3376, -1440 ),
	Vector( 581, -3689, 400 ),
	Vector( -1153, -2850, 388 ),
	Vector( -2144, -2964, 318 ),
	Vector( -1138, -1953, 388 ),
	Vector( -1118, -764, 382 ),
	Vector( -613, -732, 388 ),
	Vector( -602, -1491, 388 ),
	Vector( -873, 2101, -1312 ),
	Vector( -10991, -1850, -32 ),
	Vector( -5309, -670, -87 )
}

--Positions and angles of the tram fixer spawns
CASCADE_TRAMFIXPOS = {
	{ Vector( 79, -3043, 164 ), Angle( 0, 180, 0 ) },
	{ Vector( -5767, -53, -43 ), Angle( 0, 0, 0 ) },
	{ Vector( 5409, -4939, 132 ), Angle( 0, 180, 0 ) },
	{ Vector( -2517, -4101, -1371 ), Angle( 0, -90, 0 ) },
	{ Vector( -2037, 2903, 28 ), Angle( 0, -90, 0 ) },
	{ Vector( 5729, -2059, -188 ), Angle( 0, 180, 0 ) }
}

--Positions for the escape vehicle
CASCADE_ESCAPEPOS = {
	Vector( -2970, -903, 704 ),
	Vector( -7662, -1887, 705 ),
	Vector( 4291, -1945, 704 ),
	Vector( 2801, 663, 691 )
}

--Positions for the armor batteries
CASCADE_ARMORPOS = {
	Vector( -5370, -432, -87 ),
	Vector( -5249, -526, -87 ),
	Vector( -5491, -1196, -74 ),
	Vector( -5471, -1059, -74 ),
	Vector( -5737, -1032, -93 ),
	Vector( -5250, -681, -87 ),
	Vector( 1232, -3318, -1432 ),
	Vector( 1153, -3314, -1432 ),
	Vector( 1305, -2974, -1403 ),
	Vector( 1183, -3276, -1432 ),
	Vector( 1113, -2967, -1403 ),
	Vector( 1645, -3194, -1404 ),
	Vector( 4684, -96, -56 ),
	Vector( 4683, -256, -56 ),
	Vector( 4432, -170, -56 ),
	Vector( 4677, 195, -27 ),
	Vector( 4274, 97, -45 ),
	Vector( 4474, 111, -39 )
}

--Positions for the GTerminal PC
CASCADE_PCPOS = {
	Vector( -5953, -271, -112 ),
	Vector( -5945, -327, -16 ),
	Vector( -2242, 3058, 8 ),
	Vector( -2091, 3026, -40 ),
	Vector( 778, 2183, -64 ),
	Vector( 777, 2244, -64 ),
	Vector( -1360, -1537, 352 ),
	Vector( -1359, -1596, 352 ),
	Vector( 6992, -6251, 388 ),
	Vector( -798, -5181, 392 )
}

MONSTER_POS = {
	Vector( 2192, -4962, 192 ),
	Vector( -627, -4618, 352 ),
	Vector( -919, -3827, 352 ),
	Vector( 289, -3486, 352 ),
	Vector( -1846, -3840, -1440 ),
	Vector( -2359, -4140, -1120 ),
	Vector( -604, -3112, -1440 ),
	Vector( -3126, -4684, -1439 ),
	Vector( 1317, -3188, -1440 ),
	Vector( -1698, -2038, 352 ),
	Vector( -2721, -213, 704 ),
	Vector( -2585, -1489, 208 ),
	Vector( -908, -1419, 64 ),
	Vector( 619, 295, -64 ),
	Vector( 4579, -519, -64 ),
	Vector( 5908, -394, -63 ),
	Vector( -138, 2260, -64 ),
	Vector( -151, 2732, -63 ),
	Vector( -4793, 2062, -64 ),
	Vector( -5825, -155, -112 ),
	Vector( -1150, 1328, -1088 ),
	Vector( 6851, -5744, 352 ),
	Vector( -9242, -1768, -63 ),
	Vector( -10420, -1537, -64 ),
	Vector( -8774, -1859, 705 )
}

CASCADE_MONSTERS = {
	"monster_alien_slv",
	"monster_agrunt",
	"monster_controller",
	"npc_headcrab",
	"npc_bullsquid",
	"monster_hound_eye",
	"monster_zombie_barney",
	"monster_zombie_scientist"
}

CASCADE_FIREBLOCK1 = {
	Vector( 4980, -608, -64 ),
	Vector( 4981, -570, -64 ),
	Vector( 4981, -538, -64 )
}

CASCADE_FIREBLOCK2 = {
	Vector( 2987, -1963, -243 ),
	Vector( 2987, -1913, -243 ),
	Vector( 2987, -1871, -243 ),
	Vector( 2987, -1814, -243 ),
	Vector( 2987, -1768, -243 )
}

CASCADE_FIREBLOCK3 = {
	Vector( -1861, -1351, 64 ),
	Vector( -1861, -1384, 64 ),
	Vector( -1861, -1421, 64 ),
	Vector( -1861, -1469, 64 )
}

CASCADE_FIREWALLPOS1 = { { Vector( 5005, -576, 7 ), Angle( -90, 135, -135 ) } } --First value is vector of invisible wall, second value is angle of the wall
CASCADE_FIREWALLPOS2 = { { Vector( 2971, -1842, -171 ), Angle( 90, 0, 0 ) } }
CASCADE_FIREWALLPOS3 = { { Vector( -1845, -1391, 126 ), Angle( -90, 0, 0 ) } }

CASCADE_RUBBLEPOS1 = { { Vector( -910, -3855, 405 ), Angle( -45, 0, 0 ) } }
CASCADE_RUBBLEPOS2 = { { Vector( -9231, -2121, 766 ), Angle( 0, 0, -45 ) } }
CASCADE_RUBBLEPOS3 = { { Vector( -1821, -1398, 419 ), Angle( -90, 180, 180 ) } }