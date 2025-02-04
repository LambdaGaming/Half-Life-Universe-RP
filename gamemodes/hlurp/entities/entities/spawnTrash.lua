AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Trash Entity"
ENT.Author = "Brill Baker"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

local trash = {
	"models/props_junk/garbage256_composite002b.mdl",
	"models/props_junk/garbage256_composite002a.mdl",
	"models/props_junk/garbage256_composite001b.mdl",
	"models/props_junk/garbage256_composite001a.mdl"
}

local sound = {
	"physics/cardboard/cardboard_box_impact_soft1.wav",
	"physics/cardboard/cardboard_box_impact_soft2.wav",
	"physics/cardboard/cardboard_box_impact_soft3.wav",
	"physics/cardboard/cardboard_box_impact_soft4.wav",
	"physics/cardboard/cardboard_box_impact_soft5.wav"
}

if SERVER then
	function ENT:Initialize()
		self:SetModel( table.Random(trash) )
		self:SetMoveType( MOVETYPE_NONE )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetHealth( 50 )
			
		self:SetUseType( SIMPLE_USE )
		local e = EffectData()
		e:SetOrigin( self:GetPos() )
		e:SetScale( 1000 )
		util.Effect( "WheelDust", e )
		self:EmitSound( table.Random(sound) )

		local phys = self:GetPhysicsObject()
			if phys:IsValid() then
			phys:Wake()
			end

	end
    
	function ENT:Use( activator, caller )
		HLU_Notify( activator, "This place is filthy! Get someone from Service to clean it up.", 0, 6 )
	end

	function ENT:OnTakeDamage( dmg )
		if dmg:GetAttacker():IsPlayer() then
			local wep = dmg:GetAttacker():GetActiveWeapon()
			if wep:GetClass() == "Trash Bag" then
				self:SetHealth( self:Health() - 3 )
			end
			if self:Health() <= 0 or dmg:IsDamageType( DMG_BLAST ) then
				local e = EffectData()
				e:SetOrigin( self:GetPos() )
				e:SetScale( 1000 )
				util.Effect( "WheelDust", e )
				self:EmitSound( table.Random(sound) )
				self:Remove()
				dmg:GetAttacker():AddFunds(100)
			end
		end
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end
