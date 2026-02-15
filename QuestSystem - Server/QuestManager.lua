-- ScriptServer/QuestSystem/QuestManager.lua

local QuestConfig = require("Scripts\\QuestSystem\\QuestConfig")
local QuestData = require("Scripts\\QuestSystem\\QuestData")
local QuestRewards = require("Scripts\\QuestSystem\\QuestRewards")

local QuestManager = {}

local QUEST_INACTIVE = 0
local QUEST_ACTIVE = 1
local QUEST_COMPLETED = 2
local QUEST_DELIVERED = 3

-- ============================================
-- ACEITAR QUEST
-- ============================================
function QuestManager.AcceptQuest(aIndex, quest_id)
    local player_level = GetObjectLevel(aIndex)
    local quest = QuestData.GetQuestById(quest_id)
    
    if not quest then
        Console(3, string.format("[Quest] Quest %d NOT FOUND", quest_id))
        MessageSend(aIndex, 1, 0, "Quest nao encontrada!")
        return false
    end
    
    if player_level < quest.level_required then
        MessageSend(aIndex, 1, 0, QuestConfig.MESSAGES[5])
        return false
    end
    
    QuestData.SetPlayerQuestData(aIndex, quest_id, {
        state = QUEST_ACTIVE,
        progress = 0,
        max_progress = quest.target_count,
        started_at = os.time(),
    })
    
    MessageSend(aIndex, 1, 0, QuestConfig.MESSAGES[1])
    QuestManager.SendQuestUpdate(aIndex, quest_id)
    
    Console(2, string.format("[Quest] %s ACCEPTED quest %d", GetObjectName(aIndex), quest_id))
    return true
end

-- ============================================
-- ATUALIZAR PROGRESSO
-- ============================================
function QuestManager.UpdateProgress(aIndex, quest_id, amount)
    local quest_data = QuestData.GetPlayerQuestData(aIndex, quest_id)
    if not quest_data or quest_data.state ~= QUEST_ACTIVE then 
        return false 
    end
    
    quest_data.progress = quest_data.progress + amount
    
    if quest_data.progress >= quest_data.max_progress then
        quest_data.progress = quest_data.max_progress
        quest_data.state = QUEST_COMPLETED
        MessageSend(aIndex, 1, 0, QuestConfig.MESSAGES[3])
    end
    
    QuestManager.SendQuestUpdate(aIndex, quest_id)
    return false
end

-- ============================================
-- ENTREGAR QUEST
-- ============================================
function QuestManager.DeliverQuest(aIndex, quest_id)
    local quest_data = QuestData.GetPlayerQuestData(aIndex, quest_id)
    if not quest_data or quest_data.state ~= QUEST_COMPLETED then
        return false
    end
    
    local quest = QuestData.GetQuestById(quest_id)
    if not quest then return false end
    
    QuestRewards.GiveRewards(aIndex, quest)
    
    quest_data.state = QUEST_DELIVERED
    
    MessageSend(aIndex, 1, 0, QuestConfig.MESSAGES[4])
    
    if quest.next_quest_id then
        QuestData.SetPlayerQuestData(aIndex, quest.next_quest_id, {
            state = QUEST_INACTIVE,
            progress = 0,
            max_progress = 0,
        })
    end
    
    Console(2, string.format("[Quest] %s COMPLETED quest %d", GetObjectName(aIndex), quest_id))
    return true
end

-- ============================================
-- ABANDONAR QUEST
-- ============================================
function QuestManager.AbandonQuest(aIndex, quest_id)
    local quest_data = QuestData.GetPlayerQuestData(aIndex, quest_id)
    if not quest_data then return false end
    
    quest_data.state = 0  -- INACTIVE
    
    MessageSend(aIndex, 1, 0, QuestConfig.MESSAGES[2])
    Console(2, string.format("[Quest] %s ABANDONED quest %d", GetObjectName(aIndex), quest_id))
    return true
end

-- ============================================
-- ENVIAR UPDATE DE QUEST INDIVIDUAL
-- ============================================
function QuestManager.SendQuestUpdate(aIndex, quest_id)
    local quest_data = QuestData.GetPlayerQuestData(aIndex, quest_id)
    if not quest_data then return end
    
    local packet = "QuestUpdate"
    CreatePacket(packet, 10)
    SetBytePacket(packet, 0, 0x15)
    SetWordPacket(packet, 1, quest_id)
    SetBytePacket(packet, 3, quest_data.state)
    SetWordPacket(packet, 4, quest_data.progress)
    SetWordPacket(packet, 6, quest_data.max_progress)
    SendPacket(packet, aIndex)
    ClearPacket(packet)
    
    Console(2, string.format("[Quest Server] Sending UPDATE for quest %d to %s", quest_id, GetObjectName(aIndex)))
end

-- ============================================
-- ENVIAR LISTA COMPLETA DE QUESTS
-- ============================================
function QuestManager.SendQuestList(aIndex)
    if not QuestData.PlayerData[aIndex] then
        QuestData.InitPlayerData(aIndex)
    end
    
    local packet = "QuestList"
    CreatePacket(packet, 500)
    
    SetBytePacket(packet, 0, 0x16)
    
    local count = 0
    local offset = 1
    
    for quest_id, quest_data in pairs(QuestData.PlayerData[aIndex].quests or {}) do
        if count < 50 then
            SetWordPacket(packet, offset, quest_id)
            SetBytePacket(packet, offset + 2, quest_data.state or 0)
            SetWordPacket(packet, offset + 3, quest_data.progress or 0)
            SetWordPacket(packet, offset + 5, quest_data.max_progress or 0)
            
            offset = offset + 7
            count = count + 1
            
            Console(3, string.format("[Quest] Quest %d - state: %d, progress: %d/%d", 
                quest_id, quest_data.state, quest_data.progress, quest_data.max_progress))
        end
    end
    
    SetBytePacket(packet, 1, count)
    SendPacket(packet, aIndex)
    ClearPacket(packet)
    
    Console(1, string.format("[Quest Server] Sending LIST with %d quests to %s", count, GetObjectName(aIndex)))
end

return QuestManager