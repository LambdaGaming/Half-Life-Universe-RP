AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Ammo Locker"
ENT.Author = "Lambda Gaming"
ENT.Category = "Superadmin Only"
ENT.Spawnable = true

if SERVER then
	function ENT:Initialize()
		self:SetModel( "models/props_c17/Lockers001a.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
		
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:EnableMotion( false )
			phys:Wake()
		end
		self.Used = false
	end

	local AmmoTypes = {
		["Buckshot"] = "item_box_buckshot",
		["Pistol"] = "item_ammo_pistol_large",
		["SMG1"] = "item_ammo_smg1",
		["XBowBolt"] = "item_ammo_crossbow",
		["AR2"] = "item_ammo_ar2_large",
		["AR2AltFire"] = "item_ammo_ar2_altfire",
		["SMG1_Grenade"] = "item_ammo_smg1_grenade",
		["bp_sniper"] = "bp_sniper_ammo"
	}

	function ENT:Use( ply )
		if self.Used then return end
		local getwep = ply:GetActiveWeapon()
		local primaryammo = getwep:GetPrimaryAmmoType()
		local secondaryammo = getwep:GetSecondaryAmmoType()
		local primaryname = game.GetAmmoName( primaryammo )
		local secondaryname = game.GetAmmoName( secondaryammo )
		if !AmmoTypes[primaryname] then
			HLU_Notify( ply, "Ammo is not available for this weapon.", 1, 6 )
			return
		end
		self.Used = true
		ply:EmitSound( "doors/metal_stop1.wav", 50, 100 )
		timer.Simple( 1.5, function()
			if !IsValid( self ) then return end
			local pos, ang = LocalToWorld( Vector( 20, -5, -30 ), Angle( -90, -90, 0 ), self:GetPos(), self:GetAngles() )
			local ammo = ents.Create( AmmoTypes[primaryname] )
			ammo:SetPos( pos )
			ammo:SetAngles( ang )
			ammo:Spawn()
			if AmmoTypes[secondaryname] then
				local ammo2 = ents.Create( AmmoTypes[secondaryname] )
				ammo2:SetPos( pos )
				ammo2:SetAngles( ang )
				ammo2:Spawn()
			end
			self.Used = false
		end )
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end
