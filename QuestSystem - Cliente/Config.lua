-- ScriptClient/Script/Scripts/QuestSystem/Config.lua

return {
    WindowID = 200,
    
    -- Posição da janela (flutuante)
    WindowPos = {
        x = 300,  -- Posição inicial X
        y = 100   -- Posição inicial Y
    },
    
    WindowSize = {
        width = 300,
        height = 350
    },
    
    QuestStates = {
        INACTIVE = 0,
        ACTIVE = 1,
        COMPLETED = 2,
        DELIVERED = 3,
        FAILED = 4,
        ABANDONED = 5,
    },
    
    MESSAGES = {
        [1] = { ["Por"] = "DIARIO DE QUESTS", ["Eng"] = "QUEST LOG", ["Spn"] = "REGISTRO DE MISIONES" },
        [2] = { ["Por"] = "ACEITAR", ["Eng"] = "ACCEPT", ["Spn"] = "ACEPTAR" },
        [5] = { ["Por"] = "ENTREGAR", ["Eng"] = "DELIVER", ["Spn"] = "ENTREGAR" },
    },
    
    ButtonID = {
        close = 1,
        accept = 2,
        back = 6,
    },
    
    Button = {},
    
    -- Variáveis de arrasto
    Dragging = false,
    DragOffsetX = 0,
    DragOffsetY = 0,
    
    Colors = {
        Gold = {255, 215, 0, 255},
        White = {255, 255, 255, 255},
        Gray = {150, 150, 150, 255},
        Green = {0, 255, 100, 255},
        Red = {255, 100, 100, 255},
        DarkGray = {200, 200, 200, 255},
    },
}