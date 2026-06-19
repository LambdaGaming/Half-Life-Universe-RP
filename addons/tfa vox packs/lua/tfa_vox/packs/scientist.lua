local mdl = "science"
local voxTable = {
	["main"] = {
		["crithealth"] = {
			["sound"] = TFAVOX_GenerateSound( mdl, "crithealth", { "vj_hlr/gsrc/npc/scientist/iwounded.wav", "vj_hlr/gsrc/npc/scientist/iwounded2.wav", "vj_hlr/gsrc/npc/scientist/iwoundedbad.wav" } )
		},
		["death"] = {
			["sound"] = TFAVOX_GenerateSound( mdl, "death", { "vj_hlr/gsrc/npc/scientist/sci_die1.wav", "vj_hlr/gsrc/npc/scientist/sci_die2.wav", "vj_hlr/gsrc/npc/scientist/sci_die3.wav", "vj_hlr/gsrc/npc/scientist/sci_die4.wav" } )
		},
		["spawn"] = {
			["sound"] = TFAVOX_GenerateSound( mdl, "spawn", { "vj_hlr/gsrc/npc/scientist/hello.wav", "vj_hlr/gsrc/npc/scientist/greetings.wav", "vj_hlr/gsrc/npc/scientist/greetings2.wav", "vj_hlr/gsrc/npc/scientist/hellothere.wav" } )
		},
		["noammo"] = {
			["sound"] = TFAVOX_GenerateSound( mdl, "noammo", { "vj_hlr/gsrc/npc/scientist/startle7.wav", "vj_hlr/gsrc/npc/scientist/startle9.wav" } )
		},
		["fall"] = {
			["sound"] = TFAVOX_GenerateSound( mdl, "fall", { "vj_hlr/gsrc/npc/scientist/c1a0_sci_catscream.wav" } )
		}
	},
	["damage"] = {
		[HITGROUP_GENERIC] = {
			["sound"] = TFAVOX_GenerateSound( mdl, "HITGROUP_GENERIC", { "vj_hlr/gsrc/npc/scientist/sci_pain1.wav", "vj_hlr/gsrc/npc/scientist/sci_pain2.wav", "vj_hlr/gsrc/npc/scientist/sci_pain3.wav", "vj_hlr/gsrc/npc/scientist/sci_pain4.wav", "vj_hlr/gsrc/npc/scientist/sci_pain5.wav", "vj_hlr/gsrc/npc/scientist/sci_pain6.wav", "vj_hlr/gsrc/npc/scientist/sci_pain7.wav", "vj_hlr/gsrc/npc/scientist/sci_pain8.wav", "vj_hlr/gsrc/npc/scientist/sci_pain9.wav", "vj_hlr/gsrc/npc/scientist/sci_pain10.wav" } )
		}
	},
	["callouts"] = {
		["agree"] = {
			["name"] = "Agree",
			["sound"] = TFAVOX_GenerateSound( mdl, "callout_agree", { "vj_hlr/gsrc/npc/scientist/yees.wav", "vj_hlr/gsrc/npc/scientist/yes.wav", "vj_hlr/gsrc/npc/scientist/yes2.wav", "vj_hlr/gsrc/npc/scientist/yes3.wav", "vj_hlr/gsrc/npc/scientist/absolutely.wav", "vj_hlr/gsrc/npc/scientist/alright.wav", "vj_hlr/gsrc/npc/scientist/ibelieveso.wav", "vj_hlr/gsrc/npc/scientist/imsure.wav", "vj_hlr/gsrc/npc/scientist/nodoubt.wav", "vj_hlr/gsrc/npc/scientist/ofcourse.wav", "vj_hlr/gsrc/npc/scientist/perhaps.wav", "vj_hlr/gsrc/npc/scientist/positively.wav", "vj_hlr/gsrc/npc/scientist/right.wav" } )
		},
		["disagree"] = {
			["name"] = "Disagree",
			["sound"] = TFAVOX_GenerateSound( mdl, "callout_disagree", { "vj_hlr/gsrc/npc/scientist/noo.wav", "vj_hlr/gsrc/npc/scientist/notcertain.wav", "vj_hlr/gsrc/npc/scientist/nooo.wav", "vj_hlr/gsrc/npc/scientist/absolutelynot.wav", "vj_hlr/gsrc/npc/scientist/completelywrong.wav", "vj_hlr/gsrc/npc/scientist/dontconcur.wav", "vj_hlr/gsrc/npc/scientist/cantbeserious.wav", "vj_hlr/gsrc/npc/scientist/idiotic.wav", "vj_hlr/gsrc/npc/scientist/idontthinkso.wav", "vj_hlr/gsrc/npc/scientist/inconclusive.wav", "vj_hlr/gsrc/npc/scientist/ofcoursenot.wav", "vj_hlr/gsrc/npc/scientist/ridiculous.wav", "vj_hlr/gsrc/npc/scientist/shutup.wav", "vj_hlr/gsrc/npc/scientist/shutup2.wav" } )
		},
		["greeting"] = {
			["name"] = "Greeting",
			["sound"] = TFAVOX_GenerateSound( mdl, "callout_greeting", { "vj_hlr/gsrc/npc/scientist/hello.wav", "vj_hlr/gsrc/npc/scientist/greetings.wav", "vj_hlr/gsrc/npc/scientist/greetings2.wav", "vj_hlr/gsrc/npc/scientist/goodtoseeyou.wav", "vj_hlr/gsrc/npc/scientist/hellothere.wav" } )
		},
		["question"] = {
			["name"] = "Random Question",
			["sound"] = TFAVOX_GenerateSound( mdl, "callout_question", { "vj_hlr/gsrc/npc/scientist/alienappeal.wav", "vj_hlr/gsrc/npc/scientist/analysis.wav", "vj_hlr/gsrc/npc/scientist/announcer.wav", "vj_hlr/gsrc/npc/scientist/areyouthink.wav", "vj_hlr/gsrc/npc/scientist/beverage.wav", "vj_hlr/gsrc/npc/scientist/bloodsample.wav", "vj_hlr/gsrc/npc/scientist/cantbeworse.wav", "vj_hlr/gsrc/npc/scientist/cascade.wav", "vj_hlr/gsrc/npc/scientist/catchone.wav", "vj_hlr/gsrc/npc/scientist/chaostheory.wav", "vj_hlr/gsrc/npc/scientist/checkatten.wav", "vj_hlr/gsrc/npc/scientist/correcttheory.wav", "vj_hlr/gsrc/npc/scientist/crowbar.wav", "vj_hlr/gsrc/npc/scientist/delayagain.wav", "vj_hlr/gsrc/npc/scientist/didyouhear.wav", "vj_hlr/gsrc/npc/scientist/donuteater.wav", "vj_hlr/gsrc/npc/scientist/doyousmell.wav", "vj_hlr/gsrc/npc/scientist/everseen.wav", "vj_hlr/gsrc/npc/scientist/fascinating.wav", "vj_hlr/gsrc/npc/scientist/goodpaper.wav", "vj_hlr/gsrc/npc/scientist/hearsomething.wav", "vj_hlr/gsrc/npc/scientist/hopenominal.wav", "vj_hlr/gsrc/npc/scientist/hideglasses.wav", "vj_hlr/gsrc/npc/scientist/howinteresting.wav", "vj_hlr/gsrc/npc/scientist/hungryyet.wav", "vj_hlr/gsrc/npc/scientist/limitsok.wav", "vj_hlr/gsrc/npc/scientist/luckwillchange.wav", "vj_hlr/gsrc/npc/scientist/newsample.wav", "vj_hlr/gsrc/npc/scientist/noidea.wav", "vj_hlr/gsrc/npc/scientist/odorfromyou.wav", "vj_hlr/gsrc/npc/scientist/perfectday.wav", "vj_hlr/gsrc/npc/scientist/purereadings.wav", "vj_hlr/gsrc/npc/scientist/recalculate.wav", "vj_hlr/gsrc/npc/scientist/runtest.wav", "vj_hlr/gsrc/npc/scientist/seencup.wav", "vj_hlr/gsrc/npc/scientist/shakeunification.wav", "vj_hlr/gsrc/npc/scientist/shutdownchart.wav", "vj_hlr/gsrc/npc/scientist/simulation.wav", "vj_hlr/gsrc/npc/scientist/smellburn.wav", "vj_hlr/gsrc/npc/scientist/softethics.wav", "vj_hlr/gsrc/npc/scientist/statusreport.wav", "vj_hlr/gsrc/npc/scientist/stench.wav", "vj_hlr/gsrc/npc/scientist/stimulating.wav", "vj_hlr/gsrc/npc/scientist/tunedtoday.wav", "vj_hlr/gsrc/npc/scientist/tunnelcalc.wav", "vj_hlr/gsrc/npc/scientist/weartie.wav" } )
		},
		["comment"] = {
			["name"] = "Disaster Comment",
			["sound"] = TFAVOX_GenerateSound( mdl, "callout_comment", { "vj_hlr/gsrc/npc/scientist/administrator.wav", "vj_hlr/gsrc/npc/scientist/alientrick.wav", "vj_hlr/gsrc/npc/scientist/chimp.wav", "vj_hlr/gsrc/npc/scientist/containfail.wav", "vj_hlr/gsrc/npc/scientist/dinner.wav", "vj_hlr/gsrc/npc/scientist/evergetout.wav", "vj_hlr/gsrc/npc/scientist/getoutalive.wav", "vj_hlr/gsrc/npc/scientist/getoutofhere.wav", "vj_hlr/gsrc/npc/scientist/headcrab.wav", "vj_hlr/gsrc/npc/scientist/ihearsomething.wav", "vj_hlr/gsrc/npc/scientist/improbable.wav", "vj_hlr/gsrc/npc/scientist/ipredictedthis.wav", "vj_hlr/gsrc/npc/scientist/lambdalab.wav", "vj_hlr/gsrc/npc/scientist/needsleep.wav", "vj_hlr/gsrc/npc/scientist/nogrant.wav", "vj_hlr/gsrc/npc/scientist/nothostile.wav", "vj_hlr/gsrc/npc/scientist/organicmatter.wav", "vj_hlr/gsrc/npc/scientist/peculiarmarks.wav", "vj_hlr/gsrc/npc/scientist/peculiarodor.wav", "vj_hlr/gsrc/npc/scientist/rescueus.wav", "vj_hlr/gsrc/npc/scientist/rumourclean.wav", "vj_hlr/gsrc/npc/scientist/survival.wav", "vj_hlr/gsrc/npc/scientist/sunsets.wav", "vj_hlr/gsrc/npc/scientist/tram.wav", "vj_hlr/gsrc/npc/scientist/uselessphd.wav", "vj_hlr/gsrc/npc/scientist/xena.wav" } )
		},
		["beg"] = {
			["name"] = "Beg For Mercy",
			["sound"] = TFAVOX_GenerateSound( mdl, "callout_beg", { "vj_hlr/gsrc/npc/scientist/advance.wav", "vj_hlr/gsrc/npc/scientist/dontwantdie.wav", "vj_hlr/gsrc/npc/scientist/madness.wav", "vj_hlr/gsrc/npc/scientist/noplease.wav", "vj_hlr/gsrc/npc/scientist/please.wav", "vj_hlr/gsrc/npc/scientist/scream10.wav", "vj_hlr/gsrc/npc/scientist/youinsane.wav" } )
		}
	}
}

local models = {
	"models/player/hlew/scientists/walter_scientist_extended.mdl",
	"models/player/hlew/scientists/alfred_scientist_extended.mdl",
	"models/player/hlew/scientists/boris_scientist_extended.mdl",
	"models/player/hlew/scientists/colette_scientist_extended.mdl",
	"models/player/hlew/scientists/edwart_scientist_extended.mdl",
	"models/player/hlew/scientists/einstein_scientist_extended.mdl",
	"models/player/hlew/scientists/eli_scientist_extended.mdl",
	"models/player/hlew/scientists/gina_scientist_extended.mdl",
	"models/player/hlew/scientists/gordon_scientist_extended.mdl",
	"models/player/hlew/scientists/gus_scientist_extended.mdl",
	"models/player/hlew/scientists/gustavo_scientist_extended.mdl",
	"models/player/hlew/scientists/jay_scientist_extended.mdl",
	"models/player/hlew/scientists/jonny_scientist_extended.mdl",
	"models/player/hlew/scientists/kleiner_scientist_extended.mdl",
	"models/player/hlew/scientists/kyle_scientist_extended.mdl",
	"models/player/hlew/scientists/leonel_scientist_extended.mdl",
	"models/player/hlew/scientists/lorena_scientist_extended.mdl",
	"models/player/hlew/scientists/luther_scientist_extended.mdl",
	"models/player/hlew/scientists/magnusson_scientist_extended.mdl",
	"models/player/hlew/scientists/manuel_scientist_extended.mdl",
	"models/player/hlew/scientists/marissa_scientist_extended.mdl",
	"models/player/hlew/scientists/marley_scientist_extended.mdl",
	"models/player/hlew/scientists/marvin_scientist_extended.mdl",
	"models/player/hlew/scientists/michael_scientist_extended.mdl",
	"models/player/hlew/scientists/poly_scientist_extended.mdl",
	"models/player/hlew/scientists/rosenberg_scientist_extended.mdl",
	"models/player/hlew/scientists/slick_scientist_extended.mdl",
	"models/player/hlew/scientists/tim_scientist_extended.mdl",
	"models/player/hlew/scientists/yelene_scientist_extended.mdl",
	"models/player/hlew/scientists/alphafemales/scientist_esther_extended.mdl",
	"models/player/hlew/scientists/alphafemales/scientist_gwen_extended.mdl",
	"models/player/hlew/scientists/alphafemales/scientist_ptheresa_extended.mdl",
	"models/player/hlew/scientists/alphafemales/scientist_scarlet_extended.mdl",
	"models/player/hlew/scientists/fatsci/curtis_scientist_extended.mdl",
	"models/player/hlew/scientists/fatsci/dario_scientist_extended.mdl",
	"models/player/hlew/scientists/fatsci/franklin_scientist_extended.mdl",
	"models/player/hlew/scientists/fatsci/harvey_scientist_extended.mdl",
	"models/player/hlew/scientists/fatsci/lenny_scientist_extended.mdl",
	"models/player/hlew/scientists/fatsci/murr_scientist_extended.mdl",
	"models/player/hlew/scientists/survivors/einstein_survivor_extended.mdl",
	"models/player/hlew/scientists/survivors/luther_survivor_extended.mdl",
	"models/player/hlew/scientists/survivors/slick_survivor_extended.mdl",
	"models/player/hlew/scientists/survivors/walter_survivor_extended.mdl",
	"models/player/hlew/workers/janitor_classic_extended.mdl",
	"models/player/hlew/workers/gus_worker_extended.mdl",
	"models/player/hlew/workers/edwart_worker_extended.mdl",
	"models/player/hlew/workers/paul_worker_extended.mdl",
	"models/player/hlew/workers/robin_worker_extended.mdl",
	"models/player/hlew/workers/wallace_worker_extended.mdl",
	"models/player/hlew/workers/wexler_worker_extended.mdl",
	"models/player/kleiner.mdl"
}
for k,v in ipairs( models ) do
	TFAVOX_RegisterPack( v, voxTable )
end
