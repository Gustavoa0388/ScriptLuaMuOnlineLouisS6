-- ScriptClient/Script/Scripts/QuestSystem/QuestUI.lua

local QuestData = require("Scripts\\QuestSystem\\QuestData")
local QuestProtocol = require("Scripts\\QuestSystem\\QuestProtocol")
local CONFIG = require("Scripts\\QuestSystem\\Config")

local QuestUI = {}

QuestUI.State = "list"
QuestUI.SelectedQuest = nil

function QuestUI.CreateButton(ID, x, y, w, h)
    if CONFIG.Button[ID] == nil then
        CONFIG.Button[ID] = {
            x = x, y = y, w = w, h = h,
            clicked = false, timer = 0
        }
    else
        CONFIG.Button[ID].x = x
        CONFIG.Button[ID].y = y
        CONFIG.Button[ID].w = w
        CONFIG.Button[ID].h = h
    end
end

function QuestUI.ButtonMouseOver(ID, mx, my)
    if CONFIG.Button[ID] == nil then return false end
    local b = CONFIG.Button[ID]
    return mx >= b.x and mx <= (b.x + b.w) and my >= b.y and my <= (b.y + b.h)
end

function QuestUI.ButtonClicked(ID)
    if CONFIG.Button[ID] == nil then return false end
    if CONFIG.Button[ID].clicked then
        if CONFIG.Button[ID].timer >= 2 then
            CONFIG.Button[ID].timer = 0
            CONFIG.Button[ID].clicked = false
            return false
        end
        CONFIG.Button[ID].timer = CONFIG.Button[ID].timer + 1
        return true
    end
    return false
end

-- ============================================
-- RENDER - TELA PRINCIPAL
-- ============================================
function QuestUI.RenderMain()
    local posX = CONFIG.WindowPos.x
    local posY = CONFIG.WindowPos.y
    local w = CONFIG.WindowSize.width
    local h = CONFIG.WindowSize.height
    
    -- RENDERIZAR IMAGEM
    RenderImage(50000, posX, posY, w, h)
    
    -- HEADER
    SetFontType(1)
    SetTextColor(table.unpack(CONFIG.Colors.Gold))
    RenderText5(posX + 15, posY + 18, "DIARIO DE QUESTS", w - 30, 1)
    
    -- CLOSE BUTTON
    QuestUI.CreateButton(CONFIG.ButtonID.close, posX + w - 25, posY + 15, 15, 15)
    if QuestUI.ButtonMouseOver(CONFIG.ButtonID.close, MousePosX(), MousePosY()) then
        SetTextColor(table.unpack(CONFIG.Colors.Red))
    else
        SetTextColor(table.unpack(CONFIG.Colors.Gold))
    end
    RenderText5(posX + w - 25, posY + 10, "X", 20, 1)
    
    -- LISTA DE QUESTS
    SetFontType(0)
    SetTextColor(table.unpack(CONFIG.Colors.White))
    
    local y_offset = posY + 50
    local quest_count = 0
    
    for quest_id, quest_status in pairs(QuestData.PlayerQuests) do
        local quest = QuestData.GetQuestById(quest_id)
        if quest then
            quest_count = quest_count + 1
            
            local color = CONFIG.Colors.Gray
            if quest_status.state == CONFIG.QuestStates.ACTIVE then
                color = CONFIG.Colors.Green
            elseif quest_status.state == CONFIG.QuestStates.COMPLETED then
                color = CONFIG.Colors.Gold
            end
            
            SetTextColor(table.unpack(color))
            RenderText5(posX + 20, y_offset, string.format("[%d] %s", 
                quest.chapter, quest.title), w - 40, 1)
            
            y_offset = y_offset + 24
            
            if quest_count >= 9 then break end
        end
    end
    
    if quest_count == 0 then
        SetTextColor(table.unpack(CONFIG.Colors.Gray))
        RenderText5(posX + 20, posY + 120, "Nenhuma quest", w - 40, 1)
    end
end

-- ============================================
-- RENDER - DETALHES
-- ============================================
function QuestUI.RenderDetails()
    if not QuestUI.SelectedQuest then return end
    
    local quest = QuestData.GetQuestById(QuestUI.SelectedQuest)
    if not quest then return end
    
    local posX = CONFIG.WindowPos.x
    local posY = CONFIG.WindowPos.y
    local w = CONFIG.WindowSize.width
    local h = CONFIG.WindowSize.height
    
    -- RENDERIZAR IMAGEM
    RenderImage(50000, posX, posY, w, h)
    
    -- TITLE
    SetFontType(1)
    SetTextColor(table.unpack(CONFIG.Colors.Gold))
    RenderText5(posX + 15, posY + 18, quest.title, w - 30, 1)
    
    -- CLOSE BUTTON
    QuestUI.CreateButton(CONFIG.ButtonID.close, posX + w - 25, posY + 15, 15, 15)
    if QuestUI.ButtonMouseOver(CONFIG.ButtonID.close, MousePosX(), MousePosY()) then
        SetTextColor(table.unpack(CONFIG.Colors.Red))
    else
        SetTextColor(table.unpack(CONFIG.Colors.Gold))
    end
    RenderText5(posX + w - 25, posY + 10, "X", 20, 1)
    
    -- CHAPTER AND ARC
    SetFontType(0)
    SetTextColor(table.unpack(CONFIG.Colors.DarkGray))
    RenderText5(posX + 15, posY + 38, string.format("Cap. %d - %s", 
        quest.chapter, quest.arc), w - 30, 1)
    
    -- DESCRIPTION
    SetTextColor(table.unpack(CONFIG.Colors.White))
    RenderText5(posX + 15, posY + 60, quest.description, w - 30, 1)
    
    -- PROGRESS
    local quest_status = QuestData.PlayerQuests[quest.id] or {state = 0, progress = 0, max_progress = 0}
    SetTextColor(table.unpack(CONFIG.Colors.Green))
    RenderText5(posX + 15, posY + 115, string.format("Progresso: %d / %d", 
        quest_status.progress or 0, 
        quest_status.max_progress or 0), w - 30, 1)
    
    -- REWARDS LABEL
    SetTextColor(table.unpack(CONFIG.Colors.Gold))
    RenderText5(posX + 15, posY + 140, "RECOMPENSAS", w - 30, 1)
    
    -- REWARDS VALUES
    SetTextColor(table.unpack(CONFIG.Colors.White))
    RenderText5(posX + 20, posY + 160, string.format("EXP: %d", quest.rewards.exp), w - 40, 1)
    RenderText5(posX + 20, posY + 178, string.format("GP: %d", quest.rewards.money), w - 40, 1)
    
    -- BUTTONS
    local btn_y = posY + 250
    
    -- BACK BUTTON
    QuestUI.CreateButton(CONFIG.ButtonID.back, posX + 20, btn_y, 80, 24)
    if QuestUI.ButtonMouseOver(CONFIG.ButtonID.back, MousePosX(), MousePosY()) then
        SetTextColor(table.unpack(CONFIG.Colors.Gold))
    else
        SetTextColor(table.unpack(CONFIG.Colors.White))
    end
    SetFontType(0)
    RenderText5(posX + 20, btn_y + 6, "VOLTAR", 80, 3)
    
    -- ACCEPT BUTTON
    QuestUI.CreateButton(CONFIG.ButtonID.accept, posX + w - 105, btn_y, 85, 24)
    if QuestUI.ButtonMouseOver(CONFIG.ButtonID.accept, MousePosX(), MousePosY()) then
        SetTextColor(table.unpack(CONFIG.Colors.Gold))
    else
        SetTextColor(table.unpack(CONFIG.Colors.White))
    end
    
    local btn_text = CONFIG.MESSAGES[2][GetLanguage()]
    if quest_status.state == CONFIG.QuestStates.COMPLETED then
        btn_text = CONFIG.MESSAGES[5][GetLanguage()]
    end
    RenderText5(posX + w - 105, btn_y + 6, btn_text, 85, 3)
end

return QuestUI