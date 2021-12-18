esx                        = nil
local PlayerData                = {}
Citizen.CreateThread(function()
	while esx == nil do
		TriggerEvent('esx:getSharedObject', function(obj) esx = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)
	PlayerData = esx.GetPlayerData()
end)
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	
	Citizen.Wait(5000)

end)

RegisterNetEvent('szxna_characterkill:openmenu')
AddEventHandler('szxna_characterkill:openmenu', function()
	local playerPed = GetPlayerPed(-1)
	local coords	= GetEntityCoords(playerPed)
    esx.UI.Menu.CloseAll()

	esx.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'characterkillmenu',
	{
		title    = 'usuń postać',
		align    = 'bottom-right',
		elements = {
			{label = 'nie',	value = '1'},
			{label = 'tak',	value = '2'}

		}
	}, function(data, menu)		               
    local action = data.current.value

        if action == '1' then
            esx.UI.Menu.CloseAll()
		end
		if action == '2' then
            TriggerServerEvent('szxna_characterkill:removedb', source)
        end
	end, function(data, menu)
		menu.close()
	end)
end)