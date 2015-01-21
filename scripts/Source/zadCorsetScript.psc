Scriptname zadCorsetScript extends zadEquipScript  

Armor Property stateDefault Auto
Armor Property stateBeltedFull Auto 
Armor Property stateBeltedOpen Auto 


Function UpdateState(actor akActor) 
	armor tmp = DeviceRendered
	int currentState = StorageUtil.GetIntValue(akActor, "zad_StoredCorsetRendered", 0)
	libs.Log("UpdateState("+currentState+")")
	if currentState == 0
		DeviceRendered = stateDefault
	ElseIf currentState == 1
		deviceRendered = stateBeltedOpen
	ElseIf currentState == 2
		deviceRendered = stateBeltedFull
	EndIf
	if !akActor.IsEquipped(deviceRendered)
		akActor.RemoveItem(stateDefault, 1, true)
		akActor.RemoveItem(stateBeltedFull, 1, true)
		akActor.RemoveItem(stateBeltedOpen, 1, true)
		akActor.EquipItem(deviceRendered, true, true)
	EndIf
EndFunction

Function StoreCorset(actor akActor)
	libs.Log("StoreCorset("+deviceInventory+")")
	StorageUtil.SetFormValue(akActor, "zad_StoredCorsetInventory", deviceInventory)
	; StorageUtil.SetFormValue(akActor, "zad_StoredCorsetRendered", deviceRendered)
EndFunction

Function PurgeCorset(actor akActor)
	StorageUtil.UnSetIntValue(akActor, "zad_StoredCorsetRendered")
	StorageUtil.UnSetFormValue(akActor, "zad_StoredCorsetInventory")
	libs.Log("PurgeCorset()")
EndFunction

Function OnEquippedPre(actor akActor, bool silent=false)
	if !silent
		libs.NotifyActor("You pull the corset around "+GetMessageName(akActor)+" waist, and lock it in the back.", akActor, true)
	EndIf
	libs.UpdateCorsetState(akActor)
	UpdateState(akActor)
	StoreCorset(akActor)
	Parent.OnEquippedPre(akActor, silent)
EndFunction

Function OnEquippedPost(actor akActor)
	libs.Log("RestraintScript OnEquippedPost Corset")
EndFunction

Function OnRemoveDevice(actor akActor)
	PurgeCorset(akActor)
EndFunction

Function OnUnequipped(actor akActor)
	if StorageUtil.GetIntValue(akActor, "zad_RemovalToken" + deviceInventory, 0) < 1
		UpdateState(akActor)
	EndIf
	Parent.OnUnequipped(akActor)
EndFunction

Function EquipDevice(actor akActor, bool skipMutex=false)
	UpdateState(akActor)
	Parent.EquipDevice(akActor, skipMutex)
EndFunction
