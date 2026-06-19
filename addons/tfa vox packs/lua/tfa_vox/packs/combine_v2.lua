local mdlprefix = "HL2_Combine_Soldier"

local voxtable = {
	['main'] = {
		['death'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "death", { "npc/combine_soldier/die1.wav", "npc/combine_soldier/die2.wav", "npc/combine_soldier/die3.wav" } )
		},
		['spawn'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "spawn", { "npc/combine_soldier/vo/teamdeployedandscanning.wav", "npc/combine_soldier/vo/priority1objective.wav", "npc/combine_soldier/vo/inbound.wav", "npc/combine_soldier/vo/unitismovingin.wav" } )
		},
		['reload'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "reload", { "npc/combine_soldier/vo/coverme.wav", "npc/combine_soldier/vo/cover.wav", "npc/combine_soldier/vo/readyweapons.wav" } )
		},
		['noammo'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "noammo", { "npc/combine_soldier/vo/cleaned.wav", "npc/combine_soldier/vo/gosharp.wav", "npc/combine_soldier/vo/ripcordripcord.wav" } )
		},
		['fall'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "fall", { "ambient/wind/wind_gust_10.wav", "ambient/wind/wind_gust_2.wav", "ambient/wind/wind_snippet4.wav", "ambient/wind/wind_snippet5.wav" } )
		},
		['jump'] = {
			['sound'] = { "NPC_CombineS.RunFootstepLeft", "NPC_CombineS.RunFootstepRight" }
		},
		['step'] = {
			['sound'] = { "NPC_CombineS.RunFootstepLeft", "NPC_CombineS.RunFootstepRight" } -- TFAVOX_GenerateSound( mdlprefix, "step", { "npc/combine_soldier/gear1.wav", "npc/combine_soldier/gear2.wav", "npc/combine_soldier/gear3.wav", "npc/combine_soldier/gear4.wav", "npc/combine_soldier/gear5.wav", "npc/combine_soldier/gear6.wav" } )
		}
	},
	['murder'] = {
		['zombie'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "murdzomb", { "npc/combine_soldier/vo/cleaned.wav", "npc/combine_soldier/vo/contained.wav", "npc/combine_soldier/vo/onedown.wav", "npc/combine_soldier/vo/onecontained.wav" })
		},
		['headcrab'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "murdhc", { "npc/combine_soldier/vo/cleaned.wav", "npc/combine_soldier/vo/contained.wav", "npc/combine_soldier/vo/onedown.wav", "npc/combine_soldier/vo/onecontained.wav" })
		},
		['antlion'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "murdant", { "npc/combine_soldier/vo/cleaned.wav", "npc/combine_soldier/vo/contained.wav", "npc/combine_soldier/vo/onedown.wav", "npc/combine_soldier/vo/onecontained.wav" })
		},
		['barnacle'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "murdbarn", { "npc/combine_soldier/vo/cleaned.wav", "npc/combine_soldier/vo/contained.wav", "npc/combine_soldier/vo/onedown.wav", "npc/combine_soldier/vo/onecontained.wav" })
		},
		['generic'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "murdgener", { "npc/combine_soldier/vo/targetblackout.wav", "npc/combine_soldier/vo/targetcompromisedmovein.wav", "npc/combine_soldier/vo/targetineffective.wav", "npc/combine_soldier/vo/thatsitwrapitup.wav", "npc/combine_soldier/vo/payback.wav", "npc/combine_soldier/vo/onedown.wav", "npc/combine_soldier/vo/onecontained.wav" } )
		}
	},
	['spot'] = {
		['combine'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "spotcomb", { "npc/combine_soldier/vo/contactconfim.wav", "npc/combine_soldier/vo/overwatch.wav", "npc/combine_soldier/vo/executingfullresponse.wav", "npc/combine_soldier/vo/target.wav", "npc/combine_soldier/vo/heavyresistance.wav", "npc/combine_soldier/vo/readyweaponshostilesinbound.wav" } )
		},
		['cp'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "spotcp", { "npc/combine_soldier/vo/callcontacttarget1.wav", "npc/combine_soldier/vo/contactconfim.wav", "npc/combine_soldier/vo/overwatch.wav", "npc/combine_soldier/vo/target.wav", "npc/combine_soldier/vo/readyweaponshostilesinbound.wav" } )
		},
		['zombie'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "spotzom", { "npc/combine_soldier/vo/infected.wav", "npc/combine_soldier/vo/necrotics.wav", "npc/combine_soldier/vo/necroticsinbound.wav", "npc/combine_soldier/vo/engagedincleanup.wav", "npc/combine_soldier/vo/outbreak.wav" } )
		},
		['headcrab'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "spothc", { "npc/combine_soldier/vo/callcontactparasitics.wav", "npc/combine_soldier/vo/antiseptic.wav", "npc/combine_soldier/vo/engagedincleanup.wav" } )
		},
		['manhack'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "spotmh", { "npc/combine_soldier/vo/callcontacttarget1.wav", "npc/combine_soldier/vo/contactconfim.wav", "npc/combine_soldier/vo/contactconfirmprosecuting.wav", "npc/combine_soldier/vo/overwatch.wav" } )
		},
		['scanner'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "spotscn", { "npc/combine_soldier/vo/callcontacttarget1.wav", "npc/combine_soldier/vo/contactconfim.wav", "npc/combine_soldier/vo/contactconfirmprosecuting.wav", "npc/combine_soldier/vo/overwatch.wav" } )
		},
		['sniper'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "spotsni", { "npc/combine_soldier/vo/ghost.wav", "npc/combine_soldier/vo/ghost2.wav", "npc/combine_soldier/vo/fixsightlinesmovein.wav" } )
		},
		['turret'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "spottur", { "npc/combine_soldier/vo/callcontacttarget1.wav", "npc/combine_soldier/vo/contactconfim.wav", "npc/combine_soldier/vo/contactconfirmprosecuting.wav", "npc/combine_soldier/vo/executingfullresponse.wav", "npc/combine_soldier/vo/target.wav", "npc/combine_soldier/vo/heavyresistance.wav" } )
		},
		['ally'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "spotally", { "npc/combine_soldier/vo/hasnegativemovement.wav", "npc/combine_soldier/vo/reportingclear.wav", "npc/combine_soldier/vo/reportallpositionsclear.wav", "npc/combine_soldier/vo/contactconfirmprosecuting.wav", "npc/combine_soldier/vo/reportallradialsfree.wav", "npc/combine_soldier/vo/sectorissecurenovison.wav", "npc/combine_soldier/vo/stabilizationteamhassector.wav", "npc/combine_soldier/vo/stayalertreportsightlines.wav" } )
		},
		['generic'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "spotgnrc", { "npc/combine_soldier/vo/callcontacttarget1.wav", "npc/combine_soldier/vo/contactconfim.wav", "npc/combine_soldier/vo/contactconfirmprosecuting.wav", "npc/combine_soldier/vo/executingfullresponse.wav", "npc/combine_soldier/vo/target.wav", "npc/combine_soldier/vo/readyweaponshostilesinbound.wav" } )
		}
	},
	['taunt'] = {
		[ACT_GMOD_GESTURE_AGREE] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "ACT_GMOD_GESTURE_AGREE", { "npc/combine_soldier/vo/affirmative.wav", "npc/combine_soldier/vo/affirmative2.wav" } )
		},
		[ACT_GMOD_GESTURE_BECON] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "ACT_GMOD_GESTURE_BECON", { "npc/combine_soldier/vo/closing.wav" } )
		},
		[ACT_GMOD_GESTURE_DISAGREE] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "ACT_GMOD_GESTURE_DISAGREE", { "npc/combine_soldier/vo/sundown.wav", "npc/combine_soldier/vo/noviscon.wav" } )
		},
		[ACT_GMOD_TAUNT_SALUTE] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "ACT_GMOD_TAUNT_SALUTE", { "npc/combine_soldier/vo/administer.wav" } )
		},
		[ACT_GMOD_TAUNT_LAUGH] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "ACT_GMOD_TAUNT_LAUGH", { "npc/metropolice/vo/chuckle.wav" } )
		},
		[ACT_GMOD_GESTURE_POINT] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "ACT_GMOD_GESTURE_POINT", { "npc/combine_soldier/vo/movein.wav", "npc/combine_soldier/vo/alert1.wav", "npc/combine_soldier/vo/gosharp.wav", "npc/combine_soldier/vo/gosharpgosharp.wav" } )
		},
		[ACT_GMOD_TAUNT_CHEER] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "ACT_GMOD_TAUNT_CHEER", { "npc/combine_soldier/vo/sectorissecurenovison.wav", "npc/combine_soldier/vo/stabilizationteamhassector.wav", "npc/combine_soldier/vo/reportallpositionsclear.wav", "npc/combine_soldier/vo/reportallradialsfree.wav" } )
		},
		[ACT_SIGNAL_FORWARD] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "ACT_SIGNAL_FORWARD", { "npc/combine_soldier/vo/movein.wav", "npc/combine_soldier/vo/alert1.wav", "npc/combine_soldier/vo/gosharp.wav", "npc/combine_soldier/vo/gosharpgosharp.wav" } )
		},
	},
	['damage'] = {
		[HITGROUP_GENERIC] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "HITGROUP_GENERIC", { "npc/combine_soldier/pain1.wav", "npc/combine_soldier/pain2.wav", "npc/combine_soldier/pain3.wav" } )
		}
	},
	['callouts'] = {
		['agree'] = {
			['name'] = "Agree",
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "Wheel_Agree", { "npc/combine_soldier/vo/affirmative.wav", "npc/combine_soldier/vo/affirmative2.wav" } )
		},
		['disagree'] = {
			['name'] = "Disagree",
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "Wheel_Disagree", { "npc/combine_soldier/vo/sundown.wav", "npc/combine_soldier/vo/noviscon.wav" } )
		},
		['clear'] = {
			['name'] = "Clear",
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "Wheel_Clear", { "npc/combine_soldier/vo/secure.wav", "npc/combine_soldier/vo/assaultpointsecureadvance.wav", "npc/combine_soldier/vo/sectorissecurenovison.wav", "npc/combine_soldier/vo/hasnegativemovement.wav", "npc/combine_soldier/vo/vo/overwatchconfirmhvtcontained.wav" } )
		},
		['help'] = {
			['name'] = "Help",
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "Wheel_Help", { "npc/combine_soldier/vo/coverme.wav", "npc/combine_soldier/vo/isfinalteamunitbackup.wav", "npc/combine_soldier/vo/overwatchrequestreinforcement.wav" } )
		},
		['go'] = {
			['name'] = "Move Out",
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "Wheel_MoveOut", { "npc/combine_soldier/vo/fixsightlinesmovein.wav", "npc/combine_soldier/vo/gosharp.wav", "npc/combine_soldier/vo/gosharpgosharp.wav", "npc/combine_soldier/vo/displace.wav", "npc/combine_soldier/vo/displace2.wav" } )
		},
		['laugh'] = {
			['name'] = "Laugh",
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "Wheel_Laugh", { "npc/metropolice/vo/chuckle.wav" } )
		},
		['taunt'] = {
			['name'] = "Taunt",
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "Wheel_Taunt", { "npc/metropolice/vo/chuckle.wav" , "npc/combine_soldier/vo/thatsitwrapitup.wav" } )
		},
		['heal'] = {
			['name'] = "Heal Me",
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "Wheel_HealMe", { "npc/combine_soldier/vo/requestmedical.wav", "npc/combine_soldier/vo/requeststimdose.wav" } )
		}
	},
	['calloutsextra'] = {
		['grenadecall'] = {
			['delay'] = 5,
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "grenadecall", { "npc/combine_soldier/vo/bouncerbouncer.wav", "npc/combine_soldier/vo/flaredown.wav", "npc/combine_soldier/vo/displace.wav", "npc/combine_soldier/vo/displace2.wav" })
		},
		['grenadecallself'] = {
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "grenadecallself", { "npc/combine_soldier/vo/extractoraway.wav", "npc/combine_soldier/vo/extractorislive.wav" })
		},
		['barrelcall'] = {
			['delay'] = 5,
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "barrelcall", { "npc/combine_soldier/vo/displace.wav", "npc/combine_soldier/vo/displace2.wav", "npc/combine_soldier/vo/ripcordripcord.wav" })
		},
		['killedbyenemy'] = {
			['delay'] = 5,
			['sound'] = TFAVOX_GenerateSound( mdlprefix, "killedbyenemy", { "npc/combine_soldier/vo/onedown.wav", "npc/combine_soldier/vo/onedutyvacated.wav", "npc/combine_soldier/vo/heavyresistance.wav", "npc/combine_soldier/vo/overwatchrequestreinforcement.wav" })
		}
	}
}

TFAVOX_RegisterPack("models/player/combine_soldier.mdl", voxtable)
TFAVOX_RegisterPack("models/player/combine_soldier_prisonguard.mdl", voxtable)
TFAVOX_RegisterPack("models/player/combine_super_soldier.mdl", voxtable)
