AddCSLuaFile()

SWEP.PrintName = "Combine Door Authorization"
SWEP.Category = "Door System"
SWEP.Spawnable = true
SWEP.Base = "weapon_base"
SWEP.Author = "OPGman"
SWEP.Slot = 2
SWEP.ViewModel = "models/weapons/v_emptool.mdl"
SWEP.WorldModel = "models/weapons/w_emptool.mdl"
SWEP.UseHands = true
SWEP.OpenSound = "buttons/combine_button1.wav"

SWEP.Primary.Ammo = "none"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

function SWEP:Initialize()
	self:SetHoldType( "pistol" )
end

function SWEP:PrimaryAttack()
	if !IsFirstTimePredicted() or CLIENT then return end
	local door = self.Owner:GetDoor()
	if !IsValid( door ) then return end
	if hook.Run( "DoorSystem_CanRam", self.Owner, door ) == false then return end
	self.Owner:EmitSound( self.OpenSound )
	self.Owner:ViewPunch( Angle( -10, 0, 0 ) )
	timer.Simple( 1, function()
		door:Fire( "unlock", "", 0 )
		door:Fire( "open", "", 0 )
	end )
	self:SetNextPrimaryFire( CurTime() + 1 )
end

function SWEP:SecondaryAttack()
end
