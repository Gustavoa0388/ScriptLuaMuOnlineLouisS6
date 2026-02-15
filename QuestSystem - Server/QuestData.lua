-- ScriptServer/QuestSystem/QuestData.lua

local QuestConfig = require("QuestSystem\\QuestConfig")

local QuestData = {}
QuestData.Quests = {}
QuestData.PlayerData = {}

-- ============================================
-- QUESTS DO BANCO DE DADOS
-- ============================================

QuestData.Quests[1001] = {
    id = 1001,
    title = "O Vilarejo Sob Ameaça",
    chapter = 1,
    arc = "O Despertar",
    level_required = 1,
    npc_id = 1,
    objective_type = "hunt",
    target_mob = 3,
    target_count = 10,
    rewards = {
        exp = 1000,
        money = 5000,
    },
    next_quest_id = 1002,
    repeatable = false,
}

QuestData.Quests[1002] = {
    id = 1002,
    title = "Os Segredos das Sombras",
    chapter = 2,
    arc = "O Despertar",
    level_required = 10,
    npc_id = 1,
    objective_type = "collect",
    target_item = 6159,
    target_count = 5,
    rewards = {
        exp = 2000,
        money = 10000,
    },
    next_quest_id = 1003,
    repeatable = false,
}

QuestData.Quests[1003] = {
    id = 1003,
    title = "O Mago das Ruínas",
    chapter = 3,
    arc = "O Despertar",
    level_required = 20,
    npc_id = 2,
    objective_type = "talk",
    target_npc = 2,
    rewards = {
        exp = 5000,
        money = 20000,
    },
    next_quest_id = nil,
    repeatable = false,
}

QuestData.Quests[2001] = {
    id = 2001,
    title = "O Cristal Corrompido",
    chapter = 4,
    arc = "A Ascensão da Corrupção",
    level_required = 30,
    npc_id = 2,
    objective_type = "collect",
    target_item = 6160,
    target_count = 10,
    rewards = {
        exp = 8000,
        money = 30000,
    },
    next_quest_id = 2002,
    repeatable = false,
}

QuestData.Quests[2002] = {
    id = 2002,
    title = "Purificação do Cristal",
    chapter = 5,
    arc = "A Ascensão da Corrupção",
    level_required = 40,
    npc_id = 3,
    objective_type = "hunt",
    target_mob = 50,
    target_count = 1,
    rewards = {
        exp = 15000,
        money = 50000,
    },
    next_quest_id = nil,
    repeatable = false,
}

-- ============================================
-- GERENCIAR DADOS DO PLAYER
-- ============================================

function QuestData.InitPlayerData(aIndex)
    QuestData.PlayerData[aIndex] = {
        quests = {}
    }
end

function QuestData.GetPlayerQuestData(aIndex, quest_id)
    if not QuestData.PlayerData[aIndex] then
        QuestData.InitPlayerData(aIndex)
    end
    return QuestData.PlayerData[aIndex].quests[quest_id]
end

function QuestData.SetPlayerQuestData(aIndex, quest_id, data)
    if not QuestData.PlayerData[aIndex] then
        QuestData.InitPlayerData(aIndex)
    end
    QuestData.PlayerData[aIndex].quests[quest_id] = data
end

function QuestData.GetQuestById(quest_id)
    return QuestData.Quests[quest_id]
end

return QuestData