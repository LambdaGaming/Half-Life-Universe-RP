
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 2
	local ent = ents.Create( "npc_item" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	ent:ApplyType( 1 )
	return ent
end

function ENT:ApplyType( type ) --This needs to be called externally sometime after the NPC is spawned for the items to show up
	self:SetNPCType( type )
	self:SetModel( ItemNPCType[type].Model )
end

function ENT:Initialize()
    self:SetModel( "models/breen.mdl" )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_BBOX )
	self:SetCollisionGroup( COLLISION_GROUP_PLAYER )
	self:SetUseType( SIMPLE_USE )
	
    local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

util.AddNetworkString( "ItemNPCMenu" )
function ENT:AcceptInput( input, activator )
	local allowed = ItemNPCType[self:GetNPCType()].Allowed
	if !activator:IsPlayer() then return end
	if self:GetNPCType() == 0 then
		HLU_Notify( activator, "ERROR: NPC isn't fully initialized.", 1, 6 )
		return
	end
	if allowed and !table.IsEmpty( allowed ) and !allowed[activator:Team()] then
		HLU_Notify( activator, "You cannot use this NPC as your current job.", 1, 6 )
		return
	end
	net.Start( "ItemNPCMenu" )
	net.WriteEntity( self )
	net.Send( activator )
end

util.AddNetworkString( "CreateItem" )
net.Receive( "CreateItem", function( len, ply )
	local self = net.ReadEntity()
	local ent = net.ReadString()
	local SpawnCheck = ItemNPC[ent].SpawnCheck
	local SpawnItem = ItemNPC[ent].SpawnFunction
	local money = GetGlobalInt( "BMRP_Budget" )
	local name = ItemNPC[ent].Name
	local price = ItemNPC[ent].Price
	local max = ItemNPC[ent].Max
	local realclass = ItemNPC[ent].RealClass or ent --Fix for having 2 different items with the same class name
	if max and max > 0 and #ents.FindByClass( realclass ) >= max then
		HLU_Notify( ply, "Global limit reached. Remove some instances of this entity to spawn it again." )
		return
	end
	if GetGlobalInt( "CurrentGamemode" ) == 1 then
		if money >= price then
			if SpawnCheck and SpawnCheck( ply, self ) == false then return end
			if SpawnItem then
				SpawnItem( ply, self )
				HLU_Notify( ply, "You have purchased a "..name..".", 0, 6 )
			else
				HLU_Notify( ply, "ERROR: SpawnFunction for this item not detected!", 1, 6 )
				return
			end
			ChangeBudget( -price )
		else
			HLU_Notify( ply, "The facility budget isn't high enough to purchase this item!", 1, 6 )
		end
		return
	end
	if SpawnCheck and SpawnCheck( ply, self ) == false then return end
	if SpawnItem then
		SpawnItem( ply, self )
		HLU_Notify( ply, "You have purchased a "..name..".", 0, 6 )
	else
		HLU_Notify( ply, "ERROR: SpawnFunction for this item not detected!", 1, 6 )
		return
	end
end )
