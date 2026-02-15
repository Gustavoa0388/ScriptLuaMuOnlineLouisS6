-- ScriptServer/QuestSystem/QuestProtocol.lua

local QuestConfig = require("Scripts\\QuestSystem\\QuestConfig")
local QuestData = require("Scripts\\QuestSystem\\QuestData")
local QuestManager = require("Scripts\\QuestSystem\\QuestManager")

local QuestProtocol = {}

BridgeFunctionAttach('GameServerProtocol', 'QuestProtocol_Handler')
BridgeFunctionAttach('OnCharacterEntry', 'QuestProtocol_OnCharacterEntry')
BridgeFunctionAttach('OnCharacterClose', 'QuestProtocol_OnCharacterClose')

-- ============================================
-- QUANDO PLAYER CONECTA
-- ============================================
function QuestProtocol_OnCharacterEntry(aIndex)
    Console(1, string.format("[Quest] Player %s connected", GetObjectName(aIndex)))
    
    -- Inicializar dados do player
    QuestData.InitPlayerData(aIndex)
    
    -- Dar primeira quest automaticamente
    local first_quest = QuestData.GetQuestById(1001)
    if first_quest then
        QuestData.SetPlayerQuestData(aIndex, 1001, {
            state = 0,  -- INACTIVE
            progress = 0,
            max_progress = first_quest.target_count or 0,
            started_at = os.time(),
        })
        Console(2, string.format("[Quest] First quest initialized for %s", GetObjectName(aIndex)))
    end
    
    -- Enviar lista de quests para o cliente
    QuestManager.SendQuestList(aIndex)
end

-- ============================================
-- QUANDO PLAYER DESCONECTA
-- ============================================
function QuestProtocol_OnCharacterClose(aIndex)
    Console(1, string.format("[Quest] Player %s disconnected", GetObjectName(aIndex)))
    QuestData.PlayerData[aIndex] = nil
end

-- ============================================
-- RECEBER PACOTES DO CLIENTE
-- ============================================
function QuestProtocol_Handler(aIndex, head, packet_name)
    Console(2, string.format("[Quest Protocol] Head: 0x%X from %s", head, GetObjectName(aIndex)))
    
    -- 0xEB = ACEITAR QUEST
    if head == 0xEB then
        local quest_id = GetWordPacket(packet_name, 1)
        Console(1, string.format("[Quest] %s attempting to accept quest %d", 
            GetObjectName(aIndex), quest_id))
        QuestManager.AcceptQuest(aIndex, quest_id)
        ClearPacket(packet_name)
        return
    end
    
    -- 0xEC = ABANDONAR QUEST
    if head == 0xEC then
        local quest_id = GetWordPacket(packet_name, 1)
        Console(1, string.format("[Quest] %s abandoned quest %d", 
            GetObjectName(aIndex), quest_id))
        QuestManager.AbandonQuest(aIndex, quest_id)
        ClearPacket(packet_name)
        return
    end
    
    -- 0xED = ENTREGAR QUEST
    if head == 0xED then
        local quest_id = GetWordPacket(packet_name, 1)
        Console(1, string.format("[Quest] %s delivered quest %d", 
            GetObjectName(aIndex), quest_id))
        QuestManager.DeliverQuest(aIndex, quest_id)
        ClearPacket(packet_name)
        return
    end
end

return QuestProtocol