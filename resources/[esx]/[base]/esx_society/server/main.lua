ESX                 = nil
Jobs                = {}
RegisteredSocieties = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function stringsplit(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t={} ; i=1
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    t[i] = str
    i = i + 1
  end
  return t
end

function GetSociety(name)
  for i=1, #RegisteredSocieties, 1 do
    if RegisteredSocieties[i].name == name then
      return RegisteredSocieties[i]
    end
  end
end

AddEventHandler('onMySQLReady', function()

  local result = MySQL.Sync.fetchAll('SELECT * FROM jobs', {})

  for i=1, #result, 1 do
    Jobs[result[i].name]        = result[i]
    Jobs[result[i].name].grades = {}
  end

  local result2 = MySQL.Sync.fetchAll('SELECT * FROM job_grades', {})

  for i=1, #result2, 1 do
    Jobs[result2[i].job_name].grades[tostring(result2[i].grade)] = result2[i]
  end

end)

AddEventHandler('esx_society:registerSociety', function(name, label, account, datastore, inventory, data)

  local found = false

  local society = {
    name      = name,
    label     = label,
    account   = account,
    datastore = datastore,
    inventory = inventory,
    data      = data,
  }

  for i=1, #RegisteredSocieties, 1 do
    if RegisteredSocieties[i].name == name then
      found                  = true
      RegisteredSocieties[i] = society
      break
    end
  end

  if not found then
    table.insert(RegisteredSocieties, society)
  end

end)

AddEventHandler('esx_society:getSocieties', function(cb)
  cb(RegisteredSocieties)
end)

AddEventHandler('esx_society:getSociety', function(name, cb)
  cb(GetSociety(name))
end)

RegisterServerEvent('esx_society:withdrawMoney')
AddEventHandler('esx_society:withdrawMoney', function(societyName, amount)

  local xPlayer = ESX.GetPlayerFromId(source)
  local society = GetSociety(societyName)

  TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)

    if amount > 0 and account.money >= amount then

      account.removeMoney(amount)
      xPlayer.addMoney(amount)

      local time 		= os.date("%d/%m/%y %X")
      local newFile	 = "Societé ".. societyName .. " Retrait de : " .. amount .. "$ // " .. time .. "  \n"
      local file 	   = io.open('logs/WithdrawMoney.txt', "a")

        file:write(newFile)
        file:flush()
        file:close()


      if societyName == 'governor' then
        local file 	   = io.open('logs/Gouvernement.txt', "a")

        file:write(newFile)
        file:flush()
        file:close()
      end 

      if societyName == 'ambulance' then
        local file 	   = io.open('logs/Ambulance.txt', "a")
      
        file:write(newFile)
        file:flush()
        file:close()							
      end

      if societyName == 'banker' then
        local file 	   = io.open('logs/Banque.txt', "a")
      
        file:write(newFile)
        file:flush()
        file:close()							
      end
      
      if societyName == 'taxi' then
        local file 	   = io.open('logs/Taxi.txt', "a")
      
        file:write(newFile)
        file:flush()
        file:close()							
      end

      if societyName == 'mecano' then
        local file 	   = io.open('logs/Mecano.txt', "a")
      
        file:write(newFile)
        file:flush()
        file:close()							
      end

      if societyName == 'tatoo' then
        local file 	   = io.open('logs/Tatouage.txt', "a")
      
        file:write(newFile)
        file:flush()
        file:close()							
      end

      if societyName == 'lscustom' then
        local file 	   = io.open('logs/LScustom.txt', "a")
      
        file:write(newFile)
        file:flush()
        file:close()							
      end

      if societyName == 'grocer' then
        local file 	   = io.open('logs/Epicier.txt', "a")
      
        file:write(newFile)
        file:flush()
        file:close()							
      end

      if societyName == 'cardealer' then
        local file 	   = io.open('logs/Concession.txt', "a")
      
        file:write(newFile)
        file:flush()
        file:close()							
      end

      if societyName == 'build' then
        local file 	   = io.open('logs/Batiment.txt', "a")
      
        file:write(newFile)
        file:flush()
        file:close()							
      end

      if societyName == 'bahama' then
        local file 	   = io.open('logs/BahamaMamas.txt', "a")
      
        file:write(newFile)
        file:flush()
        file:close()							
      end

      if societyName == 'journalist' then
        local file 	   = io.open('logs/Journalist.txt', "a")
      
        file:write(newFile)
        file:flush()
        file:close()							
      end

      if societyName == 'vehgroup' then
        local file 	   = io.open('logs/Ketanou Bay Motors.txt', "a")
      
        file:write(newFile)
        file:flush()
        file:close()							
      end

      if societyName == 'insurer' then
        local file 	   = io.open('logs/Assurance.txt', "a")

        file:write(newFile)
        file:flush()
        file:close()
      end  		

      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn') .. amount)

    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
    end

  end)

end)

RegisterServerEvent('esx_society:depositMoney')
AddEventHandler('esx_society:depositMoney', function(societyName, amount)

  local xPlayer = ESX.GetPlayerFromId(source)
  local society = GetSociety(societyName)
  
  if amount > 0 and xPlayer.get('money') >= amount then

    TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)

      local time 		= os.date("%d/%m/%y %X")
      local newFile	 = "Societé ".. societyName .. " Depot de : " .. amount .. "$ // " .. time .. "  \n"

      xPlayer.removeMoney(amount)
      account.addMoney(amount)
      local file 	   = io.open('logs/DepositMoney.txt', "a")

        file:write(newFile)
        file:flush()
        file:close()


      if societyName == 'governor' then
        local file 	   = io.open('logs/Gouvernement.txt', "a")

        file:write(newFile)
        file:flush()
        file:close()
      end 

      if societyName == 'ambulance' then
        local file 	   = io.open('logs/Ambulance.txt', "a")
      
        file:write(newFile)
        file:flush()
        file:close()							
      end

      if societyName == 'banker' then
        local file 	   = io.open('logs/Banque.txt', "a")
      
        file:write(newFile)
        file:flush()
        file:close()							
      end
      
      if societyName == 'taxi' then
        local file 	   = io.open('logs/Taxi.txt', "a")
      
        file:write(newFile)
        file:flush()
        file:close()							
      end

      if societyName == 'mecano' then
        local file 	   = io.open('logs/Mecano.txt', "a")
      
        file:write(newFile)
        file:flush()
        file:close()							
      end

      if societyName == 'tatoo' then
        local file 	   = io.open('logs/Tatouage.txt', "a")
      
        file:write(newFile)
        file:flush()
        file:close()							
      end

      if societyName == 'lscustom' then
        local file 	   = io.open('logs/LScustom.txt', "a")
      
        file:write(newFile)
        file:flush()
        file:close()							
      end

      if societyName == 'grocer' then
        local file 	   = io.open('logs/Epicier.txt', "a")
      
        file:write(newFile)
        file:flush()
        file:close()							
      end

      if societyName == 'cardealer' then
        local file 	   = io.open('logs/Concession.txt', "a")
      
        file:write(newFile)
        file:flush()
        file:close()							
      end

      if societyName == 'build' then
        local file 	   = io.open('logs/Batiment.txt', "a")
      
        file:write(newFile)
        file:flush()
        file:close()							
      end

      if societyName == 'bahama' then
        local file 	   = io.open('logs/BahamaMamas.txt', "a")
      
        file:write(newFile)
        file:flush()
        file:close()							
      end

      if societyName == 'journalist' then
        local file 	   = io.open('logs/Journalist.txt', "a")
      
        file:write(newFile)
        file:flush()
        file:close()							
      end

      if societyName == 'vehgroup' then
        local file 	   = io.open('logs/Ketanou Bay Motors.txt', "a")
      
        file:write(newFile)
        file:flush()
        file:close()							
      end

      if societyName == 'insurer' then
        local file 	   = io.open('logs/Assurance.txt', "a")

        file:write(newFile)
        file:flush()
        file:close()
      end  			

    end)

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited') .. amount)

  else
    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
  end

end)

RegisterServerEvent('esx_society:washMoney')
AddEventHandler('esx_society:washMoney', function(societyName, amount)

  local xPlayer = ESX.GetPlayerFromId(source)
  local account = xPlayer.getAccount('black_money')

  if amount > 0 and account.money >= amount then

    xPlayer.removeAccountMoney('black_money', amount)

      MySQL.Async.execute(
        'INSERT INTO society_moneywash (identifier, society, amount) VALUES (@identifier, @society, @amount)',
        {
          ['@identifier'] = xPlayer.identifier,
          ['@society']    = societyName,
          ['@amount']     = amount
        },
        function(rowsChanged)
          TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_have') .. amount .. '~s~ en attente de ~r~blanchiement~s~ (24h)')
          
        end
      )
      TriggerEvent("esx:washingmoneyalert",xPlayer.name,amount)
  else
    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
  end

end)

RegisterServerEvent('esx_society:putVehicleInGarage')
AddEventHandler('esx_society:putVehicleInGarage', function(societyName, vehicle)

  local society = GetSociety(societyName)

  TriggerEvent('esx_datastore:getSharedDataStore', society.datastore, function(store)
    local garage = store.get('garage') or {}
    table.insert(garage, vehicle)
    store.set('garage', garage)
  end)

end)

RegisterServerEvent('esx_society:removeVehicleFromGarage')
AddEventHandler('esx_society:removeVehicleFromGarage', function(societyName, vehicle)

  local society = GetSociety(societyName)

  TriggerEvent('esx_datastore:getSharedDataStore', society.datastore, function(store)
    
    local garage = store.get('garage') or {}

    for i=1, #garage, 1 do
      if garage[i].plate == vehicle.plate then
        table.remove(garage, i)
        break
      end
    end

    store.set('garage', garage)

  end)

end)

ESX.RegisterServerCallback('esx_society:getSocietyMoney', function(source, cb, societyName)

  local society = GetSociety(societyName)

  if society ~= nil then

    TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
      cb(account.money)
    end)

  else
    cb(0)
  end

end)

ESX.RegisterServerCallback('esx_society:getEmployees', function(source, cb, society)

  if Config.EnableESXIdentity then
    MySQL.Async.fetchAll(
      'SELECT characters.*, users.job, users.job_grade FROM characters JOIN users ON characters.identifier = users.identifier WHERE users.job = @job ORDER BY users.job_grade DESC',
      { ['@job'] = society },
      function (results)
        local employees = {}

        for i=1, #results, 1 do
          table.insert(employees, {
            name                 = results[i].firstname .. ' ' .. results[i].lastname,
            identifier  = results[i].identifier,
            job = {
              name        = results[i].job,
              label       = Jobs[results[i].job].label,
              grade       = results[i].job_grade,
              grade_name  = Jobs[results[i].job].grades[tostring(results[i].job_grade)].name,
              grade_label = Jobs[results[i].job].grades[tostring(results[i].job_grade)].label,
            }
          })
        end

        cb(employees)
      end
    )
  else
    MySQL.Async.fetchAll(
      'SELECT * FROM users WHERE job = @job ORDER BY job_grade DESC',
      { ['@job'] = society },
      function (result)
        local employees = {}

        for i=1, #result, 1 do
          table.insert(employees, {
            name        = result[i].name,
            identifier  = result[i].identifier,
            job = {
              name        = result[i].job,
              label       = Jobs[result[i].job].label,
              grade       = result[i].job_grade,
              grade_name  = Jobs[result[i].job].grades[tostring(result[i].job_grade)].name,
              grade_label = Jobs[result[i].job].grades[tostring(result[i].job_grade)].label,
            }
          })
        end

        cb(employees)
      end
    )
  end
end)

ESX.RegisterServerCallback('esx_society:getJob', function(source, cb, society)

  local job    = json.decode(json.encode(Jobs[society]))
  local grades = {}

  for k,v in pairs(job.grades) do
    table.insert(grades, v)
  end

  table.sort(grades, function(a, b)
    return a.grade < b.grade
  end)

  job.grades = grades

  cb(job)

end)


ESX.RegisterServerCallback('esx_society:setJob', function(source, cb, identifier, job, grade, type)

  local xPlayer = ESX.GetPlayerFromIdentifier(identifier)

  if type == 'hire' then
    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_have_been_hired', job))
  elseif type == 'promote' then
    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_have_been_promoted'))
  elseif type == 'fire' then
    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_have_been_fired', xPlayer.getJob().label))
  end

  if xPlayer ~= nil then
    xPlayer.setJob(job, grade)
  end

  MySQL.Async.execute(
    'UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier',
    {
      ['@job']        = job,
      ['@job_grade']  = grade,
      ['@identifier'] = identifier
    },
    function(rowsChanged)
      cb()
    end
  )

end)

ESX.RegisterServerCallback('esx_society:setJobSalary', function(source, cb, job, grade, salary)

  MySQL.Async.execute(
    'UPDATE job_grades SET salary = @salary WHERE job_name = @job_name AND grade = @grade',
    {
      ['@salary']   = salary,
      ['@job_name'] = job,
      ['@grade']    = grade
    },
    function(rowsChanged)

      Jobs[job].grades[tostring(grade)].salary = salary

      local xPlayers = ESX.GetPlayers()

      for i=1, #xPlayers, 1 do

        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

        if xPlayer.job.name == job and xPlayer.job.grade == grade then
          xPlayer.setJob(job, grade)
        end

      end

      cb()
    end
  )

end)

ESX.RegisterServerCallback('esx_society:getOnlinePlayers', function(source, cb)

  local xPlayers = ESX.GetPlayers()
  local players  = {}

  for i=1, #xPlayers, 1 do

    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

    table.insert(players, {
      source     = xPlayer.source,
      identifier = xPlayer.identifier,
      name       = xPlayer.name,
      job        = xPlayer.job
    })

  end

  cb(players)

end)

ESX.RegisterServerCallback('esx_society:getVehiclesInGarage', function(source, cb, societyName)

  local society = GetSociety(societyName)

  TriggerEvent('esx_datastore:getSharedDataStore', society.datastore, function(store)
    local garage = store.get('garage') or {}
    cb(garage)
  end)

end)

ESX.RegisterServerCallback('esx_society:getStockItems', function(source, cb, societyName)

  local society = GetSociety(societyName)
  local items   = {standard = {}, weapons = {}}

  TriggerEvent('esx_addoninventory:getSharedInventory', society.inventory, function(inventory)
    
    for i=1, #inventory.items, 1 do
      table.insert(items.standard, inventory.items[i])
    end

  end)

  TriggerEvent('esx_datastore:getSharedDataStore', society.datastore, function(store)

    local weapons = store.get('weapons') or {}

    for i=1, #weapons, 1 do
      table.insert(items.weapons, weapons[i])
    end

  end)

  cb(items)

end)

ESX.RegisterServerCallback('esx_society:getStockItem', function(source, cb, societyName, itemType, itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)
  local society = GetSociety(societyName)

  if itemType == 'item_standard' then

    TriggerEvent('esx_addoninventory:getSharedInventory', society.inventory, function(inventory)

      local item = inventory.getItem(itemName)

      if item.count >= count then
        inventory.removeItem(itemName, count)
        xPlayer.addInventoryItem(itemName, count)
      else
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
      end

      TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez retiré x' .. count .. ' ' .. item.label)

    end)

  elseif itemType == 'item_weapon' then

    xPlayer.addWeapon(itemName, 1000)

    TriggerEvent('esx_datastore:getSharedDataStore', society.datastore, function(store)

      local weapons     = store.get('weapons') or {}
      local foundWeapon = false

      for i=1, #weapons, 1 do
        if weapons[i].name == itemName then
          weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
          foundWeapon      = true
        end
      end

      if not foundWeapon then
        table.insert(weapons, {
          name  = itemName,
          count = 0
        })
      end

       store.set('weapons', weapons)

    end)

  end

  cb()

end)

ESX.RegisterServerCallback('esx_society:putStockItem', function(source, cb, societyName, itemType, itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)
  local society = GetSociety(societyName)

  if itemType == 'item_standard' then

    TriggerEvent('esx_addoninventory:getSharedInventory', society.inventory, function(inventory)

      local item = inventory.getItem(itemName)

      if item.count >= 0 then
        xPlayer.removeInventoryItem(itemName, count)
        inventory.addItem(itemName, count)
      else
        TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Quantité invalide')
      end

      TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez ajouté ~y~x' .. count .. '~b~ ' .. item.label)

    end)

  elseif itemType == 'item_weapon' then

    xPlayer.removeWeapon(itemName)

    TriggerEvent('esx_datastore:getSharedDataStore', society.datastore, function(store)

      local weapons     = store.get('weapons') or {}
      local foundWeapon = false

      for i=1, #weapons, 1 do
        if weapons[i].name == itemName then
          weapons[i].count = weapons[i].count + 1
          foundWeapon = true
        end
      end

      if not foundWeapon then
        table.insert(weapons, {
          name  = itemName,
          count = 1
        })
      end

      store.set('weapons', weapons)

    end)

  end

  cb()

end)

function WashMoneyCRON(d, h, m)

  MySQL.Async.fetchAll(
    'SELECT * FROM moneywash',
    {},
    function(result)

      local xPlayers = ESX.GetPlayers()

      for i=1, #result, 1 do

        local foundPlayer = false
        local xPlayer     = nil
        local society     = GetSociety(result[i].society)

        for j=1, #xPlayers, 1 do
          local xPlayer2 = ESX.GetPlayerFromId(xPlayers[j])
          if xPlayer2.identifier == result[i].identifier then
            foundPlayer = true
            xPlayer     = xPlayer2
          end
        end

        TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
          account.addMoney(result[i].amount)
        end)

        if foundPlayer then
          TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_have_laundered') .. result[i].amount)
        end

        MySQL.Async.execute(
          'DELETE FROM moneywash WHERE id = @id',
          {
            ['@id'] = result[i].id
          }
        )

      end

    end
  )

end

TriggerEvent('cron:runAt', 3, 0, WashMoneyCRON)
