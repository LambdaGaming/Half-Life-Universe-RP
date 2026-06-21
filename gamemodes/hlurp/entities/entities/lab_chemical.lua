AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Chemical Container"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

if CLIENT then return end

sound.Add( {
	name = "lab_chemical_idle",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 60,
	pitch = { 95, 110 },
	sound = "ambient/levels/canals/toxic_slime_loop1.wav"
} )

function ENT:Initialize()
	self:SetModel( "models/czeror/models/biohazard_container.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetTrigger( true )
	self:PhysWake()
	self:EmitSound( "lab_chemical_idle" )
end

function ENT:StartTouch( ent )
	local class = ent:GetClass()
	if class == "crystal_fragment" then
		ent:SetColor( color_white )
		ent:SetMaterial( "models/alyx/emptool_glow" )
		self:EmitSound( "ambient/machines/machine1_hit1.wav" )
	elseif class == "crystal_harvested" then
		ent:SetModel( "models/props/xenprops/crystal.mdl" )
	elseif string.find( "_radioactive", class ) then
		local pos = ent:GetPos() + ent:GetUp() * math.random( 10, 25 )
		CreateEffect( "ElectricSpark", pos )
		local randchance = math.random( 0, 100 )
		if randchance >= 50 then
			local randnpc = {
				"npc_vj_hlr1_houndeye",
				"npc_vj_hlr1_bullsquid",
				"npc_vj_hlr1_headcrab",
				"npc_vj_hlr1_aliengrunt",
				"npc_vj_hlr1_alienslave"
			}
			local e = ents.Create( table.Random( randnpc ) )
			e:SetPos( self:GetPos() )
			e:Spawn()
			Explode( self:GetPos(), 0 )
			self:Remove()
		end
		ent:Remove()
	elseif class == "organic_matter_rare" then
		local randchance = math.random( 0, 100 )
		local randnpcs = {
			"npc_headcrab",
			"npc_headcrab_black",
			"npc_headcrab_fast",
			"npc_vj_hlr1_houndeye"
		}
		local newClass = randchance >= 50 and table.Random( randnpcs ) or "radioactive_blob"
		local e = ents.Create( newClass )
		e:SetPos( self:GetPos() + Vector( 0, 0, 20 ) )
		e:Spawn()
		self:EmitSound( "ambient/levels/canals/toxic_slime_gurgle"..math.random( 2, 8 )..".wav" )
		ent:Remove()
	elseif class == "organic_matter" or class == "xen_iron_refined" or class == "xen_iron" then
		self:SetColor( 0, 255, 0, 255 )
	end
end

function ENT:OnRemove()
	self:StopSound( "lab_chemical_idle" )
end
