
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
				DarkRP.notify( self.Owner, 1, 6, "ERROR: This portal is already selected to be linked." )
				return
			end
			self.SecondPortal = tr
			self.FirstPortal:SetNWEntity( "PairedPortal", self.SecondPortal )
			self.SecondPortal:SetNWEntity( "PairedPortal", self.FirstPortal )
			DarkRP.notify( self.Owner, 0, 6, "Portals linked." )
			self.FirstPortal = nil 
			self.SecondPortal = nil
		else
			self.FirstPortal = tr
			DarkRP.notify( self.Owner, 0, 6, "First portal info aquired." )
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
		DarkRP.notify( self.Owner, 0, 6, "Portal successfully unpaired." )
    end
    self:SetNextPrimaryFire( CurTime() + 1 )
end

function SWEP:Holser()
	if IsFirstTimePredicted() and SERVER then
		self.FirstPortal = nil 
		self.SecondPortal = nil
	end
end
