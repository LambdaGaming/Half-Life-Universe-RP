AddCSLuaFile()

SWEP.PrintName = "Two-Way Portal Pairing Tool"
SWEP.Category = "Superadmin Only"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Base = "weapon_base"
SWEP.Author = "Lambda Gaming"
SWEP.Slot = 3

SWEP.ViewModel = "models/weapons/v_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"

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
    if tr:GetClass() == "two_way_teleporter" then
    	if self.FirstPortal then
			if tr == self.FirstPortal then
				HLU_Notify( self.Owner, "ERROR: This portal is already selected to be linked.", 1, 6 )
				return
			end
			self.SecondPortal = tr
			self.FirstPortal:SetNWEntity( "PairedPortal", self.SecondPortal )
			self.SecondPortal:SetNWEntity( "PairedPortal", self.FirstPortal )
			HLU_Notify( self.Owner, "Portals linked.", 0, 6 )
			self.FirstPortal = nil 
			self.SecondPortal = nil
		else
			self.FirstPortal = tr
			HLU_Notify( self.Owner, "First portal info aquired.", 0, 6 )
		end
    end
    self:SetNextPrimaryFire( CurTime() + 1 )
end

function SWEP:SecondaryAttack()
	if !IsFirstTimePredicted() or CLIENT then return end
    local tr = self.Owner:GetEyeTrace().Entity
	if self.Owner:GetPos():DistToSqr( tr:GetPos() ) > 90000 then return end
    if tr:GetClass() == "two_way_teleporter" then
    	tr:SetNWEntity( "PairedPortal", nil )
		HLU_Notify( self.Owner, "Portal successfully unpaired.", 0, 6 )
    end
    self:SetNextPrimaryFire( CurTime() + 1 )
end

function SWEP:Holser()
	if IsFirstTimePredicted() and SERVER then
		self.FirstPortal = nil 
		self.SecondPortal = nil
	end
end
