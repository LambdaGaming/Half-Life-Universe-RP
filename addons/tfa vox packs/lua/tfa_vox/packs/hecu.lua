local mdl = "hecu"
local voxTable = {
	["main"] = {
		["crithealth"] = {
			["sound"] = TFAVOX_GenerateSound( mdl, "crithealth", { "vj_hlr/gsrc/npc/hgrunt_opf/sdamage.wav", "vj_hlr/gsrc/npc/hgrunt_opf/critical.wav", "vj_hlr/gsrc/npc/hgrunt_opf/fwound.wav", "vj_hlr/gsrc/npc/hgrunt_opf/imhit.wav", "vj_hlr/gsrc/npc/hgrunt_opf/makeit.wav" } )
		},
		["death"] = {
			["sound"] = TFAVOX_GenerateSound( mdl, "death", { "vj_hlr/gsrc/npc/hgrunt_opf/death1.wav", "vj_hlr/gsrc/npc/hgrunt_opf/death2.wav", "vj_hlr/gsrc/npc/hgrunt_opf/death3.wav", "vj_hlr/gsrc/npc/hgrunt_opf/death4.wav", "vj_hlr/gsrc/npc/hgrunt_opf/death5.wav", "vj_hlr/gsrc/npc/hgrunt_opf/death6.wav" } )
		},
		["spawn"] = {
			["sound"] = TFAVOX_GenerateSound( mdl, "spawn", { "vj_hlr/gsrc/npc/hgrunt_opf/hellosir.wav", "vj_hlr/gsrc/npc/hgrunt_opf/sir_01.wav" } )
		},
		["noammo"] = {
			["sound"] = TFAVOX_GenerateSound( mdl, "noammo", { "vj_hlr/gsrc/npc/hgrunt_opf/suppressing.wav" } )
		},
		["fall"] = {
			["sound"] = TFAVOX_GenerateSound( mdl, "fall", { "vj_hlr/gsrc/npc/hgrunt_opf/death1.wav" } )
		}
	},
	["murder"] = {
		["generic"] = {
			["sound"] = TFAVOX_GenerateSound( mdl, "HITGROUP_GENERIC", { "vj_hlr/gsrc/npc/hgrunt_opf/corporal.wav", "vj_hlr/gsrc/npc/hgrunt_opf/now.wav", "vj_hlr/gsrc/npc/hgrunt_opf/oneshot.wav" } )
		}
	},
	["damage"] = {
		[HITGROUP_GENERIC] = {
			["sound"] = TFAVOX_GenerateSound( mdl, "HITGROUP_GENERIC", { "vj_hlr/gsrc/npc/hgrunt_opf/gr_pain1.wav", "vj_hlr/gsrc/npc/hgrunt_opf/gr_pain2.wav", "vj_hlr/gsrc/npc/hgrunt_opf/gr_pain3.wav", "vj_hlr/gsrc/npc/hgrunt_opf/gr_pain4.wav", "vj_hlr/gsrc/npc/hgrunt_opf/gr_pain5.wav", "vj_hlr/gsrc/npc/hgrunt_opf/gr_pain6.wav" } )
		}
	},
	["callouts"] = {
		["agree"] = {
			["name"] = "Agree",
			["sound"] = TFAVOX_GenerateSound( mdl, "callout_agree", { "vj_hlr/gsrc/npc/hgrunt_opf/roger.wav", "vj_hlr/gsrc/npc/hgrunt_opf/sir.wav", "vj_hlr/gsrc/npc/hgrunt_opf/siryessir.wav", "vj_hlr/gsrc/npc/hgrunt_opf/yes.wav" } )
		},
		["disagree"] = {
			["name"] = "Disagree",
			["sound"] = TFAVOX_GenerateSound( mdl, "callout_disagree", { "vj_hlr/gsrc/npc/hgrunt_opf/no.wav" } )
		},
		["greeting"] = {
			["name"] = "Greeting",
			["sound"] = TFAVOX_GenerateSound( mdl, "callout_greeting", { "vj_hlr/gsrc/npc/hgrunt_opf/hellosir.wav", "vj_hlr/gsrc/npc/hgrunt_opf/sir_01.wav" } )
		},
		["comment"] = {
			["name"] = "All Clear",
			["sound"] = TFAVOX_GenerateSound( mdl, "callout_clear", { "vj_hlr/gsrc/npc/hgrunt_opf/allclear.wav", "vj_hlr/gsrc/npc/hgrunt_opf/area.wav", "vj_hlr/gsrc/npc/hgrunt_opf/check.wav", "vj_hlr/gsrc/npc/hgrunt_opf/nohostiles.wav", "vj_hlr/gsrc/npc/hgrunt_opf/nomovement.wav" } )
		},
		["disaster"] = {
			["name"] = "Disaster Comment",
			["sound"] = TFAVOX_GenerateSound( mdl, "callout_disaster", { "vj_hlr/gsrc/npc/hgrunt_opf/babysitting.wav", "vj_hlr/gsrc/npc/hgrunt_opf/bfeeling.wav", "vj_hlr/gsrc/npc/hgrunt_opf/charge.wav", "vj_hlr/gsrc/npc/hgrunt_opf/chicken.wav", "vj_hlr/gsrc/npc/hgrunt_opf/coverup.wav", "vj_hlr/gsrc/npc/hgrunt_opf/current.wav", "vj_hlr/gsrc/npc/hgrunt_opf/disney.wav", "vj_hlr/gsrc/npc/hgrunt_opf/dogs.wav", "vj_hlr/gsrc/npc/hgrunt_opf/fubar.wav", "vj_hlr/gsrc/npc/hgrunt_opf/lost.wav", "vj_hlr/gsrc/npc/hgrunt_opf/mission.wav", "vj_hlr/gsrc/npc/hgrunt_opf/outof.wav", "vj_hlr/gsrc/npc/hgrunt_opf/seensquad.wav", "vj_hlr/gsrc/npc/hgrunt_opf/short.wav" } )
		},
		["attack"] = {
			["name"] = "Call to Attack",
			["sound"] = TFAVOX_GenerateSound( mdl, "callout_attack", { "vj_hlr/gsrc/npc/hgrunt_opf/alert.wav", "vj_hlr/gsrc/npc/hgrunt_opf/alien.wav", "vj_hlr/gsrc/npc/hgrunt_opf/backup.wav", "vj_hlr/gsrc/npc/hgrunt_opf/bogies.wav", "vj_hlr/gsrc/npc/hgrunt_opf/clear.wav", "vj_hlr/gsrc/npc/hgrunt_opf/covering.wav", "vj_hlr/gsrc/npc/hgrunt_opf/flank.wav", "vj_hlr/gsrc/npc/hgrunt_opf/freaks.wav", "vj_hlr/gsrc/npc/hgrunt_opf/go.wav", "vj_hlr/gsrc/npc/hgrunt_opf/hostiles.wav", "vj_hlr/gsrc/npc/hgrunt_opf/marines.wav", "vj_hlr/gsrc/npc/hgrunt_opf/move.wav", "vj_hlr/gsrc/npc/hgrunt_opf/moveup.wav", "vj_hlr/gsrc/npc/hgrunt_opf/rapidfire.wav", "vj_hlr/gsrc/npc/hgrunt_opf/recon.wav", "vj_hlr/gsrc/npc/hgrunt_opf/sweep.wav" } )
		},
		["taunt"] = {
			["name"] = "Taunt Enemy",
			["sound"] = TFAVOX_GenerateSound( mdl, "callout_taunt", { "vj_hlr/gsrc/npc/hgrunt_opf/ass.wav", "vj_hlr/gsrc/npc/hgrunt_opf/getsome.wav", "vj_hlr/gsrc/npc/hgrunt_opf/killer.wav", "vj_hlr/gsrc/npc/hgrunt_opf/mister.wav", "vj_hlr/gsrc/npc/hgrunt_opf/nothing.wav", "vj_hlr/gsrc/npc/hgrunt_opf/tag.wav", "vj_hlr/gsrc/npc/hgrunt_opf/take.wav", "vj_hlr/gsrc/npc/hgrunt_opf/wantsome.wav" } )
		}
	}
}

local models = {
	"models/hlhgruntsplayermodels/hgrunt_mask.mdl",
	"models/hlhgruntsplayermodels/hgrunt_cmdr.mdl",
	"models/hlhgruntsplayermodels/hgrunt_cmdr_black.mdl",
	"models/hlhgruntsplayermodels/hgrunt_hood.mdl"
}
for k,v in ipairs( models ) do
	TFAVOX_RegisterPack( v, voxTable )
end
