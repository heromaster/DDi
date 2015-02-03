Scriptname zadPrismTestScript extends zadEquipScript  


Event OnUnequipped(Actor akActor)
	int oldMask = DeviceRendered.GetSlotMask()
	int newMask
	if oldMask == 0x00080000
		newMask = 0x00040000
	Else
		newMask = 0x00080000
	EndIf
	ArmorAddon renderedAA = deviceRendered.GetNthArmorAddon(0)
	DeviceRendered.SetSlotMask(newMask)
	renderedAA.SetSlotMask(newMask)
	libs.NotifyPlayer("OldMask: " + oldMask)
	libs.NotifyPlayer("NewMask: " + newMask)
	libs.Log("OldMask: " + oldMask)
	libs.Log("NewMask: " + newMask)
	akActor.EquipItem(deviceInventory)
EndEvent
