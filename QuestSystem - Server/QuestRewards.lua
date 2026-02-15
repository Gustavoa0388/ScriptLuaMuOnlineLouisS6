-- ScriptServer/QuestSystem/QuestRewards.lua

local QuestRewards = {}

function QuestRewards.GiveRewards(aIndex, quest)
    if quest.rewards.exp and quest.rewards.exp > 0 then
        ObjectAddExperience(aIndex, quest.rewards.exp, 0)
    end
    
    if quest.rewards.money and quest.rewards.money > 0 then
        ObjectAddCoin(aIndex, quest.rewards.money, 0, 0)
    end
    
    if quest.rewards.items then
        for _, item_reward in ipairs(quest.rewards.items) do
            ItemGiveEx(aIndex, 
                item_reward.index,
                item_reward.level or 0,
                255,
                0, 0, 0,
                0, 0, 0,
                0,
                0, 0, 0, 0, 0
            )
        end
    end
    
    Console(1, string.format("[QuestReward] Player %s received rewards from quest", 
        GetObjectName(aIndex)))
end

return QuestRewards