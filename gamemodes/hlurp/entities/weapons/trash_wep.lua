AddCSLuaFile()

SWEP.PrintName = "Trash Bag"
SWEP.Category = "Superadmin Only"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Base = "weapon_base"
SWEP.Author = "Lambda Gaming"
SWEP.Slot = 3

SWEP.ViewModel = ""
SWEP.WorldModel = ""

SWEP.Primary.Ammo = "none"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

function SWEP:PrimaryAttack()
	if !IsFirstTimePredicted() or CLIENT then return end
    local tr = self.Owner:GetEyeTrace().Entity
	if self.Owner:GetPos():DistToSqr( tr:GetPos() ) > 90000 then return end
	if GLOBAL_WHITELIST[tr:GetClass()] then
		local e = ents.Create( "trash_ent" )
		e:SetPos( tr:GetPos() )
		e:SetAngles( tr:GetAngles() )
		e:Spawn()
		e:EmitSound( "physics/cardboard/cardboard_box_impact_soft"..math.random( 1, 7 )..".wav" )
		tr:Remove()
	end
    self:SetNextPrimaryFire( CurTime() + 1 )
end
