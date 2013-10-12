--@@GLOBAL ENVIRONMENT BOOTUP
local _modname = assert( (assert(..., 'This file should be loaded through require.')):match('^[%a_][%w_%s]*') , 'Invalid path.' )
module( ..., package.seeall, require(_modname .. '.booter') )
--@@END ENVIRONMENT BOOTUP

local assets =
{
	Asset("ANIM", "anim/void_placeholder.zip"),
}

local function mine_remove(inst, chopper)
	inst.components.lootdropper:SpawnLootPrefab("cloud_coral_fragment")
	inst:Remove()
end

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("marble")
	inst.AnimState:SetBuild("void_placeholder")
	inst.AnimState:PlayAnimation("anim")

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
	
	inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetOnFinishCallback(mine_remove)
    inst.components.workable:SetWorkLeft(2)	

	return inst
end

return Prefab ("common/inventory/cloud_coral", fn, assets) 