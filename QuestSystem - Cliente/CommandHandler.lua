-- ScriptClient/Script/Scripts/QuestSystem/CommandHandler.lua

local QuestManager = require("Scripts\\QuestSystem\\QuestManager")

local CommandHandler = {}

-- ============================================
-- INTERCEPTAR COMANDOS DO CHAT
-- ============================================
BridgeFunctionAttach('KeyboardEvent', 'CommandHandler_ProcessCommand')

-- Variável para armazenar o comando sendo digitado
local CurrentCommand = ""

function CommandHandler_ProcessCommand(key)
    -- Se pressionar ENTER no chat
    if key == Keys.Return and CheckWindowOpen(UIChatWindow) == 1 then
        -- Aqui você pode processar o comando
        -- O comando é enviado automaticamente pelo MU
    end
end

-- ============================================
-- PROCESSAR COMANDO /quests
-- ============================================
-- Esta função será chamada quando o servidor receber o comando
function CommandHandler.ProcessQuestCommand()
    QuestManager.Open()
    Console(1, "[Quest] Comando /quests executado")
end

return CommandHandler