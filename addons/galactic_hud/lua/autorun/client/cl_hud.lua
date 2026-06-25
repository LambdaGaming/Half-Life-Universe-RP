--Heavily modified version of an old version of Galactic HUD: https://github.com/ZeroXitreo/Galactic-HUD

// init
local clip1_max = 0
local ammo_max = 0
local clip2_max = 0
local fpssmooth = 0

// recursive iteration function
local function parentMeDaddy( entity )
	if entity:GetParent():IsValid() then
		return parentMeDaddy( entity:GetParent() )
	end
	return entity
end

local color_bmrp = Color( 142, 71, 0 )
local color_bmrp_dark = Color( 107, 53, 0 )
local color_c17 = Color( 49, 53, 61 )
local color_c17_dark = Color( 41, 44, 51 )
local color_outland = Color( 1, 22, 0 )
local color_outland_dark = Color( 6, 79, 0 )

// recursive iteration function
function draw.StatusBar( x, y, w, h, colour, value, max, leftString, rightString, hide, centerString )
	draw.RoundedBox(humbox.theme.round, x, y, w, h, humbox.theme:Transparency(colour, .1))

	local limitedValue = value
	if limitedValue >= max then
		limitedValue = max
	end

	if not hide or value > 0 then
		if w/max*limitedValue >= 1 then
			draw.RoundedBox(humbox.theme.round, x, y, w/max*limitedValue, h, humbox.theme:Transparency(colour, .5))
		end

		draw.SimpleText(
			leftString,
			"Description",
			x + h/4,
			y + h/2,
			humbox.theme.txt,
			TEXT_ALIGN_LEFT,
			TEXT_ALIGN_CENTER
		)

		if not isstring(rightString) then
			rightString = value
		end

		draw.SimpleText(
			rightString,
			"Description",
			x + w - h/4,
			y + h/2,
			humbox.theme.txt,
			TEXT_ALIGN_RIGHT,
			TEXT_ALIGN_CENTER
		)

		if centerString then
			draw.SimpleText(
				centerString,
				"Description",
				x + w/2,
				y + h/2,
				humbox.theme.txt,
				TEXT_ALIGN_CENTER,
				TEXT_ALIGN_CENTER
			)
		end
	end
end

hook.Add("HUDPaint", "HUD_dosmoothstuff", function()
	// Calculate FPS
	local ply = LocalPlayer()
	if !IsValid( ply ) then return end
	
	local fps = 1 / RealFrameTime()
	fpssmooth = fpssmooth + ( fps - fpssmooth ) / ( fps / 4 )

	// Calculate Velocity
	local velocity = math.Round( parentMeDaddy( ply ):GetVelocity():Length() )
	local gm = GetGlobalInt( "CurrentGamemode" )

	// Show HUD
	if ply:Health() > 0 then
		// Reset texture
		surface.SetTexture( 0 )

		///////////////
		// Left side //
		///////////////
		local w = 20*humbox.theme.rem
		local h = 7*humbox.theme.rem
		local x = humbox.theme.rem
		local y = ScrH() - h - humbox.theme.rem

		// Extra push for other addons
		hudW = x + w
		hudH = h + humbox.theme.rem

		// Background
		if gm == 1 then
			draw.RoundedBox( humbox.theme.round, x, y, w, h, humbox.theme:Transparency( color_bmrp, 0.9 ) )
			draw.RoundedBox( humbox.theme.round, x, y, w, h, color_bmrp )
		elseif gm == 2 then
			draw.RoundedBox( humbox.theme.round, x, y, w, h, humbox.theme:Transparency( color_c17, 0.9 ) )
			draw.RoundedBox( humbox.theme.round, x, y, w, h, color_c17 )
		elseif gm == 3 then
			draw.RoundedBox( humbox.theme.round, x, y, w, h, humbox.theme:Transparency( color_outland, 0.9 ) )
			draw.RoundedBox( humbox.theme.round, x, y, w, h, color_outland )
		end

		// Velocity
		draw.StatusBar(
			x + .5*humbox.theme.rem,
			y + .5*humbox.theme.rem,
			w - humbox.theme.rem,
			1.5*humbox.theme.rem,
			humbox.theme.green,
			velocity,
			1500,
			"KPH: " .. math.Round(velocity*3600*0.0000254*0.75),
			"MPH: " .. math.Round(velocity*3600/63360*0.75)
		)

		// FPS
		draw.StatusBar(
			x + .5*humbox.theme.rem,
			y + 2.5*humbox.theme.rem,
			w/2 - .75*humbox.theme.rem,
			1.5*humbox.theme.rem,
			humbox.theme.green,
			math.Round(fpssmooth),
			150,
			"FPS"
		)

		// Latency
		draw.StatusBar(
			x + w/2 + .25*humbox.theme.rem,
			y + 2.5*humbox.theme.rem,
			w/2 - .75*humbox.theme.rem,
			1.5*humbox.theme.rem,
			humbox.theme.green,
			ply:Ping(),
			150,
			"Latency"
		)

		// Health/Armour background
		if gm == 1 then
			draw.RoundedBox( humbox.theme.round, x, y + h - 2.5*humbox.theme.rem, w, 2.5*humbox.theme.rem, humbox.theme:Transparency( color_bmrp_dark, 0.75 ) )
			draw.RoundedBox( humbox.theme.round, x, y + h - 2.5*humbox.theme.rem, w, 2.5*humbox.theme.rem, color_bmrp_dark )
		elseif gm == 2 then
			draw.RoundedBox( humbox.theme.round, x, y + h - 2.5*humbox.theme.rem, w, 2.5*humbox.theme.rem, humbox.theme:Transparency( color_c17_dark, 0.75 ) )
			draw.RoundedBox( humbox.theme.round, x, y + h - 2.5*humbox.theme.rem, w, 2.5*humbox.theme.rem, color_c17_dark )
		elseif gm == 3 then
			draw.RoundedBox( humbox.theme.round, x, y + h - 2.5*humbox.theme.rem, w, 2.5*humbox.theme.rem, humbox.theme:Transparency( color_outland_dark, 0.75 ) )
			draw.RoundedBox( humbox.theme.round, x, y + h - 2.5*humbox.theme.rem, w, 2.5*humbox.theme.rem, color_outland_dark )
		end

		// Health
		draw.StatusBar(
			x + .5*humbox.theme.rem,
			y + h - 2*humbox.theme.rem,
			w - 7.5*humbox.theme.rem,
			1.5*humbox.theme.rem,
			humbox.theme.red,
			ply:Health(),
			ply:GetMaxHealth(),
			"Health"
		)

		// Armour
		draw.StatusBar(
			x + w - 6.5*humbox.theme.rem,
			y + h - 2*humbox.theme.rem,
			6*humbox.theme.rem,
			1.5*humbox.theme.rem,
			humbox.theme.blue,
			ply:Armor(),
			100,
			"Armor",
			NULL,
			true
		)

		////////////////
		// Right side //
		////////////////
		local w = 20 * humbox.theme.rem
		local h = 2.5 * humbox.theme.rem
		local x = ScrW() - w - humbox.theme.rem
		local y = ScrH() - h - humbox.theme.rem

		// Primary clip
		local clip1 = 0
		local wep = ply:GetActiveWeapon()
		if IsValid( wep ) then
			clip1 = wep:Clip1()
		end
		if clip1 > clip1_max then
			clip1_max = clip1
		end

		if clip1 > 0 then
			// Background
			if gm == 1 then
				draw.RoundedBox( humbox.theme.round, x, y, w, h, color_bmrp )
			elseif gm == 2 then
				draw.RoundedBox( humbox.theme.round, x, y, w, h, color_c17 )
			elseif gm == 3 then
				draw.RoundedBox( humbox.theme.round, x, y, w, h, color_outland )
			end

			draw.StatusBar(
				x + .5*humbox.theme.rem,
				y + .5*humbox.theme.rem,
				w - 10*humbox.theme.rem,
				h - humbox.theme.rem,
				humbox.theme.blue,
				clip1,
				clip1_max,
				"Clip",
				NULL,
				true
			)

			// Primary ammo
			local ammo = 0
			if IsValid( wep ) then
				ammo = ply:GetAmmoCount(wep:GetPrimaryAmmoType())
			end
			if ammo > ammo_max then
				ammo_max = ammo
			end

			draw.StatusBar(
				x + w - 9*humbox.theme.rem,
				y + .5*humbox.theme.rem,
				5*humbox.theme.rem,
				h - humbox.theme.rem,
				humbox.theme.blue,
				ammo,
				ammo_max,
				"Ammo",
				NULL,
				true
			)

			// Secondary clip
			local clip2 = 0
			if IsValid( wep ) then
				clip2 = ply:GetAmmoCount(wep:GetSecondaryAmmoType())
			end
			if clip2 > clip2_max then
				clip2_max = clip2
			end

			draw.StatusBar(
				x + w - 3.5*humbox.theme.rem,
				y + .5*humbox.theme.rem,
				3*humbox.theme.rem,
				h - humbox.theme.rem,
				humbox.theme.yellow,
				clip2,
				clip2_max,
				"Alt",
				NULL,
				true
			)
		end

		// Left Side
		local w = 20*humbox.theme.rem
		local h = 2.5*humbox.theme.rem
		local x = humbox.theme.rem
		local y = ScrH() - h - hudH

		// Extra push for other addons
		hudH = hudH + 2.5*humbox.theme.rem

		// Background
		if gm == 1 then
			draw.RoundedBox( humbox.theme.round, x, y, w, h + .5*humbox.theme.rem, color_bmrp )
			draw.RoundedBox( humbox.theme.round, x, y, w, h, color_bmrp_dark )
		elseif gm == 2 then
			draw.RoundedBox( humbox.theme.round, x, y, w, h + .5*humbox.theme.rem, color_c17 )
			draw.RoundedBox( humbox.theme.round, x, y, w, h, color_c17_dark )
		elseif gm == 3 then
			draw.RoundedBox( humbox.theme.round, x, y, w, h + .5*humbox.theme.rem, color_outland )
			draw.RoundedBox( humbox.theme.round, x, y, w, h, color_outland_dark )
		end

		if gm == 1 then
			local funds = ply:GetNWInt( "Funds" )
			draw.StatusBar(
				x + 0.5 * humbox.theme.rem,
				y + 0.5 * humbox.theme.rem,
				w - humbox.theme.rem,
				1.5 * humbox.theme.rem,
				humbox.theme.blue,
				100,
				100,
				"",
				"",
				false,
				"Personal Funds: "..funds
			)
		else
			local loyalty = ply:GetNWInt( "Loyalty" )
			draw.StatusBar(
				x + 0.5 * humbox.theme.rem,
				y + 0.5 * humbox.theme.rem,
				w - humbox.theme.rem,
				1.5 * humbox.theme.rem,
				humbox.theme.blue,
				loyalty,
				100,
				"",
				"",
				false,
				"Combine Loyalty: "..loyalty.."%"
			)
		end
	end
end )

-- HUDShouldDraw
local HideElements = {"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"}
local function HUDShouldDraw( Element )
	if table.HasValue( HideElements, Element ) then return false end
end
hook.Add( "HUDShouldDraw", "HUDShouldDraw", HUDShouldDraw )
