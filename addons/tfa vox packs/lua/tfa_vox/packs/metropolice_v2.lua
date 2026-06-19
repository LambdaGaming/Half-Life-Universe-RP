local mdlprefix = "HL2_Metrocop"

local voxtable = {
	['main'] = {
		['crithit'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "crithit", { "npc/metropolice/vo/11-99officerneedsassistance.wav", "npc/metropolice/vo/officerneedshelp.wav", "npc/metropolice/vo/dispatchineed10-78.wav", "npc/metropolice/vo/officerneedsassistance.wav" } )
		},
		['death'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "death", { "npc/metropolice/die1.wav", "npc/metropolice/die2.wav", "npc/metropolice/die3.wav", "npc/metropolice/die4.wav" } )
		},
		['spawn'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "spawn", { "npc/metropolice/vo/inpositiononeready.wav", "npc/metropolice/vo/inposition.wav", "npc/metropolice/vo/readytojudge.wav", "npc/metropolice/vo/readytoprosecute.wav" } )
		},
		['reload'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "reload", { "npc/metropolice/vo/backmeupimout.wav", "npc/metropolice/vo/runninglowonverdicts.wav" } )
		},
		['noammo'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "noammo", { "npc/metropolice/vo/shit.wav", "npc/metropolice/vo/help.wav" } )
		},
		['fall'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "fall", { "ambient/wind/wind_gust_10.wav", "ambient/wind/wind_gust_2.wav", "ambient/wind/wind_snippet4.wav", "ambient/wind/wind_snippet5.wav" } )
		},
		['jump'] = {
			['sound'] = { "NPC_MetroPolice.RunFootstepLeft", "NPC_MetroPolice.RunFootstepRight" }
		},
		['step'] = {
			['sound'] = { "NPC_MetroPolice.RunFootstepLeft", "NPC_MetroPolice.RunFootstepRight" }
		}
	},
	['murder'] = {
		['zombie'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "murdzomb", { "npc/metropolice/vo/tagonenecrotic.wav", "npc/metropolice/vo/sterilize.wav" } )
		},
		['headcrab'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "murdhc", { "npc/metropolice/vo/tagoneparasitic.wav", "npc/metropolice/vo/sterilize.wav" } )
		},
		['antlion'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "murdant", { "npc/metropolice/vo/tagonebug.wav", "npc/metropolice/vo/sterilize.wav" } )
		},
		['barnacle'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "murdbarn", { "npc/metropolice/vo/tagoneparasitic.wav", "npc/metropolice/vo/sterilize.wav" } )
		},
		['ally'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "murdally", { "npc/metropolice/vo/sentencedelivered.wav", "npc/metropolice/vo/expired.wav", "npc/metropolice/vo/malignant.wav" } )
		},
		['generic'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "murdgener", { "npc/metropolice/vo/chuckle.wav", "npc/metropolice/vo/suspectisbleeding.wav", "npc/metropolice/vo/pacifying.wav", "npc/metropolice/vo/sterilize.wav", "npc/metropolice/vo/amputate.wav", "npc/metropolice/vo/expired.wav",  "npc/metropolice/vo/ten91dcountis.wav", "npc/metropolice/vo/tag10-91d.wav" } )
		}
	},
	['spot'] = {
		['zombie'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "spotzom", { "npc/metropolice/vo/freenecrotics.wav", "npc/metropolice/vo/necrotics.wav" } )
		},
		['headcrab'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "spothc", { "npc/metropolice/vo/non-taggedviromeshere.wav", "npc/metropolice/vo/looseparasitics.wav" } )
		},
		['barnacle'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "spotbarn", { "npc/metropolice/vo/non-taggedviromeshere.wav", "npc/metropolice/vo/looseparasitics.wav" } )
		},
		['antlion'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "spotant", { "npc/metropolice/vo/bugs.wav", "npc/metropolice/vo/bugsontheloose.wav", "npc/metropolice/vo/outlandbioticinhere.wav" } )
		},
		['manhack'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "spotmh", { "npc/metropolice/vo/lookoutrogueviscerator.wav", "npc/metropolice/vo/visceratorisoc.wav" } )
		},
		['ally'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "spotally", { "npc/metropolice/vo/clearandcode100.wav", "npc/metropolice/vo/controlsection.wav", "npc/metropolice/vo/novisualonupi.wav", "npc/metropolice/vo/protectioncomplete.wav", "npc/combine_soldier/vo/reportallradialsfree.wav", "npc/metropolice/vo/ten8standingby.wav", "npc/metropolice/vo/checkformiscount.wav", "npc/metropolice/vo/control100percent.wav" } )
		},
		['generic'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "spotgnrc", { "npc/metropolice/vo/movebackrightnow.wav", "npc/metropolice/vo/allunitscloseonsuspect.wav", "npc/metropolice/vo/allunitsreportlocationsuspect.wav", "npc/metropolice/vo/dontmove.wav", "npc/metropolice/vo/confirmpriority1sighted.wav", "npc/metropolice/vo/contactwith243suspect.wav", "npc/metropolice/vo/contactwithpriority2.wav", "npc/metropolice/vo/level3civilprivacyviolator.wav" } )
		}
	},
	['taunt'] = {
		[ACT_GMOD_GESTURE_AGREE] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "ACT_GMOD_GESTURE_AGREE", { "npc/metropolice/vo/affirmative.wav" } )
		},
		[ACT_GMOD_GESTURE_BECON] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "ACT_GMOD_GESTURE_BECON", { "npc/metropolice/vo/movebackrightnow.wav" } )
		},
		[ACT_GMOD_GESTURE_DISAGREE] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "ACT_GMOD_GESTURE_DISAGREE", { "npc/metropolice/vo/nocontact.wav", "npc/metropolice/vo/novisualonupi.wav" } )
		},
		[ACT_GMOD_TAUNT_SALUTE] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "ACT_GMOD_TAUNT_SALUTE", { "npc/metropolice/vo/administer.wav" } )
		},
		[ACT_GMOD_TAUNT_LAUGH] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "ACT_GMOD_TAUNT_LAUGH", { "npc/metropolice/vo/chuckle.wav" } )
		},
		[ACT_SIGNAL_FORWARD] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "ACT_SIGNAL_FORWARD", { "npc/metropolice/vo/move.wav", "npc/metropolice/vo/moveit.wav", "npc/metropolice/vo/moveit2.wav", "npc/metropolice/vo/keepmoving.wav" } )
		},
		[ACT_SIGNAL_HALT] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "ACT_SIGNAL_HALT", { "npc/metropolice/vo/dontmove.wav", "npc/metropolice/vo/holdit.wav", "npc/metropolice/vo/holditrightthere.wav" } )
		}
	},
	['damage'] = {
		[HITGROUP_GENERIC] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "HITGROUP_GENERIC", { "npc/metropolice/pain1.wav", "npc/metropolice/pain2.wav", "npc/metropolice/pain3.wav", "npc/metropolice/pain4.wav" } )
		}
	},
	['callouts'] = {
		['agree'] = {
			['name'] = "Agree",
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "Wheel_Agree", { "npc/metropolice/vo/affirmative.wav" } )
		},
		['disagree'] = {
			['name'] = "Disagree",
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "Wheel_Disagree", { "npc/metropolice/vo/nocontact.wav", "npc/metropolice/vo/novisualonupi.wav" } )
		},
		['halt'] = {
			['name'] = "Halt",
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "Wheel_Halt", { "npc/metropolice/vo/dontmove.wav", "npc/metropolice/vo/holdit.wav", "npc/metropolice/vo/holditrightthere.wav" } )
		},
		['laugh'] = {
			['name'] = "Laugh",
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "Wheel_Laugh", { "npc/metropolice/vo/chuckle.wav" } )
		},
		['move'] = {
			['name'] = "Move",
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "Wheel_Move", { "npc/metropolice/vo/move.wav", "npc/metropolice/vo/moveit.wav", "npc/metropolice/vo/moveit2.wav", "npc/metropolice/vo/keepmoving.wav" } )
		},
		['can'] = {
			['name'] = "Can It",
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "Wheel_CanIt", { "npc/metropolice/vo/pickupthecan1.wav", "npc/metropolice/vo/pickupthecan2.wav", "npc/metropolice/vo/pickupthecan3.wav" } )
		}
	},
	['calloutsextra'] = {
		['grenadecall'] = {
			['delay'] = 5,
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "grenadecall", { "npc/metropolice/vo/grenade.wav", "npc/metropolice/vo/thatsagrenade.wav", "npc/metropolice/vo/getdown.wav" })
		},
		['barrelcall'] = {
			['delay'] = 5,
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "barrelcall", { "npc/metropolice/vo/moveit.wav", "npc/metropolice/vo/lookout.wav" })
		},
		['killedbyenemy'] = {
			['delay'] = 5,
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "killedbyenemy", { "npc/metropolice/vo/wehavea10-108.wav", "npc/metropolice/vo/officerdowncode3tomy10-20.wav", "npc/metropolice/vo/cpisoverrunwehavenocontainment.wav" })
		}
	}
}

local models = {
	"models/player/police.mdl",
	"models/player/police_fem.mdl",
	"models/dpfilms/metropolice/playermodels/pm_arctic_police.mdl",
	"models/dpfilms/metropolice/playermodels/pm_biopolice.mdl",
	"models/dpfilms/metropolice/playermodels/pm_c08cop.mdl",
	"models/dpfilms/metropolice/playermodels/pm_civil_medic.mdl",
	"models/dpfilms/metropolice/playermodels/pm_black_police.mdl",
	"models/dpfilms/metropolice/playermodels/pm_skull_police.mdl",
	"models/dpfilms/metropolice/playermodels/pm_hl2beta_police.mdl",
	"models/dpfilms/metropolice/playermodels/pm_hl2concept.mdl",
	"models/dpfilms/metropolice/playermodels/pm_HDpolice.mdl",
	"models/dpfilms/metropolice/playermodels/pm_hunter_police.mdl",
	"models/dpfilms/metropolice/playermodels/pm_phoenix_police.mdl",
	"models/dpfilms/metropolice/playermodels/pm_police_bt.mdl",
	"models/dpfilms/metropolice/playermodels/pm_elite_police.mdl",
	"models/dpfilms/metropolice/playermodels/pm_rtb_police.mdl",
	"models/dpfilms/metropolice/playermodels/pm_female_police.mdl",
	"models/dpfilms/metropolice/playermodels/pm_policetrench.mdl",
	"models/dpfilms/metropolice/playermodels/pm_rogue_police.mdl",
	"models/dpfilms/metropolice/playermodels/pm_retrocop.mdl",
	"models/dpfilms/metropolice/playermodels/pm_urban_police.mdl"
}
for k,v in ipairs( models ) do
	TFAVOX_RegisterPack( v, voxtable )
end
