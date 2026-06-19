# Half-Life Universe RP
This repo contains all of the custom content for the Lambda Gaming Half-Life Universe RP Garry's Mod server including Lua files, configs, and data files.
If you're interested in hosting this server yourself, you're free to do so but support for that will not be provided. More information about this server can be found [here.](https://lambdagaming.github.io/hlurp)

If you have any suggestions or questions about the server or this repo, please discuss them on our Discord. I will accept PRs for bug, exploit, and optimization fixes without prior discussion as long as you explain everything that you changed. I will not accept PRs for anything else without prior discussion and approval.

# Additional Content
Alongside all of the content in this repo, the gamemode and server also rely on 3rd party addons and game content:
- [Server Addon Collection](https://steamcommunity.com/sharedfiles/filedetails/?id=2512304430)
- [Client Addon Collection](https://steamcommunity.com/sharedfiles/filedetails/?id=587127431)
- [Half-Life: Source](https://store.steampowered.com/app/280/HalfLife_Source/) (this might not actually be needed, need to do some testing)

# Missing Content
The following server-side content is currently missing because it cannot be redistributed:
- Poly's Booby Traps - Modified to fix bugs that the author refuses to fix. Author seems to be okay with people forking it so I might do that.
- Cuffs - Paid handcuffs addon that I can probably replace with an open source alternative.
- DarkRP Vending Machine - Heavily modified from the original, I can probably just make a new one from scratch at this point.
- Advanced Disguise SWEP - Heavily modified to work with the gamemode. It's not open source so I'll probably replace it with a custom version at some point.
- Door System - This is my own door system thats been partially modified to work better with the gamemode. I'll merge those changes upstream or create a separate branch.
- HL2 Beta Weapons - Modified to fix bugs and make the flare gun ignite players. The addon was last updated in 2021 so maybe these bugs are fixed and I can do something on the gamemode side with the flare gun.
- Shrun's HUD - Modified to work with the gamemode. It seems to have disappeared from the workshop so I don't know if it was open source or not. It needs to be replaced anyway so I'll get around to that eventually.
- Material URL Tool - Modified to fix a script error that appears for all clients when they first join. Unfortunately the author prohibits redistribution and has no interest in fixing this simple bug, so if you want to use it you will have to fix it yourself or deal with the error.
- Player Notifications - Modified to remove the notification sounds and possibly other things. It can probably be easily replaced with a custom version.
- Radioactive Ents - I don't remember what the original addon was called but it's been modified to work with the gamemode better. It can also probably be replaced with a custom version fairly easily.
- Rebel Rocket - Modified rocket from GBombs 5. Should probably be replaced because it's current implementation is extremely hacky.
- Vox Announcements - Heavily modified to work with the new Vox interface, might just make a custom version at this point.

# Credits
- Brill Baker - BMRP trash spawning system
- DarkRP Developers - Various pieces of DarkRP code used throughout the gamemode (Lockpick, Pocket, text wrapping)
- William Moodhe - Zombie SWEP from the Zombie Survival gamemode
- YuRaNnNzZZ - TFA VOX templates
- OPGman - Everything else
