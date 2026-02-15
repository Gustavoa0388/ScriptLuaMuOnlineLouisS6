-- Scripts\QuestWindow\Config.lua
return {
    WindowID = 160,
    TabAtiva = "Monthly", -- Aba padrão ao abrir
    MESSAGES = {
        [1] = { ["Por"] = "DIÁRIO DE MISSÕES", ["Eng"] = "QUEST LOG" },
        [2] = { ["Por"] = "RECOMPENSAS:", ["Eng"] = "REWARDS:" },
    },
    -- Definição das Abas Laterais
    Tabs = {
        { id = "Daily",   label = "Diárias",  y = 70 },
        { id = "Weekly",  label = "Semanais", y = 95 },
        { id = "Monthly", label = "História", y = 120 },
    },
    ButtonID = { fechar = 1, acao = 2 },
    Button = {},
}