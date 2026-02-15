-- Data\Script\System\QuestCore.lua
local QuestCore = {}
local DataBase  = require('Utils\\DataBase')
local QuestData = require('Scripts\\QuestData')

function QuestCore.UpdateProgress(aIndex, subTipo, valorAlvo, quantidade)
    local charName = GetObjectName(aIndex)
    quantidade = quantidade or 1
    
    local query = string.format("SELECT QuestID, Progress, Target FROM Lua_Quest_Data WHERE CharName = '%s' AND Status = 1", charName)
    local ret = SQLQuery(query)
    if ret == 0 then SQLClose() return end

    local atualizacoes = {}
    while SQLFetch() ~= 100 do
        local qID = SQLGetNumber("QuestID")
        local progNoBanco = SQLGetNumber("Progress")
        local info = QuestData.GetById(qID)
        
        if info and info.subTipo == subTipo then
            local check = false
            if subTipo == "CACA" and tonumber(info.mobID) == tonumber(valorAlvo) then check = true
            elseif subTipo == "NPC" and tonumber(info.npcID) == tonumber(valorAlvo) then check = true
            elseif subTipo == "COLETA" and tonumber(info.itemID) == tonumber(valorAlvo) then check = true end
            
            if check then
                table.insert(atualizacoes, {id = qID, prog = progNoBanco, alvo = info.alvo, titulo = info.titulo})
            end
        end
    end
    SQLClose()

    for _, q in ipairs(atualizacoes) do
        local novoProg = q.prog + quantidade
        if novoProg >= q.alvo then
            novoProg = q.alvo
            QuestCore.GiveReward(aIndex, QuestData.GetById(q.id))
            DataBase.Query(string.format("UPDATE Lua_Quest_Data SET Status = 3, Progress = %d WHERE CharName = '%s' AND QuestID = %d", novoProg, charName, q.id))
        else
            DataBase.Query(string.format("UPDATE Lua_Quest_Data SET Progress = %d WHERE CharName = '%s' AND QuestID = %d", novoProg, charName, q.id))
            -- ENVIO DE PROGRESSO EM TEMPO REAL NO CHAT
            MessageSend(aIndex, 0, 0, string.format("[Quest] %s: %d/%d", q.titulo, novoProg, q.alvo))
        end
    end
end

function QuestCore.OnMonsterKill(PlayerIndex, MonsterIndex)
    local mobID = GetObjectClass(MonsterIndex)
    LogColor(1, string.format("[QuestDebug] Kill: Player %d matou Mob %d", PlayerIndex, mobID))
    if mobID > 0 then
        QuestCore.UpdateProgress(PlayerIndex, "CACA", mobID, 1)
    end
end

function QuestCore.OnNpcTalk(npcIndex, aIndex)
    local npcClass = GetObjectClass(npcIndex)
    if npcClass == 249 then
        MessageSend(aIndex, 0, 0, "Sou o Capitao. Relate seu progresso para receber recompensas.")
        QuestCore.CheckDeliveries(aIndex)
    end
    QuestCore.UpdateProgress(aIndex, "NPC", npcClass, 1)
end

function QuestCore.CheckDeliveries(aIndex)
    local charName = GetObjectName(aIndex)
    local query = string.format("SELECT QuestID FROM Lua_Quest_Data WHERE CharName = '%s' AND Progress >= Target AND Status = 1", charName)
    if SQLQuery(query) ~= 0 then
        while SQLFetch() ~= 100 do
            local qID = SQLGetNumber("QuestID")
            QuestCore.GiveReward(aIndex, QuestData.GetById(qID))
            DataBase.Query(string.format("UPDATE Lua_Quest_Data SET Status = 3 WHERE CharName = '%s' AND QuestID = %d", charName, qID))
        end
    end
    SQLClose()
end

function QuestCore.GiveReward(aIndex, q)
    if not q then return end
    if q.premioZen then 
        SetObjectMoney(aIndex, GetObjectMoney(aIndex) + q.premioZen) 
        MoneySend(aIndex) 
    end
    -- AVISO DE CONCLUSÃO NA TELA
    NoticeSend(aIndex, 1, string.format("Quest [%s] Concluida!", q.titulo))
end

function QuestCore.ChatStatus(aIndex)
    local charName = GetObjectName(aIndex)
    MessageSend(aIndex, 0, 0, "--- [ MISSOES ATIVAS ] ---")
    local query = string.format("SELECT QuestID, Progress, Target FROM Lua_Quest_Data WHERE CharName = '%s' AND Status = 1", charName)
    local ret = SQLQuery(query)
    if ret == 0 then SQLClose() MessageSend(aIndex, 0, 0, "Nenhuma ativa.") return end
    while SQLFetch() ~= 100 do
        local qID = SQLGetNumber("QuestID")
        local prog = SQLGetNumber("Progress")
        local alvo = SQLGetNumber("Target")
        local info = QuestData.GetById(qID)
        if info then
            MessageSend(aIndex, 0, 0, string.format("- %s: [%d/%d]", info.titulo, prog, alvo))
        end
    end
    SQLClose()
end

return QuestCore