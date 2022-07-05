AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Rebel Teleporter"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

if SERVER then
	local TeleCoords = {
		["rp_city17_build210"] = Vector( 6286, -1759 ,4220 ),
		["rp_ineu_valley2_v1a"] = Vector( 7121, 14434, 1328 ),
		["rp_city17_district47"] = Vector( -623, -2533, 704 ),
		["rp_city24_v3"] = Vector( 14548, 4986, 2064 ),
		["gm_boreas"] = Vector( 1734, -14423, -6575 )
	}

	function ENT:Initialize()
		self:SetModel( "models/props_lab/teleplatform.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
		self:SetHealth( 100 )
		self:SetMaxHealth( 100 )
		
		self.active = false
	end

	function ENT:Use( caller, activator )
		if self.active then
			HLU_Notify( caller, "The teleporter is currently in use.", 1, 6 )
			return
		end
		if IsValid( caller ) and caller:Alive() then
			self.active = true
			timer.Simple( 1, function()
				HLU_Notify( caller, "Teleport starting...", 0, 6 )
			end )
			self:EmitSound( "ambient/levels/labs/teleport_mechanism_windup"..math.random( 1, 5 )..".wav" )
			
			local time = 5
			timer.Create( "TeleportTimer", 1, 5, function()
				HLU_Notify( caller, "Teleporting in: "..tostring( time ), 0, 6 )
				time = time - 1
			end )

			timer.Simple( 7, function()
				local map = game.GetMap()
				if !TeleCoords[map] then
					HLU_Notify( caller, "ERROR: Current map detected as invalid.", 1, 6 )
					return
				end
				caller:SetPos( TeleCoords[map] )
				self:EmitSound( "ambient/machines/teleport"..math.random( 3, 4 )..".wav" )
				caller:EmitSound( "ambient/machines/teleport"..math.random( 3, 4 )..".wav" )

				local ed = EffectData()
				ed:SetOrigin( caller:GetPos() + Vector( 0, 0, 30 ) )
				ed:SetNormal(VectorRand())
				ed:SetMagnitude(3)
				ed:SetScale(1)
				ed:SetRadius(3)
				util.Effect( "Sparks", ed )
				self.active = false
			end )
		end
	end

	function ENT:OnTakeDamage()
		local dmg = DamageInfo():GetDamage()
		self:SetHealth( self:Health() - dmg )
		if self:Health() <= 0 then
			local explode = ents.Create( "env_explosion" )
			explode:SetPos( self:GetPos() )
			explode:Spawn()
			explode:SetKeyValue( "iMagnitude", "0" )
			explode:Fire( "Explode", 0, 0 )
			self:Remove()
		end
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end