AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

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
	if !activator:IsPlayer() then return end
	if self:GetNPCType() == 0 then
		HLU_Notify( activator, "ERROR: NPC isn't fully initialized.", 1, 6 )
		return
	end
	local useCheck = ItemNPCType[self:GetNPCType()].UseCheck
	if useCheck and useCheck( activator ) == false then return end
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
	local name = ItemNPC[ent].Name
	local max = ItemNPC[ent].Max
	local realclass = ItemNPC[ent].RealClass or ent --Fix for having 2 different items with the same class name
	if max and max > 0 and #ents.FindByClass( realclass ) >= max then
		HLU_Notify( ply, "Global limit reached. Remove some instances of this entity to spawn it again.", 1, 6 )
		return
	end
	if SpawnCheck and SpawnCheck( ply, self ) == false then return end
	if SpawnItem then
		SpawnItem( ply, self )
		HLU_Notify( ply, "You have purchased a "..name..".", 0, 6 )
	else
		HLU_Notify( ply, "ERROR: SpawnFunction for this item not detected!", 1, 6 )
	end
end )
