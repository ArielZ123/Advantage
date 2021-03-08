ESX = nil
local PlayerData = {}
Citizen.CreateThread(function()

	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

-- Combat Fight Advantage [running by timer!]
Citizen.CreateThread(function()
   while true do
  if IsPedInMeleeCombat then
    local time = 10 -- 10 seconds
    while (time ~= 0) do
        Citizen.Wait(5000)
        time = time - 1
	SetWeaponDamageModifier(GetHashKey("weapon_unarmed"), 0.1)
        end

     if IsPedInMeleeCombat then
       SetWeaponDamageModifier(GetHashKey("weapon_unarmed"), 1.4)
	end
   end	
  end
 end)

--running Advantage [running by timer!]
Citizen.CreateThread(function()
   while true do
  if IsPedRunning then
    local time = 5 -- 5 seconds
    while (time ~= 0) do
        Citizen.Wait(5000)
        time = time - 1
        SetRunSprintMultiplierForPlayer(PlayerId(),1.8)
	SetPedMoveRateOverride(PlayerId(),1.1)
        end
     end
 end
end)

-- Police Movment Advantage 
Citizen.CreateThread(function()
    while true do
       Citizen.Wait(0)
    if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
      SetPedMoveRateOverride(PlayerId(),1.5)
      SetRunSprintMultiplierForPlayer(PlayerId(),1.10)
      end
  end	
end)

-- swimming Advantage
Citizen.CreateThread(function()
    while true do
       Citizen.Wait(0)
    if PlayerData.job~= nil and PlayerData.job.name == 'police' then
	SetSwimMultiplierForPlayer(PlayerId(), 1.49)
    end
  end
end)

-- Stamina Advantage
Citizen.CreateThread(function()
    while true do
       Citizen.Wait(0)
    if PlayerData.job~= nil and PlayerData.job.name== 'police' then
	   GetPlayerSprintStaminaRemaining(PlayerId(), 1.10)
    else
	   GetPlayerSprintStaminaRemaining(PlayerId(), 1.4)
    end
  end
end)

-- Guns Advantage 
Citizen.CreateThread(function()
    while true do
       Citizen.Wait(0)
	SetWeaponDamageModifier(GetHashKey("weapon_pistol"), 0.5)
	SetWeaponDamageModifier(GetHashKey("WEAPON_NIGHTSTICK"), 0)
	  --SetWeaponDamageModifier(GetHashKey("Weapon_Test"), 0 damage that the gun takes)
	end	
end)

Citizen.CreateThread(function()
    while true do
       Citizen.Wait(0)
    if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
	SetWeaponDamageModifier(GetHashKey("weapon_pistol"), 1.2)
	 --SetWeaponDamageModifier(GetHashKey("WEAPON_NIGHTSTICK"), 0 damage that the gun takes)
    end
  end	
end)

Citizen.CreateThread(function()
    while true do
       Citizen.Wait(0)
	 if GetEntityHealth(GetPlayerPed(-1)) <= 120 then
	    RequestAnimSet("move_m@injured")
	    SetPedMovementClipset(GetPlayerPed(-1), "move_m@injured", true)
	    SetPedMoveRateOverride(PlayerId(),0.1)
           SetRunSprintMultiplierForPlayer(PlayerId(),0.1 )
	 else
	 if GetEntityHealth(GetPlayerPed(-1)) > 121 then
	    ResetPedMovementClipset(GetPlayerPed(-1))
	    ResetPedWeaponMovementClipset(GetPlayerPed(-1))
	    ResetPedStrafeClipset(GetPlayerPed(-1))
	 end
  end
end
end)
