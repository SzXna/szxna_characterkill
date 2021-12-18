esx = nil

TriggerEvent('esx:getSharedObject', function(obj) esx = obj end)

TriggerEvent('es:addGroupCommand', 'ck', 'admin', function(source, args, user)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil then
		
			TriggerClientEvent('szxna_characterkill:openmenu', tonumber(args[1]))
		end
	else
		TriggerClientEvent('szxna_characterkill:openmenu', source)
	end
end)


RegisterServerEvent('szxna_characterkill:removedb')
AddEventHandler('szxna_characterkill:removedb', function()
	local identifier = GetPlayerIdentifier(source, 0)
	local name = GetPlayerName(source)
	local ip = GetPlayerEndpoint(source)
    local _source = source
    local xPlayer = esx.GetPlayerFromId(_source)
    local userhex = xPlayer.identifier
		sendtodiscord("Character Kill", "(ck) steamid: `" .. userhex .. "`\nsteamid: `" .. identifier .. "`")
        DropPlayer(source, 'Twoja postać została usunięta, zapraszamy do stworzenia nowej')
       
        MySQL.Sync.execute("DELETE FROM `user_inventory` WHERE identifier=@db", {['@db'] = userhex})
        MySQL.Sync.execute("DELETE FROM `users` WHERE identifier=@db", {['@db'] = userhex})
        MySQL.Sync.execute("DELETE FROM `user_accounts` WHERE identifier=@db", {['@db'] = userhex})
        MySQL.Sync.execute("DELETE FROM `user_inventory` WHERE identifier=@db", {['@db'] = userhex})
        MySQL.Sync.execute("DELETE FROM `user_kartoteka` WHERE identifier=@db", {['@db'] = userhex})
        MySQL.Sync.execute("DELETE FROM `phone_users_contacts` WHERE identifier=@db", {['@db'] = userhex})
        MySQL.Sync.execute("DELETE FROM `addon_account_data` WHERE owner=@db", {['@db'] = userhex})
        MySQL.Sync.execute("DELETE FROM `owned_vehicles` WHERE owner=@db", {['@db'] = userhex})
		MySQL.Sync.execute("DELETE FROM `owned_properties` WHERE owner=@db", {['@db'] = userhex})
        MySQL.Sync.execute("DELETE FROM `user_licenses` WHERE owner=@db", {['@db'] = userhex})
        MySQL.Sync.execute("DELETE FROM `datastore_data` WHERE owner=@db", {['@db'] = userhex})
        MySQL.Sync.execute("DELETE FROM `addon_inventory_items` WHERE owner=@db", {['@db'] = userhex})
        MySQL.Sync.execute("DELETE FROM `billing` WHERE identifier=@db", {['@db'] = userhex})
        MySQL.Sync.execute("DELETE FROM `characters` WHERE identifier=@db", {['@db'] = userhex})
		MySQL.Sync.execute("DELETE FROM `user_poszukiwania` WHERE identifier=@db", {['@db'] = userhex})
end)

function sendtodiscord(status, message)
	local wh = config.discordwebhook
	local date = os.date('*t')
    if date.month < 10 then date.month = '0' .. tostring(date.month) end
    if date.day < 10 then date.day = '0' .. tostring(date.day) end
    if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
    if date.min < 10 then date.min = '0' .. tostring(date.min) end
    if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
    local date = (''..date.day .. '.' .. date.month .. '.' .. date.year .. ' - ' .. date.hour .. ':' .. date.min .. ':' .. date.sec..'')
	local embed = {
		{
			["title"]= (status),
			['description'] = (message),
			["color"] = 38400,
				['image'] = {
					['url'] = "",
				},
				['author'] = {
					['name'] = "",
				},
				['footer'] = {
					['text'] = ("" .. date ..""),
				}
		}
	}
		PerformHttpRequest(wh, function(err, headers) end, 'POST', json.encode({ embeds = embed, content = ''}), { ['Content-Type'] = 'application/json' })
end