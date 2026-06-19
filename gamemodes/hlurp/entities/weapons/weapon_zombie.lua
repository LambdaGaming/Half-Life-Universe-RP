--Zombie weapon originally created by William Moodhe for the Zombie Survival gamemode
--Modified by OPGman to modernize the code and make it work with HLU RP

AddCSLuaFile()

SWEP.PrintName = "Zombie"
SWEP.Category = "Zombies"
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.ViewModelFOV = 70
SWEP.CSMuzzleFlashes = false
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.HoldType = "knife"
SWEP.Purpose = "Kill Humans"
SWEP.Instructions = "Left click = Attack and Right click = Screech"
SWEP.ViewModel = "models/weapons/zombie/v_zombiearms.mdl"
SWEP.WorldModel = ""

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 1.6

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

function SWEP:Initialize()
    self:SetDeploySpeed( 1 )
end

function SWEP:Deploy()
    local owner = self:GetOwner()
	if !IsValid( owner ) then return end
    owner:SetRunSpeed( 140 )
    owner:SetWalkSpeed( 140 )
	owner:SetModel( "models/player/zombie_classic.mdl" )
	self:SendWeaponAnim( ACT_VM_DEPLOY )
	timer.Simple( 1.1, function()
        if !IsValid( self ) then return end
        self:SendWeaponAnim( ACT_VM_IDLE )
    end )
	return false
end

function SWEP:Think()
    if !self.NextHit or CurTime() < self.NextHit then return end
    self.NextHit = nil

    local pl = self:GetOwner()
    local vStart = pl:EyePos() + Vector( 0, 0, -10 )
    local trace = util.TraceLine( { start=vStart, endpos = vStart + pl:GetAimVector() * 71, filter = pl, mask = MASK_SHOT } )

    local ent
    if trace.HitNonWorld then
        ent = trace.Entity
    elseif self.PreHit and self.PreHit:IsValid() and !( self.PreHit:IsPlayer() and !self.PreHit:Alive() ) and self.PreHit:GetPos():DistToSqr( vStart ) < 12100 then
        ent = self.PreHit
        trace.Hit = true
    end

    if trace.Hit then
        pl:EmitSound( "npc/zombie/claw_strike"..math.random( 1, 3 )..".wav" )
    end

    pl:EmitSound( "npc/zombie/claw_miss"..math.random( 1, 2 )..".wav" )
    self.PreHit = nil
    if IsValid( ent ) and !( ent:IsPlayer() and !ent:Alive() ) then
        local damage = 25
        local phys = ent:GetPhysicsObject()
        if phys:IsValid() and !ent:IsNPC() and phys:IsMoveable() then
            local vel = damage * 487 * pl:GetAimVector()
            phys:ApplyForceOffset( vel, ( ent:NearestPoint( pl:GetShootPos() ) + ent:GetPos() * 2 ) / 3 )
            ent:SetPhysicsAttacker( pl )
        end
        if SERVER then
            ent:TakeDamage( damage, pl, self )
        end
    end
end

SWEP.NextSwing = 0
function SWEP:PrimaryAttack()
    if CurTime() < self.NextSwing then return end
	local attack = math.random( 1, 2 )
	if attack == 1 then
        self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
    elseif attack == 2 then
        self:SendWeaponAnim( ACT_VM_HITCENTER )
    end
	
	local owner = self:GetOwner()
	owner:DoAnimationEvent( ACT_GMOD_GESTURE_RANGE_ZOMBIE )
    owner:EmitSound( "npc/zombie/zo_attack"..math.random( 1, 2 )..".wav" )
	timer.Simple( 1.4, function()
        if !IsValid( self ) then return end
        self:SendWeaponAnim( ACT_VM_IDLE )
    end )
    self.NextSwing = CurTime() + self.Primary.Delay
    self.NextHit = CurTime() + 1
    local vStart = owner:EyePos() + Vector( 0, 0, -10 )
    local trace = util.TraceLine( { start = vStart, endpos = vStart + owner:GetAimVector() * 65, filter = owner, mask = MASK_SHOT } )
    if trace.HitNonWorld then
        self.PreHit = trace.Entity
    end
end

SWEP.NextMoan = 0
function SWEP:SecondaryAttack()
    if CurTime() < self.NextMoan then return end
    local owner = self:GetOwner()
	owner:DoAnimationEvent( ACT_GMOD_GESTURE_TAUNT_ZOMBIE )
    if SERVER then
        owner:EmitSound( "npc/zombie/zombie_voice_idle"..math.random( 1, 14 )..".wav" )
    end
    self.NextMoan = CurTime() + 3
end
