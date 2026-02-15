-- Data\Script\Utils\QuestGenerator.lua
local Generator = {}

function Generator.Sortear(tipo, quantidade)
    local disponiveis = {}
    local selecionadas = {}

    -- Filtra as quests do tipo solicitado (Diário, Semanal...)
    for _, q in ipairs(QuestData.Pool) do
        if q.tipo == tipo then
            table.insert(disponiveis, q.id)
        end
    end

    -- Sorteio Aleatório sem repetir
    while #selecionadas < quantidade and #disponiveis > 0 do
        local index = RandomGetNumber(#disponiveis) + 1
        table.insert(selecionadas, disponiveis[index])
        table.remove(disponiveis, index) -- Remove para não sortear igual
    end

    return selecionadas
end

return Generator