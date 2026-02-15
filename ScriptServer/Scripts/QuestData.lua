-- Data\Script\Scripts\QuestData.lua
QuestData = {}
QuestData.Pool = {}

local function ImportQuests(fileName)
    local status, data = pcall(require, 'Scripts\\Quests\\' .. fileName)
    if status and type(data) == "table" then
        local count = 0
        for _, quest in ipairs(data) do 
            table.insert(QuestData.Pool, quest)
            count = count + 1
        end
        LogColor(2, string.format("[QuestData] %s carregado: %d missoes!", fileName, count))
    else
        LogColor(1, string.format("[QuestData] ERRO em %s: %s", fileName, tostring(data)))
    end
end

-- Importa as listas
ImportQuests("Daily")
ImportQuests("Weekly")
ImportQuests("Monthly")

function QuestData.GetById(id)
    for _, q in ipairs(QuestData.Pool) do 
        if tonumber(q.id) == tonumber(id) then return q end 
    end
    return nil
end

return QuestData