-- Data\Custom\Script\System\LoadImages.lua
BridgeFunctionAttach('MainLoader','LoadImages')

function LoadImages()
    -- Carrega a imagem bg505.ozt (tente sem a extensão se der erro)
    LoadBitmap("Custom\\ScriptImages\\QuestWindow.Jpg", 50005) 
    
    -- Carrega as setas apenas se necessário
    LoadBitmap("Custom\\ScriptImages\\Next.tga", 50002)
    LoadBitmap("Custom\\ScriptImages\\Previous.tga", 50003)
    
    Console(2,"[QuestSystem] Imagem bg505 carregada no ID 50005")
end