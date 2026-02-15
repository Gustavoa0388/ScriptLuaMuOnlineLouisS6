-- Data\Custom\Script\Scripts\QuestData.lua
local QuestData = {}
QuestData.Pool = {}

-- Tabelas de dados (Copie apenas os IDs e Lore para o cliente)
local Monthly = {
    { 
        id = 201, subTipo = "CACA", mobID = 3, alvo = 100, 
        titulo = "Cap 1.1: Praga nas Sombras", 
        lore = "O Capitao da Guarda (168/129) notou aranhas estranhas em Lorencia. Elimine-as para proteger os portoes da capital." 
    },
    { 
        id = 202, subTipo = "COLETA", itemID = 6159, alvo = 5, 
        titulo = "Cap 1.2: Selos de Protecao", 
        lore = "O metal das muralhas apodrece. O Capitao precisa de 5 Bless para criar um selo magico contra a corrupcao." 
    }
}

-- Insere os dados no Pool de memória do Cliente
for _, q in ipairs(Monthly) do
    table.insert(QuestData.Pool, q)
end

-- Função de busca para a Interface
function QuestData.GetById(id)
    for _, q in ipairs(QuestData.Pool) do 
        if tonumber(q.id) == tonumber(id) then return q end 
    end
    return nil
end

return QuestData