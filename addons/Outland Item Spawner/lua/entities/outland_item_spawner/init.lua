AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	local randmodel = {
		"models/props_debris/concrete_debris128pile001a.mdl",
		"models/props_debris/concrete_cornerpile01a.mdl",
		"models/props_debris/concrete_debris128pile001b.mdl",
		"models/props_debris/concrete_floorpile01a.mdl",
		"models/props_debris/concrete_spawnplug001a.mdl",
		"models/props_debris/plaster_ceilingpile001a.mdl"
	}

    self:SetModel( table.Random(randmodel) )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	
	local items = {
		"ent_jack_turretammobox_9mm",
		"ent_jack_turretammobox_9mm",
		"ent_jack_turretammobox_9mm",
		"ent_jack_turretammobox_22",
		"ent_jack_turretammobox_22",
		"ent_jack_turretammobox_22",
		"ent_jack_turretammobox_22",
		"ent_jack_turretammobox_556",
		"ent_jack_turretammobox_556",
		"ent_jack_turretammobox_762",
		"ent_jack_turretbattery",
		"ent_jack_turretbattery"
	}
	
	timer.Create( tostring( self:EntIndex() ), 60, 0, function()
		for k,v in pairs( ents.FindInSphere( self:GetPos(), 200 ) ) do
			if table.HasValue( items, v:GetClass() ) then
				return
			end
		end
		local spawnitem = ents.Create( table.Random( items ) )
		spawnitem:SetPos( self:GetPos() + Vector( 0, 0, 20 ) )
		spawnitem:Spawn()
	end )
end

function ENT:OnRemove()
	timer.Remove( tostring( self:EntIndex() ) )
end