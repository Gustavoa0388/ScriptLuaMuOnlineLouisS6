-- ScriptServer/QuestSystem/QuestConfig.lua

return {
    -- Configurações Gerais
    EnableQuestSystem = true,
    MaxActiveQuests = 5,
    QuestTimeout = 86400,
    
    -- Mensagens do Servidor
    MESSAGES = {
        [1] = "Quest aceita com sucesso!",
        [2] = "Quest abandonada.",
        [3] = "Quest completa! Procure o NPC para entregar.",
        [4] = "Recompensas recebidas!",
        [5] = "Você não atende aos requisitos para esta quest.",
    },
    
    -- Protocolos (Heads)
    Protocol = {
        UPDATE = 0x15,
        LIST = 0x16,
        REWARD = 0x17,
    },
}