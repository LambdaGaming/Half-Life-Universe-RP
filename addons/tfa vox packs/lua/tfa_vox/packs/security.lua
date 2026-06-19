local mdl = "security"
local voxTable = {
	["main"] = {
		["crithealth"] = {
			["sound"] = TFAVOX_GenerateSound( mdl, "crithealth", { "vj_hlr/gsrc/npc/barney/hitbad.wav", "vj_hlr/gsrc/npc/barney/imdead.wav", "vj_hlr/gsrc/npc/barney/imhit.wav" } )
		},
		["death"] = {
			["sound"] = TFAVOX_GenerateSound( mdl, "death", { "vj_hlr/gsrc/npc/barney/ba_die1.wav", "vj_hlr/gsrc/npc/barney/ba_die2.wav", "vj_hlr/gsrc/npc/barney/ba_die3.wav", "vj_hlr/gsrc/npc/barney/ba_ht06_02.wav" } )
		},
		["spawn"] = {
			["sound"] = TFAVOX_GenerateSound( mdl, "spawn", { "vj_hlr/gsrc/npc/barney/hellonicesuit.wav", "vj_hlr/gsrc/npc/barney/heyfella.wav", "vj_hlr/gsrc/npc/barney/howyoudoing.wav" } )
		},
		["noammo"] = {
			["sound"] = TFAVOX_GenerateSound( mdl, "noammo", { "vj_hlr/gsrc/npc/barney/c1a2_ba_4zomb.wav" } )
		},
		["fall"] = {
			["sound"] = TFAVOX_GenerateSound( mdl, "fall", { "vj_hlr/gsrc/npc/barney/ba_canal_death1.wav", "vj_hlr/gsrc/npc/barney/ba_heeey.wav" } )
		}
	},
	["murder"] = {
		["generic"] = {
			["sound"] = TFAVOX_GenerateSound( mdl, "HITGROUP_GENERIC", { "vj_hlr/gsrc/npc/barney/ba_another.wav", "vj_hlr/gsrc/npc/barney/ba_buttugly.wav", "vj_hlr/gsrc/npc/barney/ba_close.wav", "vj_hlr/gsrc/npc/barney/ba_firepl.wav", "vj_hlr/gsrc/npc/barney/ba_gotone.wav", "vj_hlr/gsrc/npc/barney/ba_seethat.wav" } )
		}
	},
	["damage"] = {
		[HITGROUP_GENERIC] = {
			["sound"] = TFAVOX_GenerateSound( mdl, "HITGROUP_GENERIC", { "vj_hlr/gsrc/npc/barney/ba_pain1.wav", "vj_hlr/gsrc/npc/barney/ba_pain2.wav", "vj_hlr/gsrc/npc/barney/ba_pain3.wav" } )
		}
	},
	["callouts"] = {
		["agree"] = {
			["name"] = "Agree",
			["sound"] = TFAVOX_GenerateSound( mdl, "callout_agree", { "vj_hlr/gsrc/npc/barney/iguess.wav", "vj_hlr/gsrc/npc/barney/ireckon.wav", "vj_hlr/gsrc/npc/barney/maybe.wav", "vj_hlr/gsrc/npc/barney/soundsright.wav", "vj_hlr/gsrc/npc/barney/yessir.wav", "vj_hlr/gsrc/npc/barney/youbet.wav", "vj_hlr/gsrc/npc/barney/yougotit.wav", "vj_hlr/gsrc/npc/barney/yup.wav" } )
		},
		["disagree"] = {
			["name"] = "Disagree",
			["sound"] = TFAVOX_GenerateSound( mdl, "callout_disagree", { "vj_hlr/gsrc/npc/barney/ba_crazy.wav", "vj_hlr/gsrc/npc/barney/cantfigure.wav", "vj_hlr/gsrc/npc/barney/dontbet.wav", "vj_hlr/gsrc/npc/barney/dontfigure.wav", "vj_hlr/gsrc/npc/barney/dontguess.wav", "vj_hlr/gsrc/npc/barney/dontreckon.wav", "vj_hlr/gsrc/npc/barney/justdontknow.wav", "vj_hlr/gsrc/npc/barney/nope.wav", "vj_hlr/gsrc/npc/barney/nosir.wav", "vj_hlr/gsrc/npc/barney/noway.wav" } )
		},
		["greeting"] = {
			["name"] = "Greeting",
			["sound"] = TFAVOX_GenerateSound( mdl, "callout_greeting", { "vj_hlr/gsrc/npc/barney/ba_hello1.wav", "vj_hlr/gsrc/npc/barney/ba_hello3.wav", "vj_hlr/gsrc/npc/barney/hellonicesuit.wav", "vj_hlr/gsrc/npc/barney/heyfella.wav", "vj_hlr/gsrc/npc/barney/howyoudoing.wav" } )
		},
		["comment"] = {
			["name"] = "Disaster Comment",
			["sound"] = TFAVOX_GenerateSound( mdl, "callout_comment", { "vj_hlr/gsrc/npc/barney/ambush.wav", "vj_hlr/gsrc/npc/barney/ba_idle0.wav", "vj_hlr/gsrc/npc/barney/badarea.wav", "vj_hlr/gsrc/npc/barney/badfeeling.wav", "vj_hlr/gsrc/npc/barney/beertopside.wav", "vj_hlr/gsrc/npc/barney/bigmess.wav", "vj_hlr/gsrc/npc/barney/bigplace.wav", "vj_hlr/gsrc/npc/barney/coldone.wav", "vj_hlr/gsrc/npc/barney/crewdied.wav", "vj_hlr/gsrc/npc/barney/getanyworse.wav", "vj_hlr/gsrc/npc/barney/aintscared.wav", "vj_hlr/gsrc/npc/barney/guyresponsible.wav", "vj_hlr/gsrc/npc/barney/hearsomething2.wav", "vj_hlr/gsrc/npc/barney/luckwillturn.wav", "vj_hlr/gsrc/npc/barney/missingleg.wav", "vj_hlr/gsrc/npc/barney/nodrill.wav", "vj_hlr/gsrc/npc/barney/somethingdied.wav", "vj_hlr/gsrc/npc/barney/somethingmoves.wav", "vj_hlr/gsrc/npc/barney/somethingstinky.wav", "vj_hlr/gsrc/npc/barney/survive.wav", "vj_hlr/gsrc/npc/barney/targetpractice.wav", "vj_hlr/gsrc/npc/barney/wayout.wav", "vj_hlr/gsrc/npc/barney/whatsgoingon.wav", "vj_hlr/gsrc/npc/barney/workingonstuff.wav" } )
		},
		["attack"] = {
			["name"] = "Call to Attack",
			["sound"] = TFAVOX_GenerateSound( mdl, "callout_attack", { "vj_hlr/gsrc/npc/barney/aimforhead.wav", "vj_hlr/gsrc/npc/barney/ba_attack1.wav", "vj_hlr/gsrc/npc/barney/ba_attacking1.wav", "vj_hlr/gsrc/npc/barney/ba_attacking2.wav", "vj_hlr/gsrc/npc/barney/ba_openfire.wav", "vj_hlr/gsrc/npc/barney/c1a4_ba_octo4.wav", "vj_hlr/gsrc/npc/barney/c1a4_ba_octo1.wav", "vj_hlr/gsrc/npc/barney/diebloodsucker.wav" } )
		},
		["taunt"] = {
			["name"] = "Taunt Enemy",
			["sound"] = TFAVOX_GenerateSound( mdl, "callout_taunt", { "vj_hlr/gsrc/npc/barney/ba_becareful1.wav", "vj_hlr/gsrc/npc/barney/ba_bring.wav", "vj_hlr/gsrc/npc/barney/ba_dontmake.wav", "vj_hlr/gsrc/npc/barney/ba_dotoyou.wav", "vj_hlr/gsrc/npc/barney/ba_endline.wav", "vj_hlr/gsrc/npc/barney/ba_iwish.wav", "vj_hlr/gsrc/npc/barney/ba_shot7.wav", "vj_hlr/gsrc/npc/barney/ba_somuch.wav", "vj_hlr/gsrc/npc/barney/ba_stepoff.wav", "vj_hlr/gsrc/npc/barney/ba_tomb.wav", "vj_hlr/gsrc/npc/barney/ba_uwish.wav", "vj_hlr/gsrc/npc/barney/c1a4_ba_octo2.wav", "vj_hlr/gsrc/npc/barney/c1a4_ba_octo3.wav", "vj_hlr/gsrc/npc/barney/easily.wav", "vj_hlr/gsrc/npc/barney/standback.wav" } )
		}
	}
}

local models = {
	"models/player/hlew/security/barney_security_extended.mdl",
	"models/player/hlew/security/barniel_security_extended.mdl",
	"models/player/hlew/security/bernard_security_extended.mdl",
	"models/player/hlew/security/bill_security_extended.mdl",
	"models/player/hlew/security/calhoun_security_extended.mdl",
	"models/player/hlew/security/clint_security_extended.mdl",
	"models/player/hlew/security/dan_security_extended.mdl",
	"models/player/hlew/security/jack_security_extended.mdl",
	"models/player/hlew/security/jonny_security_extended.mdl",
	"models/player/hlew/security/kate_security_extended.mdl",
	"models/player/hlew/security/leonel_security_extended.mdl",
	"models/player/hlew/security/louis_security_extended.mdl",
	"models/player/hlew/security/marley_security_extended.mdl",
	"models/player/hlew/security/mike_security_extended.mdl",
	"models/player/hlew/security/otis_security_extended.mdl",
	"models/player/hlew/security/phill_security_extended.mdl",
	"models/player/hlew/security/roger_security_extended.mdl",
	"models/player/hlew/security/steve_security_extended.mdl",
	"models/player/hlew/security/susanne_security_extended.mdl",
	"models/player/hlew/security/ted_security_extended.mdl",
	"models/player/hlew/security/tex_security_extended.mdl",
	"models/player/hlew/security/tommy_security_extended.mdl",
	"models/player/hlew/security/tremors_security_extended.mdl"
}
for k,v in ipairs( models ) do
	TFAVOX_RegisterPack( v, voxTable )
end
