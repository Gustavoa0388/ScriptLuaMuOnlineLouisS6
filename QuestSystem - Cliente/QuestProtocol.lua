-- ScriptClient/Script/Scripts/QuestSystem/QuestProtocol.lua

local QuestData = require("Scripts\\QuestSystem\\QuestData")

local QuestProtocol = {}

-- ============================================
-- ENVIAR QUEST - ACEITAR
-- ============================================
function QuestProtocol.SendAcceptQuest(quest_id)
    local packet = "QuestAccept"
    CreatePacket(packet, 5)
    SetBytePacket(packet, 0, 0xEB)
    SetWordPacket(packet, 1, quest_id)
    SendPacket(packet)
    ClearPacket(packet)
    Console(1, string.format("[Quest Client] Sending ACCEPT for quest %d", quest_id))
end

-- ============================================
-- ENVIAR QUEST - ABANDONAR
-- ============================================
function QuestProtocol.SendAbandonQuest(quest_id)
    local packet = "QuestAbandon"
    CreatePacket(packet, 5)
    SetBytePacket(packet, 0, 0xEC)
    SetWordPacket(packet, 1, quest_id)
    SendPacket(packet)
    ClearPacket(packet)
    Console(1, string.format("[Quest Client] Sending ABANDON for quest %d", quest_id))
end

-- ============================================
-- ENVIAR QUEST - ENTREGAR
-- ============================================
function QuestProtocol.SendDeliverQuest(quest_id)
    local packet = "QuestDeliver"
    CreatePacket(packet, 5)
    SetBytePacket(packet, 0, 0xED)
    SetWordPacket(packet, 1, quest_id)
    SendPacket(packet)
    ClearPacket(packet)
    Console(1, string.format("[Quest Client] Sending DELIVER for quest %d", quest_id))
end

-- ============================================
-- RECEBER UPDATE DE QUEST DO SERVIDOR
-- ============================================
function QuestProtocol.RecvQuestUpdate(packet_name)
    local head = GetBytePacket(packet_name, 0)
    
    -- 0x15 = Update de quest individual
    if head == 0x15 then
        local quest_id = GetWordPacket(packet_name, 1)
        local state = GetBytePacket(packet_name, 3)
        local progress = GetWordPacket(packet_name, 4)
        local max_progress = GetWordPacket(packet_name, 6)
        
        QuestData.PlayerQuests[quest_id] = {
            state = state,
            progress = progress,
            max_progress = max_progress,
        }
        
        Console(2, string.format("[Quest Client] UPDATE quest %d: state=%d, progress=%d/%d", 
            quest_id, state, progress, max_progress))
        
        return true
    end
    
    -- 0x16 = Lista completa de quests
    if head == 0x16 then
        local count = GetBytePacket(packet_name, 1)
        local offset = 2
        
        QuestData.PlayerQuests = {}
        
        Console(1, string.format("[Quest Client] Receiving QUEST LIST with %d items", count))
        
        for i = 1, count do
            local quest_id = GetWordPacket(packet_name, offset)
            local state = GetBytePacket(packet_name, offset + 2)
            local progress = GetWordPacket(packet_name, offset + 3)
            local max_progress = GetWordPacket(packet_name, offset + 5)
            
            QuestData.PlayerQuests[quest_id] = {
                state = state,
                progress = progress,
                max_progress = max_progress,
            }
            
            Console(2, string.format("[Quest] Quest %d loaded - state: %d", quest_id, state))
            
            offset = offset + 7
        end
        
        Console(1, string.format("[Quest Client] Loaded %d quests", count))
        return true
    end
    
    -- 0x17 = Recompensa recebida
    if head == 0x17 then
        local quest_id = GetWordPacket(packet_name, 1)
        local exp = GetDwordPacket(packet_name, 3)
        local money = GetDwordPacket(packet_name, 7)
        
        Console(3, string.format("[Quest Reward] Quest %d: EXP=%d, Money=%d", 
            quest_id, exp, money))
        
        return true
    end
    
    return false
end

-- ============================================
-- REGISTRAR HANDLER DE PROTOCOLO
-- ============================================
BridgeFunctionAttach('ClientProtocol', 'QuestProtocolHandler')

function QuestProtocolHandler(packet, packet_name)
    if QuestProtocol.RecvQuestUpdate(packet_name) then
        ClearPacket(packet_name)
    end
end

return QuestProtocol