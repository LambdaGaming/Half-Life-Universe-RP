AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Portal Event Fixer"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

function ENT:SpawnFunction( ply, tr )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( "event_portal_fix" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel( "models/props/hl10props/amsmachine02.mdl" )
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetTrigger( true )
	end
 
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	
	if SERVER then
		self:SetHealth( 0 )
		self:SetMaxHealth( 100 )
	end
	self.broke = false
end

function ENT:Use( caller, activator )
	if !self.broke then DarkRP.notify( caller, 1, 6, "You visually inspect the portal but find nothing out of the ordinary." ) return end
	if caller:Team() != TEAM_SERVICE and self.broke then DarkRP.notify( caller, 1, 6, "The portal is broken. Contact a service official to have it fixed." ) return end
	if caller:Team() == TEAM_SERVICE and self.broke then DarkRP.notify( caller, 1, 6, "The portal is broken. Use your wrench to attempt repairs." ) end
end

function ENT:Think()
	if self.broke then
		if(math.random(1,8)==7)then
			local effectdata=EffectData()
			effectdata:SetOrigin(self:GetPos()+self:GetUp()*math.random(10,25))
			effectdata:SetNormal(VectorRand())
			effectdata:SetMagnitude(3) --amount and shoot hardness
			effectdata:SetScale(1) --length of strands
			effectdata:SetRadius(3) --thickness of strands
			util.Effect("Sparks",effectdata,true,true)
			self:EmitSound("ambient/energy/spark"..math.random(1,6)..".wav")
		end
	end
end

function ENT:StartTouch( ent )
	if ent:GetClass() == "event_crystal" then
		local ed = EffectData()
		ed:SetOrigin( ent:GetPos() + Vector( 0, 0, 30 ) )
		ed:SetNormal(VectorRand())
		ed:SetMagnitude(3)
		ed:SetScale(1)
		ed:SetRadius(3)
		util.Effect( "Sparks", ed )
		ent:Remove()
		self:EmitSound( "ambient/machines/teleport1.wav" )
		DarkRP.createMoneyBag( self:GetPos() + Vector( 30, 0, 0 ), 200 )
	end
end

function ENT:OnTakeDamage( dmg )
	if self.broke then
		if dmg:GetAttacker():GetActiveWeapon():GetClass() == "weapon_pipewrench" then
			self:SetHealth( self:Health() + 10 )
			dmg:GetAttacker():ChatPrint( "Portal repairs: "..self:Health().."%" )
			if self:Health() >= 100 then
				self.broke = false
				PortalFix()
				self:SetHealth( 0 )
				DarkRP.notify( dmg:GetAttacker(), 0, 6, "You rewire a few circuits and reboot the system, it appears to be working now. Award: +400" )
				dmg:GetAttacker():addMoney( 400 )
				for k,v in pairs( player.GetAll() ) do
					DarkRP.talkToPerson( v, Color( 64, 255, 35 ), "The portal has been repaired!" )
				end
			end
		end
		return
	end
	--[[
	if self:Health() > 0 then self:SetHealth( self:Health() - 4 ) end --Disabled until I can have all buttons disabled to prevent the portal from breaking
	if self:Health() <= 0 then
		PortalBreakDown()
	end
	]]
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end