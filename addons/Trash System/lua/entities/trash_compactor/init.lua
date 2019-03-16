AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:SpawnFunction( ply, tr )
	
	if !tr.Hit then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 1

	local ent = ents.Create( "trash_compactor" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
end

function ENT:Initialize()
 
	self:SetModel( "models/props/halflifeoneprops4/radmachine.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetTrigger( true )
	self:SetUseType( SIMPLE_USE )
 
        local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:Use( activator, caller )
local greenlight = ents.Create("light_dynamic")
	if caller:IsPlayer() then
		for k, v in pairs( ents.FindInSphere( self:GetPos(), 500 ) ) do
			local entowner = v:GetOwner()
			if v:GetClass() == "prop_physics" and v:GetModel() == "models/sligwolf/garbagetruck/sw_trashbag_1.mdl" or v:GetModel() == "models/sligwolf/garbagetruck/sw_trashbag_2.mdl" or v:GetModel() == "models/sligwolf/garbagetruck/sw_trashbag_3.mdl" then
				timer.Simple(4.4, function() 
					self:EmitSound("ambient/energy/weld2.wav") 
					greenlight:SetPos( self:GetPos() )
					greenlight:SetParent(self)
					greenlight:SetKeyValue( "_light", "255 255 0 255" )  
					greenlight:SetKeyValue("distance", "1000" )
					greenlight:SetKeyValue( "brightness", "2" )
					greenlight:Spawn()
				end )
				timer.Simple(5, function() greenlight:Remove() end )
				self:EmitSound("HL1/ambience/particle_suck2.wav")
				caller:addMoney(100)
				DarkRP.notify(caller, 0, 4, "You have been given $100 for disposing of a trash bag.")
				v:Remove()
			end
		end
	end
end

function ENT:OnRemove()
	if IsValid(greenlight) then greenlight:Remove() end
end