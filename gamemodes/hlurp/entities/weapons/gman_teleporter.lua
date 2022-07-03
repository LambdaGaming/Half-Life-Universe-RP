AddCSLuaFile()

SWEP.PrintName = "Gman Teleporter"
SWEP.Category = "Superadmin Only"
SWEP.Spawnable = true
SWEP.AdminOnly = true
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

function SWEP:Deploy()
	self:SetHoldType( "normal" )
end

local SavedPos, SavedAng
function SWEP:PrimaryAttack()
	if !IsFirstTimePredicted() then return end
	if !SavedPos and SERVER then
		self:GetOwner():ChatPrint( "Right click to set a position first!" )
		return
	end
	if CLIENT then
		local ed = EffectData()
		ed:SetOrigin( self:GetOwner():GetPos() + Vector( 0, 0, 20 ) )
		ed:SetNormal( VectorRand() )
		ed:SetMagnitude( 3 )
		ed:SetScale( 1 )
		ed:SetRadius( 3 )
		util.Effect( "Sparks", ed )
	end
	if SERVER then
		self:GetOwner():EmitSound( "ambient/machines/teleport1.wav" )
		self:GetOwner():SetPos( SavedPos )
		self:GetOwner():SetAngles( SavedAng )
		self:SetNextPrimaryFire( CurTime() + 1 )
	end
end

function SWEP:SecondaryAttack()
	if !IsFirstTimePredicted() or CLIENT then return end
	SavedPos = self:GetOwner():GetPos()
	SavedAng = self:GetOwner():GetAngles()
	self:GetOwner():ChatPrint( "Position saved!" )
	self:SetNextPrimaryFire( CurTime() + 1 )
end
