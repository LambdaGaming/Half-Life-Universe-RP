// Create a shell if it doesn't exist
// Failsafe to be able to work independent

if not humbox then
	humbox = {}
end

// If no theme has been initialized, do this
if not humbox.theme then
	humbox.theme = {}
end

// DEFAULT THEME
humbox.theme.rem = 14
humbox.theme.round = 4

humbox.theme.bg = Color(142, 71, 0)
humbox.theme.bgAlternative = Color(107, 53, 0)
humbox.theme.txt = Color(255, 255, 255)
humbox.theme.txtAlternative = Color(98, 106, 122)
humbox.theme.red = Color(240, 100, 85)
humbox.theme.green = Color(160, 230, 80)
humbox.theme.blue = Color(80, 180, 230)
humbox.theme.yellow = Color(240, 180, 80)

// Read custom theme
local fileName = "humbox/theme.txt"
if file.Exists(fileName, "DATA") then
	table.Merge(humbox.theme, util.JSONToTable(file.Read(fileName, "DATA")))
end

// Create transparency function
function humbox.theme:Transparency(colour, opacity)
	return Color(colour.r, colour.g, colour.b, opacity*255)
end

// Overwrite global fonts for humbox
if CLIENT then
	// - hud description font tags
	surface.CreateFont("Description", {
			font = "Open Sans",
			size = .9*humbox.theme.rem,
			weight = 400,
			antialias = true,
	})

	// - chat font
	surface.CreateFont("ChatFont", {
			font = "Open Sans",
			size = 1.25*humbox.theme.rem,
			weight = 700,
			antialias = true,
	})
end

print("Humbox theme initialization complete")
