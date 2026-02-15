-- Data\Script\Scripts\MainQuest.lua
local status, QuestCore = pcall(require, 'System\\QuestCore')

function QuestCommand(aIndex, Arguments)
    local Command = CommandGetArgString(Arguments, 0)
    local charName = GetObjectName(aIndex)

    if Command == "/quests" or Command == "/queststatus" then
        if status and QuestCore then QuestCore.ChatStatus(aIndex) end
        return 1
    end

    if charName == "Admin" then
        if Command == "/questreset" then
            DataBase.Query(string.format("DELETE FROM Lua_Quest_Data WHERE CharName = '%s'", charName))
            MessageSend(aIndex, 0, 0, "[ADMIN] Reset concluido.")
            return 1
        end
        if Command == "/questadd" then
            local qID = tonumber(CommandGetArgString(Arguments, 1))
            local info = QuestData.GetById(qID)
            if info then
                DataBase.Query(string.format("INSERT INTO Lua_Quest_Data (CharName, QuestID, Progress, Target, Status, QuestType) VALUES ('%s', %d, 0, %d, 1, %d)", charName, qID, info.alvo, info.tipo))
                MessageSend(aIndex, 0, 0, string.format("[ADMIN] Quest %d adicionada.", qID))
            end
            return 1
        end
    end
    return 0
end

function OnMonsterDieQuest(MonsterIndex, PlayerIndex)
    if status and QuestCore then QuestCore.OnMonsterKill(PlayerIndex, MonsterIndex) end
end

function QuestNpcTalk(NpcIndex, PlayerIndex)
    if status and QuestCore then QuestCore.OnNpcTalk(NpcIndex, PlayerIndex) end
    return 0 
end

BridgeFunctionAttach('OnCommandManager', 'QuestCommand')
BridgeFunctionAttach('OnMonsterDie', 'OnMonsterDieQuest')
BridgeFunctionAttach('OnNpcTalk', 'QuestNpcTalk')