--Modified lockpick originally from DarkRP

AddCSLuaFile()

SWEP.PrintName = "Lock Pick"
SWEP.Slot = 5
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.Author = "DarkRP Developers"
SWEP.Instructions = "Left or right click to pick a lock"
SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.ViewModel = Model( "models/weapons/c_crowbar.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_crowbar.mdl" )
SWEP.UseHands = true
SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Category = "DarkRP"
SWEP.Sound = Sound( "physics/wood/wood_box_impact_hard3.wav" )

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

function SWEP:Initialize()
	self:SetHoldType( "normal" )
end

function SWEP:SetupDataTables()
	self:NetworkVar( "Bool", 0, "IsLockpicking" )
	self:NetworkVar( "Float", 0, "LockpickStartTime" )
	self:NetworkVar( "Float", 1, "LockpickEndTime" )
	self:NetworkVar( "Float", 2, "NextSoundTime" )
	self:NetworkVar( "Int", 0, "TotalLockpicks" )
	self:NetworkVar( "Entity", 0, "LockpickEnt" )
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire( CurTime() + 2 )
	if self:GetIsLockpicking() then return end

	self:GetOwner():LagCompensation( true )
	local trace = self:GetOwner():GetEyeTrace()
	self:GetOwner():LagCompensation( false )
	local ent = trace.Entity

	if !IsValid( ent ) then return end

	self:SetHoldType( "pistol" )
	self:SetIsLockpicking( true )
	self:SetLockpickEnt( ent )
	self:SetLockpickStartTime( CurTime() )
	local endDelta = hook.Call( "lockpickTime", nil, self:GetOwner(), ent ) or util.SharedRandom( "Lockpick" .. self:EntIndex() .. "_" .. self:GetTotalLockpicks(), 10, 30 )
	self:SetLockpickEndTime( CurTime() + endDelta )
	self:SetTotalLockpicks( self:GetTotalLockpicks() + 1 )

	if IsFirstTimePredicted() then
		hook.Call( "lockpickStarted", nil, self:GetOwner(), ent, trace )
	end

	if CLIENT then
		self.Dots = ""
		self.NextDotsTime = SysTime() + 0.5
		return
	end
end

function SWEP:Holster()
	self:SetIsLockpicking( false )
	self:SetLockpickEnt( nil )
	return true
end

function SWEP:Succeed()
	self:SetHoldType( "normal" )

	local ent = self:GetLockpickEnt()
	self:SetIsLockpicking( false )
	self:SetLockpickEnt( nil )

	if !IsValid( ent ) then return end
	local override = hook.Call( "onLockpickCompleted", nil, self:GetOwner(), true, ent )
	if override then return end

	if ent.isFadingDoor and ent.fadeActivate and !ent.fadeActive then
		ent:fadeActivate()
		if IsFirstTimePredicted() then
			timer.Simple( 5, function()
				if IsValid( ent ) and ent.fadeActive then
					ent:fadeDeactivate()
				end
			end )
		end
	elseif ent.Fire then
		ent:Fire( "unlock", "", 0.01 )
		ent:Fire( "open", "", .6 )
		ent:Fire( "setanimation", "open", .6 )
	end
end

function SWEP:Fail()
	self:SetIsLockpicking( false )
	self:SetHoldType( "normal" )
	hook.Call( "onLockpickCompleted", nil, self:GetOwner(), false, self:GetLockpickEnt() )
	self:SetLockpickEnt( nil )
end

local dots = {
	[0] = ".",
	[1] = "..",
	[2] = "...",
	[3] = ""
}
function SWEP:Think()
	if !self:GetIsLockpicking() or self:GetLockpickEndTime() == 0 then return end

	if CurTime() >= self:GetNextSoundTime() then
		self:SetNextSoundTime( CurTime() + 1 )
		local snd = { 1, 3, 4 }
		self:EmitSound( "weapons/357/357_reload" .. tostring( snd[math.Round( util.SharedRandom( "LockpickSnd" .. CurTime(), 1, #snd ) )] ) .. ".wav", 50, 100 )
	end
	if CLIENT and ( !self.NextDotsTime or SysTime() >= self.NextDotsTime ) then
		self.NextDotsTime = SysTime() + 0.5
		self.Dots = self.Dots or ""
		local len = string.len( self.Dots )
		self.Dots = dots[len]
	end

	local trace = self:GetOwner():GetEyeTrace()
	if !IsValid( trace.Entity ) or trace.Entity ~= self:GetLockpickEnt() or trace.HitPos:DistToSqr( self:GetOwner():GetShootPos() ) > 10000 then
		self:Fail()
	elseif self:GetLockpickEndTime() <= CurTime() then
		self:Succeed()
	end
end

function SWEP:DrawHUD()
	if !self:GetIsLockpicking() or self:GetLockpickEndTime() == 0 then return end

	self.Dots = self.Dots or ""
	local w = ScrW()
	local h = ScrH()
	local x, y, width, height = w / 2 - w / 10, h / 2 - 60, w / 5, h / 15
	draw.RoundedBox( 8, x, y, width, height, Color( 10,10,10,120 ) )

	local time = self:GetLockpickEndTime() - self:GetLockpickStartTime()
	local curtime = CurTime() - self:GetLockpickStartTime()
	local status = math.Clamp( curtime / time, 0, 1 )
	local BarWidth = status * ( width - 16 )
	local cornerRadius = math.Min( 8, BarWidth / 3 * 2 - BarWidth / 3 * 2 % 2 )
	draw.RoundedBox( cornerRadius, x + 8, y + 8, BarWidth, height - 16, Color( 255 - ( status * 255 ), 0 + ( status * 255 ), 0, 255 ) )
	draw.SimpleText( "Picking lock" .. self.Dots, "Trebuchet24", w / 2, y + height / 2, color_white, 1, 1 )
end

function SWEP:SecondaryAttack()
	self:PrimaryAttack()
end
