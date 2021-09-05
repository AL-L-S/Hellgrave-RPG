local creatureevent = CreatureEvent("recompense")

function creatureevent.onAdvance(player, skill, oldLevel, newLevel)
    if player:getLevel() >= 10 and player:getStorageValue(99970) ~= 1 then
        player:addItem(2152, 5)
        player:setStorageValue(99970, 1)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have been rewarded 5 Platinium Coins for reach level 10.")

    elseif player:getLevel() >= 20 and player:getStorageValue(99971) ~= 1 then
        player:addItem(2152, 10)
        player:setStorageValue(99971, 1)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have been rewarded 10 Platinium Coins for reach level 20.")

    elseif player:getLevel() >= 30 and player:getStorageValue(99972) ~= 1 then
        player:addItem(2152, 15)
        player:setStorageValue(99972, 1)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have been rewarded  15 Platinium Coins for reach level 30.")

    elseif player:getLevel() >= 40 and player:getStorageValue(99973) ~= 1 then
        player:addItem(2152, 20)
        player:setStorageValue(99973, 1)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have been rewarded 20 Platinium Coins for reach level 40.")

    elseif player:getLevel() >= 50 and player:getStorageValue(99974) ~= 1 then
        player:addItem(5908, 1)
        player:setStorageValue(99974, 1)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have reach level 50, you received an Obsidian Knife, on next level (51) you receive a tibia coins reward.")

    elseif player:getLevel() >= 51 and player:getStorageValue(99975) ~= 1 then
        player:addItem(24774, 25)
        player:setStorageValue(99975, 1)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have been rewarded 25 Tibia Coins for reach level 51.")

    elseif player:getLevel() >= 60 and player:getStorageValue(99976) ~= 1 then
        player:addItem(2152, 20)
        player:setStorageValue(99976, 1)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have been rewarded 20 Platinium Coins for reach level 60.")

    elseif player:getLevel() >= 70 and player:getStorageValue(99977) ~= 1 then
        player:addItem(2152, 30)
        player:setStorageValue(99977, 1)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have been rewarded 30 Platinium Coins for advancing to Level 70.")

    elseif player:getLevel() >= 80 and player:getStorageValue(99978) ~= 1 then
        player:addItem(2152, 50)
        player:setStorageValue(99978, 1)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have been rewarded 50 Platinium Coins for advancing to Level 80.")

    elseif player:getLevel() >= 90 and player:getStorageValue(99979) ~= 1 then
        player:addItem(5942, 1)
        player:setStorageValue(99979, 1)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have reach Level 90, you have been rewarded an Blessed Wooden Stake.")

    elseif player:getLevel() >= 100 and player:getStorageValue(99980) ~= 1 then
        player:addItem(24774, 25)
        player:setStorageValue(99980, 1)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have been rewarded 25 Tibia Coins for reach level 100.")

    elseif player:getLevel() >= 120 and player:getStorageValue(99981) ~= 1 then
        player:addItem(24774, 25)
        player:setStorageValue(99981, 1)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have been rewarded 25 Tibia Coins for reach level 120.")

    elseif player:getLevel() >= 150 and player:getStorageValue(99982) ~= 1 then
        player:addItem(24774, 25)
        player:setStorageValue(99982, 1)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have been rewarded 25 Tibia Coins for reach level 150, this was the last reward.")
        end
    return true
end

creatureevent:register()