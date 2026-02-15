-- Data\Script\Scripts\Quests\Weekly.lua
local WeeklyQuests = {
    -- [SEMANAIS] 51 a 70: Narrativas Curtas
    { id = 51, tipo = 2, subTipo = "LEVEL", alvo = 100, premioCoins = {c3 = 50}, titulo = "Provação de Iniciado", lore = "O Conselho exige que novos herois provem seu valor atingindo o nivel 100 antes de prosseguirem." },
    { id = 52, tipo = 2, subTipo = "LEVEL", alvo = 250, premioCoins = {c3 = 100}, titulo = "Treinamento Intensivo", lore = "Para alcancar os novos mapas da Season 20, voce deve focar em seu treinamento intenso esta semana." },
    { id = 53, tipo = 2, subTipo = "CACA", mobID = 18, alvo = 10, premioCoins = {c2 = 20}, titulo = "Cacador de Chefes", lore = "Metal Balrogs lideram invasoes. Elimine os lideres para desestabilizar o exército de Kundun." },
    { id = 54, tipo = 2, subTipo = "PVP", alvo = 5, premioCoins = {c1 = 10}, titulo = "Duelo de Honra", lore = "Treine suas habilidades contra outros guerreiros na Arena. O combate real exige pratica constante." },
    { id = 55, tipo = 2, subTipo = "COLETA", itemID = 6159, alvo = 15, premioCoins = {c1 = 30}, titulo = "Mestre das Joias", lore = "Estoque Bless esta semana para financiar a grande forja contra a Dimensao do Caos." },
    { id = 56, tipo = 2, subTipo = "CACA", mobID = 54, alvo = 100, premioCoins = {c2 = 50}, titulo = "Cacador de Tarkan", lore = "Va ate o deserto e elimine os monstros mais fortes. Mostre que a areia nao apagara seu nome." },
    { id = 57, tipo = 2, subTipo = "LEVEL", alvo = 400, premioCoins = {c3 = 200}, titulo = "Mestre do Conhecimento", lore = "Alcance o topo do poder classico. O nivel 400 e apenas o primeiro passo para a divindade." },
    { id = 58, tipo = 2, subTipo = "PVP", alvo = 20, premioCoins = {c1 = 50}, titulo = "Lenda da Arena", lore = "Domine o ranking semanal de PvP. O nome do campeao sera entalhado nas muralhas de Lorencia." },
    { id = 59, tipo = 2, subTipo = "EXPLORAR", mapID = 10, alvo = 1, premioCoins = {c3 = 150}, titulo = "Explorador Celestial", lore = "Va ate Icarus esta semana e sinta o ar das alturas. Recupere dados sobre as fendas celestiais." },
    { id = 60, tipo = 2, subTipo = "CACA", mobID = 300, alvo = 200, premioCoins = {c2 = 100}, titulo = "Pesadelo de Kanturu", lore = "As maquinas estao fora de controle. Destrua-as antes que processem tudo o que restou de Mu." },
    { id = 61, tipo = 2, subTipo = "RESET", alvo = 5, premioCoins = {c1 = 100}, titulo = "Ciclo de Renascimento", lore = "Fortaleca sua alma atraves do Reset. Cada ciclo aproxima voce dos antigos Deuses de Arka." },
    { id = 62, tipo = 2, subTipo = "CACA", mobID = 43, alvo = 150, premioZen = 5000000, titulo = "Terror Abissal", lore = "Atlans corre perigo. Limpe as rotas comerciais maritimas para garantir a economia do reino." },
}

-- [SEMANAIS] 63 a 100: Preenchimento de SideQuests
for i = 63, 100 do
    table.insert(WeeklyQuests, { 
        id = i, tipo = 2, subTipo = "CACA", mobID = 1, alvo = 500 + i, premioCoins = {c2 = 10}, 
        titulo = "Esforco Semanal #"..i, 
        lore = "Um desafio de resistencia semanal para guerreiros que buscam moedas de bonificacao extra." 
    })
end

return WeeklyQuests