-- ScriptClient/Script/Scripts/QuestSystem/QuestManager.lua

local QuestData = require("Scripts\\QuestSystem\\QuestData")
local QuestProtocol = require("Scripts\\QuestSystem\\QuestProtocol")
local QuestUI = require("Scripts\\QuestSystem\\QuestUI")
local CONFIG = require("Scripts\\QuestSystem\\Config")

local QuestManager = {}

function QuestManager.Open()
    UICustomInterface = 200
    QuestUI.State = "list"
    Console(1, "[Quest] Janela aberta")
end

function QuestManager.Close()
    UICustomInterface = 0
    Console(1, "[Quest] Janela fechada")
end

function QuestManager.IsOpen()
    return UICustomInterface == 200
end

function QuestManager.MainInterface()
    if not QuestManager.IsOpen() then return end
    
    if QuestUI.State == "list" then
        QuestUI.RenderMain()
    elseif QuestUI.State == "details" then
        QuestUI.RenderDetails()
    end
end

function QuestManager.KeyboardEvent(key)
    if CheckWindowOpen(UIChatWindow) == 1 then return false end
    
    if key == Keys.Insert then
        if QuestManager.IsOpen() then
            QuestManager.Close()
        else
            QuestManager.Open()
        end
        return true
    end
    
    if not QuestManager.IsOpen() then return false end
    
    if key == Keys.Escape then
        if QuestUI.State == "details" then
            QuestUI.State = "list"
        else
            QuestManager.Close()
        end
        return true
    end
    
    return false
end

function QuestManager.UpdateMouse()
    if not QuestManager.IsOpen() then return end
    
    local mx = MousePosX()
    local my = MousePosY()
    local posX = CONFIG.WindowPos.x
    local posY = CONFIG.WindowPos.y
    local w = CONFIG.WindowSize.width
    local h = CONFIG.WindowSize.height
    
    -- ============================================
    -- ARRASTO DA JANELA (pelo header)
    -- ============================================
    if CheckPressedKey(Keys.LButton) == 1 then
        -- Se clicar no header (primeiros 40px de altura)
        if mx >= posX and mx <= posX + w and my >= posY and my <= posY + 40 then
            CONFIG.Dragging = true
            CONFIG.DragOffsetX = mx - posX
            CONFIG.DragOffsetY = my - posY
        end
    end
    
    if CheckReleasedKey(Keys.LButton) == 1 then
        CONFIG.Dragging = false
        
        if QuestUI.State == "list" then
            -- Detectar clique em quest na lista
            local y_offset = posY + 50
            local quest_count = 0
            
            for quest_id, _ in pairs(QuestData.PlayerQuests) do
                if my >= y_offset and my <= y_offset + 22 then
                    QuestUI.SelectedQuest = quest_id
                    QuestUI.State = "details"
                    break
                end
                y_offset = y_offset + 24
                quest_count = quest_count + 1
                if quest_count >= 9 then break end
            end
        elseif QuestUI.State == "details" then
            if QuestUI.ButtonClicked(6) then
                QuestUI.State = "list"
            elseif QuestUI.ButtonClicked(2) then
                if QuestUI.SelectedQuest then
                    local quest = QuestData.GetQuestById(QuestUI.SelectedQuest)
                    if quest then
                        local quest_status = QuestData.PlayerQuests[quest.id] or {state = 0}
                        if quest_status.state == 2 then
                            QuestProtocol.SendDeliverQuest(quest.id)
                        else
                            QuestProtocol.SendAcceptQuest(quest.id)
                        end
                    end
                end
            end
        end
    end
    
    -- ============================================
    -- ATUALIZAR POSIÇÃO SE ARRASTANDO
    -- ============================================
    if CONFIG.Dragging then
        CONFIG.WindowPos.x = mx - CONFIG.DragOffsetX
        CONFIG.WindowPos.y = my - CONFIG.DragOffsetY
    end
end

BridgeFunctionAttach('MainInterfaceProcThread', 'QuestManager_MainInterface')
BridgeFunctionAttach('KeyboardEvent', 'QuestManager_KeyboardEvent')
BridgeFunctionAttach('UpdateMouseEvent', 'QuestManager_UpdateMouse')

function QuestManager_MainInterface()
    QuestManager.MainInterface()
end

function QuestManager_KeyboardEvent(key)
    QuestManager.KeyboardEvent(key)
end

function QuestManager_UpdateMouse()
    QuestManager.UpdateMouse()
end

return QuestManager