-- Data\Custom\Script\Scripts\QuestWindow\QuestWindow.lua

NewWindow = NewWindow or {}

local CONFIG    = require("Scripts\\QuestWindow\\Config")
local QuestData = require("Scripts\\QuestData")

QuestAtivaID   = QuestAtivaID or 0
QuestProgresso = QuestProgresso or 0
QuestAlvo      = QuestAlvo or 0

function QuestWindowInterface()
    if UICustomInterface ~= CONFIG.WindowID then return end

    -- Posição da Janela (Fundo)
    local posX = (GetWideX() / 2) - (350 / 2)
    local posY = 45

    -------------------------------------------------
    -- FUNDO
    -------------------------------------------------
    RenderImage(50005, posX, posY, 350, 350)

    -------------------------------------------------
    -- HEADER (Título ajustado por você)
    -------------------------------------------------
    SetFontType(1)
    SetTextColor(255, 215, 0, 255)
    RenderText5(340, 72, "DIÁRIO DE MISSÕES", 72, 3)

    -------------------------------------------------
    -- MENU ESQUERDO (Coordenadas Fixas)
    -------------------------------------------------
    SetFontType(0)
    SetTextColor(255, 255, 255, 255)

    -- Alinhado horizontalmente em 240 (dentro dos botões vermelhos da esquerda)
    RenderText5(240, 115, "Diárias", 80, 3)
    RenderText5(240, 143, "Semanais", 80, 3)
    RenderText5(240, 171, "História", 80, 3)
    RenderText5(240, 199, "Lorencia", 80, 3)

    -------------------------------------------------
    -- CONTEÚDO DIREITO (Coordenadas Fixas)
    -------------------------------------------------
    local q = QuestData.GetById(QuestAtivaID)

    if q then
        -- TÍTULO DA MISSÃO (Centralizado no quadro maior)
        SetFontType(1)
        SetTextColor(255, 255, 255, 255)
        RenderText5(440, 105, q.titulo, 200, 3)

        -- LORE / DESCRIÇÃO (Alinhado à esquerda no quadro de detalhes)
        SetFontType(0)
        SetTextColor(200, 200, 200, 255)
        RenderText5(355, 125, q.lore, 175, 1)

        -- MONSTRO (Renderizado no meio do quadro direito)
        RenderMonster(LoadMonster(q.mobID), 450, 210, 1.1)

        -- PROGRESSO
        SetTextColor(255, 255, 0, 255)
        RenderText5(440, 270, string.format("Progresso: %d / %d", QuestProgresso, QuestAlvo), 200, 3)
        
        -- RECOMPENSAS
        SetFontType(1)
        SetTextColor(0, 255, 100, 255)
        RenderText5(440, 300, "RECOMPENSAS", 200, 3)
        
        if q.RewardID and q.RewardID > 0 then
             RenderItem(q.RewardID, 440, 320, 20, 20)
        end
    else
        SetTextColor(150, 150, 150, 255)
        RenderText5(440, 200, "Nenhuma Missão Ativa", 200, 3)
    end

    -------------------------------------------------
    -- BOTÕES INFERIORES (Coordenadas Fixas)
    -------------------------------------------------
    SetFontType(1)
    SetTextColor(255, 255, 255, 255)

    -- DESISTIR (Alinhado no botão vermelho esquerdo de baixo)
    RenderText5(355, 382, "DESISTIR", 80, 3)

    -- IR AGORA (Alinhado no botão vermelho direito de baixo)
    RenderText5(465, 382, "IR AGORA", 80, 3)
end

function QuestKeyListener(key)
    if CheckWindowOpen(UIChatWindow) == 1 then return false end
    if key == Keys.L then
        UICustomInterface = (UICustomInterface == CONFIG.WindowID) and 0 or CONFIG.WindowID
        return true
    end
    return false
end

BridgeFunctionAttach("MainInterfaceProcThread", "QuestWindowInterface")
BridgeFunctionAttach("KeyboardEvent", "QuestKeyListener")