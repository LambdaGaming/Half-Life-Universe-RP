
local scimodels = {
	"models/player/sgg/hev_helmet.mdl",
	"models/player/hdpp/gordon.mdl",
	"models/player/hdpp/male_01.mdl",
	"models/player/hdpp/male_02.mdl",
	"models/player/hdpp/male_03.mdl",
	"models/player/hdpp/male_05.mdl",
	"models/player/hdpp/male_06.mdl",
	"models/player/hdpp/male_09.mdl",
	"models/Player/hdpp/barney.mdl",
	"models/player/hdpp/kleiner.mdl",
	"models/hazmat/bmhaztechs.mdl"
}

local secmodels = {
	"models/player/hdpp/security/male_05.mdl",
	"models/player/hdpp/security/male_06.mdl",
	"models/player/hdpp/security/male_09.mdl",
	"models/player/hdpp/security/barney.mdl"
}

local marinemodels = { "models/player/gasmask_hecu.mdl" }

local cpmodels = {
	"models/player/police.mdl",
	"models/player/police_fem.mdl",
	"models/player/ElitePolice.mdl",
	"models/player/combine_soldier.mdl",
	"models/player/betacmb_soldier_pm.mdl",
	"models/player/combine_soldier_prisonguard.mdl",
	"models/player/betacmb_soldier_prisonguard_pm.mdl",
	"models/player/combine_super_soldier.mdl",
	"models/player/betacmb_super_soldier_pm.mdl"
}

local femalemodels = {
	"models/player/group01/female_01.mdl",
	"models/player/group01/female_02.mdl",
	"models/player/group01/female_03.mdl",
	"models/player/group01/female_04.mdl",
	"models/player/group01/female_06.mdl",
	"models/player/group03/female_01.mdl",
	"models/player/group03/female_02.mdl",
	"models/player/group03/female_03.mdl",
	"models/player/group03/female_04.mdl",
	"models/player/group03/female_05.mdl",
	"models/player/group03/female_06.mdl"
}

local malemodels = {
	"models/player/group01/male_01.mdl",
	"models/player/group01/male_02.mdl",
	"models/player/group01/male_03.mdl",
	"models/player/group01/male_04.mdl",
	"models/player/group01/male_05.mdl",
	"models/player/group01/male_06.mdl",
	"models/player/group01/male_07.mdl",
	"models/player/group01/male_08.mdl",
	"models/player/group01/male_09.mdl",
	"models/player/group03/male_01.mdl",
	"models/player/group03/male_02.mdl",
	"models/player/group03/male_03.mdl", --Apparently these all have to be lowercase for GetModel() to work? o well, as long as it works I dont care
	"models/player/group03/male_04.mdl",
	"models/player/group03/male_05.mdl",
	"models/player/group03/male_06.mdl",
	"models/player/group03/male_07.mdl",
	"models/player/group03/male_08.mdl",
	"models/player/group03/male_09.mdl"
}

local scichats = {
	{ "administrator", "scientist/administrator.wav" },
	{ "fellow", "scientist/afellowsci.wav" },
	{ "nominal", "scientist/allnominal.wav" },
	{ "expect", "scientist/asexpected.wav" },
	{ "blood", "scientist/bloodsample.wav" },
	{ "run", "scientist/c1a2_sci_1zomb.wav" },
	{ "shoot", "scientist/c1a2_sci_6zomb.wav" },
	{ "thank god", "scientist/c1a3_sci_rescued.wav" },
	{ "doom", "scientist/c1a3_sci_silo2a.wav" },
	{ "don't shoot", "scientist/c1a3_sci_team.wav" },
	{ "dont shoot", "scientist/c1a3_sci_team.wav" },
	{ "over here", "scientist/c3a2_sci_1glu.wav" },
	{ "fool", "scientist/c3a2_sci_fool.wav" },
	{ "serious", "scientist/cantbeserious.wav" },
	{ "specimen", "scientist/catchone.wav" },
	{ "idk", "scientist/dontknow.wav" },
	{ "dont know", "scientist/dontknow.wav" },
	{ "don't know", "scientist/dontknow.wav" },
	{ "donut", "scientist/donuteater.wav" },
	{ "greetings", "scientist/greetings.wav" },
	{ "hi", "scientist/hello.wav" },
	{ "hello", "scientist/hello.wav" },
	{ "glasses", "scientist/hideglasses.wav" },
	{ "interesting", "scientist/howinteresting.wav" },
	{ "hungry", "scientist/hungryyet.wav" },
	{ "sure", "scientist/imsure.wav" },
	{ "lets go", "scientist/letsgo.wav" },
	{ "let's go", "scientist/letsgo.wav" },
	{ "no", "scientist/noo.wav" },
	{ "noo", "scientist/nooo.wav" },
	{ "right", "scientist/right.wav" },
	{ "get back", "scientist/sci_fear14.wav" },
	{ "ah", "scientist/sci_fear8.wav" },
	{ "headcrab", "scientist/seeheadcrab.wav" },
	{ "shut up", "scientist/shutup2.wav" },
	{ "uh oh", "scientist/startle9.wav" },
	{ "odd", "scientist/thatsodd.wav" },
	{ "theoretically", "scientist/theoretically.wav" },
	{ "wait", "scientist/waithere.wav" },
	{ "tie", "scientist/weartie.wav" },
	{ "now what", "scientist/whatnext.wav" },
	{ "yes", "scientist/yes.wav" },
	{ "yea", "scientist/yes.wav" },
	{ "yey", "scientist/yes.wav" },
	{ "ok", "scientist/yesok.wav" },
	{ "okay", "scientist/yesok.wav" },
	{ "insane", "scientist/youinsane.wav" },
	{ "perhaps", "scientist/perhaps.wav" }
}

local secchats = {
	{ "aim for the head", "barney/aimforhead.wav" },
	{ "ambush", "barney/ambush.wav" },
	{ "freeze", "barney/ba_attack1.wav" },
	{ "that was close", "barney/ba_close.wav" },
	{ "bad feeling", "barney/badfeeling.wav" },
	{ "quiet", "barney/bequiet.wav" },
	{ "mess", "barney/bigmess.wav" },
	{ "go right on through", "barney/c1a0_ba_hevyes.wav" },
	{ "stairs", "barney/c1a2_ba_climb.wav" },
	{ "get in here", "barney/c2a4_ba_steril.wav" },
	{ "let me out", "barney/c2a5_ba_letout.wav" },
	{ "sir", "barney/hayfella.wav" },
	{ "hi", "barney/hellonicesuit.wav" },
	{ "hello", "barney/hellonicesuit.wav" },
	{ "i guess", "barney/iguess.wav" },
	{ "lets go", "barney/letsgo.wav" },
	{ "let's go", "barney/letsgo.wav" },
	{ "maybe", "barney/maybe.wav" },
	{ "no", "barney/nope.wav" },
	{ "nope", "barney/nope.wav" },
	{ "cya", "barney/seeya.wav" },
	{ "bye", "barney/seeya.wav" },
	{ "wait", "barney/waitin.wav" },
	{ "yup", "barney/yup.wav" },
	{ "yep", "barney/yup.wav" },
	{ "yes", "barney/yessir.wav" },
	{ "yea", "barney/yessir.wav" }
}

local marinechats = {
	{ "clear", "fgrunt/allclear.wav" },
	{ "bad feeling", "fgrunt/bfeeling.wav" },
	{ "bogie", "fgrunt/bogies.wav" },
	{ "check", "fgrunt/check.wav" },
	{ "take cover", "fgrunt/cover.wav" },
	{ "get down", "fgrunt/down.wav" },
	{ "fubar", "fgrunt/fubar.wav" },
	{ "go", "fgrunt/go.wav" },
	{ "hi", "fgrunt/hellosir.wav" },
	{ "hello", "fgrunt/hellosir.wav" },
	{ "incoming", "fgrunt/incoming.wav" },
	{ "lets go", "fgrunt/marines.wav" },
	{ "let's go", "fgrunt/marines.wav" },
	{ "medic", "fgrunt/medic.wav" },
	{ "no", "fgrunt/no.wav" },
	{ "nope", "fgrunt/no.wav" },
	{ "negative", "fgrunt/no.wav" },
	{ "quiet", "fgrunt/quiet.wav" },
	{ "rodger", "fgrunt/roger.wav" },
	{ "roger", "fgrunt/roger.wav" },
	{ "sir", "fgrunt/sir_01.wav" },
	{ "thanks", "fgrunt/thanks.wav" },
	{ "yes", "fgrunt/yes.wav" },
	{ "yea", "fgrunt/yes.wav" }
}

local cpchat = {
	{ "help", "npc/metropolice/vo/11-99officerneedsassistance.wav" },
	{ "administer", "npc/metropolice/vo/administer.wav" },
	{ "yes", "npc/metropolice/vo/affirmative2.wav" },
	{ "yea", "npc/metropolice/vo/affirmative.wav" },
	{ "airwatch", "npc/metropolice/vo/airwatchsubjectis505.wav" },
	{ "you can go", "npc/metropolice/vo/allrightyoucango.wav" },
	{ "code 2", "npc/metropolice/vo/allunitscode2.wav" },
	{ "move in", "npc/metropolice/vo/allunitsmovein.wav" },
	{ "amputate", "npc/metropolice/vo/amputate.wav" },
	{ "anticitizen", "npc/metropolice/vo/anticitizen.wav" },
	{ "apply", "npc/metropolice/vo/apply.wav" },
	{ "backup", "npc/metropolice/vo/backup.wav" },
	{ "block", "npc/metropolice/vo/block.wav" },
	{ "bugs", "npc/metropolice/vo/bugsontheloose.wav" },
	{ "cauterize", "npc/metropolice/vo/cauterize.wav" },
	{ "hahaha", "npc/metropolice/vo/chuckle.wav" },
	{ "citizen", "npc/metropolice/vo/citizen.wav" },
	{ "clear", "npc/metropolice/vo/clearandcode100.wav" },
	{ "copy", "npc/metropolice/vo/copy.wav" },
	{ "cover me", "npc/metropolice/vo/covermegoingin.wav" },
	{ "defender", "npc/metropolice/vo/defender.wav" },
	{ "document", "npc/metropolice/vo/document.wav" },
	{ "stop", "npc/metropolice/vo/dontmove.wav" },
	{ "dont move", "npc/metropolice/vo/dontmove.wav" },
	{ "don't move", "npc/metropolice/vo/dontmove.wav" },
	{ "examine", "npc/metropolice/vo/examine.wav" },
	{ "get down", "npc/metropolice/vo/getdown.wav" },
	{ "hold it", "npc/metropolice/vo/holditrightthere.wav" },
	{ "infection", "npc/metropolice/vo/infection.wav" },
	{ "inject", "npc/metropolice/vo/inject.wav" },
	{ "location", "npc/metropolice/vo/location.wav" },
	{ "move", "npc/metropolice/vo/move.wav" },
	{ "one", "npc/metropolice/vo/one.wav" },
	{ "two", "npc/metropolice/vo/two.wav" },
	{ "three", "npc/metropolice/vo/three.wav" },
	{ "four", "npc/metropolice/vo/four.wav" },
	{ "five", "npc/metropolice/vo/five.wav" },
	{ "six", "npc/metropolice/vo/six.wav" },
	{ "seven", "npc/metropolice/vo/seven.wav" },
	{ "eight", "npc/metropolice/vo/eight.wav" },
	{ "nine", "npc/metropolice/vo/nine.wav" },
	{ "ten", "npc/metropolice/vo/ten.wav" },
	{ "rodger", "npc/metropolice/vo/rodgerthat.wav" },
	{ "responding", "npc/metropolice/vo/responding.wav" },
	{ "shots fired", "npc/metropolice/vo/shotsfiredhostilemalignants.wav" },
	{ "sterilize", "npc/metropolice/vo/sterilize.wav" },
	{ "shit", "npc/metropolice/vo/shit.wav" },
	{ "zero", "npc/metropolice/vo/zero.wav" }
}

local femalechat = {
	{ "ammo", "vo/npc/female01/ammo03.wav" },
	{ "behind you", "vo/npc/female01/behindyou01.wav" },
	{ "better reload", "vo/npc/female01/youdbetterreload01.wav" },
	{ "bullshit", "vo/npc/female01/question26.wav" },
	{ "cheese", "vo/npc/female01/question06.wav" },
	{ "combine", "vo/npc/female01/combine01.wav" },
	{ "coming", "vo/npc/female01/squad_approach04.wav" },
	{ "cops", "vo/npc/female01/civilprotection01.wav" },
	{ "cp", "vo/npc/female01/civilprotection01.wav" },
	{ "cut it", "vo/trainyard/female01/cit_hit01.wav" },
	{ "dont tell me", "vo/npc/female01/gordead_ans03.wav" },
	{ "excuse me", "vo/npc/female01/excuseme01.wav" },
	{ "fantastic", "vo/npc/female01/fantastic01.wav" },
	{ "figures", "vo/npc/female01/answer03.wav" },
	{ "finally", "vo/npc/female01/finally.wav" },
	{ "follow", "vo/coast/odessa/female01/stairman_follow01.wav" },
	{ "freeman", "vo/npc/female01/freeman.wav" },
	{ "get down", "vo/npc/female01/getdown02.wav" },
	{ "get in", "vo/canals/gunboat_getin.wav" },
	{ "get out", "vo/npc/female01/gethellout.wav" },
	{ "good god", "vo/npc/female01/goodgod.wav" },
	{ "got one", "vo/npc/female01/gotone01.wav" },
	{ "gotta reload", "vo/npc/female01/gottareload01.wav" },
	{ "hacks", "vo/npc/female01/hacks02.wav" },
	{ "hax", "vo/npc/female01/hacks02.wav" },
	{ "help", "vo/npc/female01/help01.wav" },
	{ "hello", "vo/npc/female01/hi02.wav" },
	{ "hi", "vo/npc/female01/hi01.wav" },
	{ "heads up", "vo/npc/female01/headsup01.wav" },
	{ "i know", "vo/npc/female01/answer08.wav" },
	{ "isnt good", "vo/trainyard/female01/cit_window_use01.wav" },
	{ "ok", "vo/npc/female01/answer02.wav" },
	{ "okay", "vo/npc/female01/answer02.wav" },
	{ "lets go", "vo/npc/female01/letsgo01.wav" },
	{ "let's go", "vo/npc/female01/letsgo01.wav" },
	{ "never", "vo/Citadel/eli_nonever.wav" },
	{ "nice", "vo/npc/female01/nice.wav" },
	{ "no", "vo/npc/female01/no01.wav" },
	{ "not sure", "vo/npc/female01/answer21.wav" },
	{ "now what", "vo/npc/female01/gordead_ans01.wav" },
	{ "oops", "vo/npc/female01/whoops01.wav" },
	{ "over here", "vo/npc/female01/overhere01.wav" },
	{ "over there", "vo/npc/female01/overthere01.wav" },
	{ "run", "vo/npc/female01/strider_run.wav" },
	{ "shut up", "vo/npc/female01/answer17.wav" },
	{ "sorry", "vo/npc/female01/sorry01.wav" },
	{ "take cover", "vo/npc/female01/takecover02.wav" },
	{ "uh oh", "vo/npc/female01/uhoh.wav" },
	{ "wait", "vo/trainyard/man_waitaminute.wav" },
	{ "watch out", "vo/npc/female01/watchout.wav" },
	{ "what now", "vo/npc/female01/gordead_ques16.wav" },
	{ "yea", "vo/npc/female01/yeah02.wav" },
	{ "yes", "vo/npc/female01/yeah02.wav" }
}

local malechat = {
	{ "ammo", "vo/npc/male01/ammo03.wav" },
	{ "behind you", "vo/npc/male01/behindyou01.wav" },
	{ "better reload", "vo/npc/male01/youdbetterreload01.wav" },
	{ "bullshit", "vo/npc/male01/question26.wav" },
	{ "cheese", "vo/npc/male01/question06.wav" },
	{ "combine", "vo/npc/male01/combine01.wav" },
	{ "coming", "vo/npc/male01/squad_approach04.wav" },
	{ "cops", "vo/npc/male01/civilprotection01.wav" },
	{ "cp", "vo/npc/male01/civilprotection01.wav" },
	{ "cut it", "vo/trainyard/male01/cit_hit01.wav" },
	{ "dont tell me", "vo/npc/male01/gordead_ans03.wav" },
	{ "excuse me", "vo/npc/male01/excuseme01.wav" },
	{ "fantastic", "vo/npc/male01/fantastic01.wav" },
	{ "figures", "vo/npc/male01/answer03.wav" },
	{ "finally", "vo/npc/male01/finally.wav" },
	{ "follow", "vo/coast/odessa/male01/stairman_follow01.wav" },
	{ "freeman", "vo/npc/male01/freeman.wav" },
	{ "get down", "vo/npc/male01/getdown02.wav" },
	{ "get in", "vo/canals/gunboat_getin.wav" },
	{ "get out", "vo/npc/male01/gethellout.wav" },
	{ "good god", "vo/npc/male01/goodgod.wav" },
	{ "got one", "vo/npc/male01/gotone01.wav" },
	{ "gotta reload", "vo/npc/male01/gottareload01.wav" },
	{ "hacks", "vo/npc/male01/hacks02.wav" },
	{ "hax", "vo/npc/male01/hacks02.wav" },
	{ "help", "vo/npc/male01/help01.wav" },
	{ "hello", "vo/npc/male01/hi02.wav" },
	{ "hi", "vo/npc/male01/hi01.wav" },
	{ "heads up", "vo/npc/male01/headsup01.wav" },
	{ "i know", "vo/npc/male01/answer08.wav" },
	{ "isnt good", "vo/trainyard/male01/cit_window_use01.wav" },
	{ "ok", "vo/npc/male01/answer02.wav" },
	{ "okay", "vo/npc/male01/answer02.wav" },
	{ "lets go", "vo/npc/male01/letsgo01.wav" },
	{ "let's go", "vo/npc/male01/letsgo01.wav" },
	{ "never", "vo/Citadel/eli_nonever.wav" },
	{ "nice", "vo/npc/male01/nice.wav" },
	{ "no", "vo/Citadel/br_no.wav" },
	{ "not sure", "vo/npc/male01/answer21.wav" },
	{ "now what", "vo/npc/male01/gordead_ans01.wav" },
	{ "oops", "vo/npc/male01/whoops01.wav" },
	{ "over here", "vo/npc/male01/overhere01.wav" },
	{ "over there", "vo/npc/male01/overthere01.wav" },
	{ "run", "vo/npc/male01/strider_run.wav" },
	{ "shut up", "vo/npc/male01/answer17.wav" },
	{ "sorry", "vo/npc/male01/sorry01.wav" },
	{ "take cover", "vo/npc/male01/takecover02.wav" },
	{ "uh oh", "vo/npc/male01/uhoh.wav" },
	{ "wait", "vo/trainyard/man_waitaminute.wav" },
	{ "watch out", "vo/npc/male01/watchout.wav" },
	{ "what now", "vo/npc/male01/gordead_ques16.wav" },
	{ "yea", "vo/npc/male01/yeah02.wav" },
	{ "yes", "vo/npc/male01/yeah02.wav" }
}

if SERVER then
	hook.Add( "PlayerSay", "SoundChat", function( ply, text, team )
		if team then return end
		local prefixlist = { "/", "!", "@" }
    	if table.HasValue( prefixlist, string.sub( text, 0, 1 ) ) then return end --Doesn't check the tables if a prefix was entered, for example /ooc or !addons
		if ply.chatcooldown and ply.chatcooldown > CurTime() then return end --Doesn't check the tables if the cooldown is still in effect
		if table.HasValue( scimodels, ply:GetModel() ) then --Sounds play according to what playermodel the player has
			for _,v in pairs( scichats ) do --Looks over table of words and paths
				if string.match( v[1], text:lower() ) then --Looks over the first part of the tables to see if the player sent a word that matches a word in the table
					ply.chatcooldown = CurTime() + 3 --Adds 3 second cooldown to avoid spam
					ply:EmitSound( v[2] ) --Emits the sound from the path according to what word was typed in, looks in the second part of the table
					break --A break is needed or else two different sounds may play at once
				end
			end
		elseif table.HasValue( secmodels, ply:GetModel() ) then
			for _,v in pairs( secchats ) do
				if string.match( v[1], text:lower() ) then
					ply.chatcooldown = CurTime() + 3
					ply:EmitSound( v[2] )
					break
				end
			end
		elseif table.HasValue( marinemodels, ply:GetModel() ) then
			for _,v in pairs( marinechats ) do
				if string.match( v[1], text:lower() ) then
					ply.chatcooldown = CurTime() + 3
					ply:EmitSound( v[2] )
					break
				end
			end
		elseif table.HasValue( cpmodels, ply:GetModel() ) then
			for _,v in pairs( cpchat ) do
				if string.match( v[1], text:lower() ) then
					ply.chatcooldown = CurTime() + 3
					ply:EmitSound( v[2] )
					break
				end
			end
		elseif table.HasValue( femalemodels, ply:GetModel() ) then
			for _,v in pairs( femalechat ) do
				if string.match( v[1], text:lower() ) then
					ply.chatcooldown = CurTime() + 3
					ply:EmitSound( v[2] )
					break
				end
			end
		elseif table.HasValue( malemodels, ply:GetModel() ) then
			for _,v in pairs( malechat ) do
				if string.match( v[1], text:lower() ) then
					ply.chatcooldown = CurTime() + 3
					ply:EmitSound( v[2] )
					break
				end
			end
		end
		return text
	end )
end