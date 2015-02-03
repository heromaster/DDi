Scriptname zadPrismTestScript extends zadEquipScript  

Function MaskTest(actor akActor)
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
	lan("OldMask: " + oldMask)
	lan("NewMask: " + newMask)
EndFunction

Function lan(string s)
	libs.Log(s)
	libs.NotifyPlayer(s)
EndFunction

Function ModelTest(actor akActor)
	ArmorAddon renderedAA = deviceRendered.GetNthArmorAddon(0)
	string path = "devious\\devices\\test.nif"
	int newMask = 0x00040000
	if renderedAA.GetModelPath(false, true) == path
		path = "devious\\devices\\beltPadded_1.nif"
		newMask = 0x00080000
	EndIf
	lan(renderedAA.GetModelPath(false, true) + " > " + path)
	renderedAA.SetModelPath(path, false, true)
	renderedAA.SetModelPath(path, false, false)
	renderedAA.SetSlotMask(newMask)
	devicerendered.SetSlotMask(newMask)
	; libs.PlayerRef.QueueNiNodeUpdate()
EndFunction


Event OnUnequipped(Actor akActor)
	ModelTest(akActor)
	akActor.EquipItem(deviceInventory)
EndEvent
