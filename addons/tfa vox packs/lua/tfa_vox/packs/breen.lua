local mdl = "breen"
local voxTable = {
	["main"] = {
		["death"] = {
			["sound"] = TFAVOX_GenerateSound( mdl, "death", { "vo/citadel/br_youneedme.wav" } )
		},
		["spawn"] = {
			["sound"] = TFAVOX_GenerateSound( mdl, "spawn", { "vo/citadel/br_mock05.wav" } )
		},
		["noammo"] = {
			["sound"] = TFAVOX_GenerateSound( mdl, "noammo", { "vo/citadel/br_ohshit.wav" } )
		},
		["fall"] = {
			["sound"] = TFAVOX_GenerateSound( mdl, "fall", { "vo/citadel/br_failing11.wav" } )
		}
	},
	["murder"] = {
		["generic"] = {
			["sound"] = TFAVOX_GenerateSound( mdl, "HITGROUP_GENERIC", { "vo/citadel/br_laugh01.wav", "vo/citadel/br_mock06.wav", "vo/citadel/br_mock09.wav", "vo/citadel/br_mock13.wav" } )
		}
	}
}

local models = {
	"models/player/breen.mdl",
	"models/player/hlew/scientists/administrators/breen_administrator_extended.mdl",
	"models/player/hlew/scientists/administrators/ernston_administrator_extended.mdl",
	"models/player/hlew/scientists/administrators/lex_administrator_extended.mdl",
	"models/player/hlew/scientists/administrators/simon_administrator_extended.mdl",
	"models/player/hlew/scientists/administrators/wilson_administrator_extended.mdl"
}
for k,v in ipairs( models ) do
	TFAVOX_RegisterPack( v, voxTable )
end
