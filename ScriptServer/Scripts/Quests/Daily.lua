-- Data\Script\Scripts\Quests\Daily.lua
local DailyQuests = {
    -- [DIÁRIAS] 1 a 20: Narrativas Curtas
    { id = 1, tipo = 1, subTipo = "CACA", mobID = 1, alvo = 50, premioZen = 100000, titulo = "Limpeza de Fronteira", lore = "As aranhas estao invadindo as plantacoes de Lorencia. Elimine-as para garantir o suprimento da capital." },
    { id = 2, tipo = 1, subTipo = "CACA", mobID = 2, alvo = 40, premioZen = 80000, titulo = "Praga de Goblins", lore = "Saqueadores estao roubando carruagens de mercadores. Recupere a seguranca das estradas principais." },
    { id = 3, tipo = 1, subTipo = "COLETA", itemID = 6159, alvo = 2, premioZen = 200000, titulo = "Suprimentos de Guerra", lore = "O exercito real precisa de Bless para fortalecer as armaduras dos recrutas. Traga-as para o quartel." },
    { id = 4, tipo = 1, subTipo = "NPC", npcID = 251, alvo = 1, premioZen = 50000, titulo = "Relatorio ao Ferreiro", lore = "Hanzo precisa saber a qualidade das laminas em campo. Va ate ele e relate o estado das espadas." },
    { id = 5, tipo = 1, subTipo = "CACA", mobID = 14, alvo = 30, premioZen = 120000, titulo = "Silenciando Esqueletos", lore = "Os mortos estao inquietos no cemiterio. Devolva o descanso eterno a essas almas perdidas." },
    { id = 6, tipo = 1, subTipo = "COLETA", itemID = 6160, alvo = 2, premioZen = 150000, titulo = "Essencia Magica", lore = "Os magos de Arca pediram essencias de almas para rituais. Colete Soul para as pesquisas." },
    { id = 7, tipo = 1, subTipo = "CACA", mobID = 20, alvo = 40, premioZen = 180000, titulo = "Terror em Devias", lore = "Yetis estao bloqueando as passagens nevadas. Limpe o caminho para evitar mortes por frio." },
    { id = 8, tipo = 1, subTipo = "NPC", npcID = 257, alvo = 1, premioZen = 60000, titulo = "Bencao da Elfa", lore = "Elf Lala esta distribuindo bencas. Va ate ela para mostrar que voce ainda luta pela luz." },
    { id = 9, tipo = 1, subTipo = "CACA", mobID = 43, alvo = 25, premioZen = 250000, titulo = "Caca em Atlans", lore = "Criaturas marinhas atacam mergulhadores. Mostre a furia da superficie nas profundezas." },
    { id = 10, tipo = 1, subTipo = "COLETA", itemID = 7181, alvo = 5, premioZen = 300000, titulo = "Minerios Brutos", lore = "Recupere medalhas perdidas. Elas sao o unico registro de herois que ja cairam." },
    { id = 11, tipo = 1, subTipo = "CACA", mobID = 49, alvo = 20, premioZen = 400000, titulo = "Exterminio de Tarkan", lore = "Monstros do deserto estao agressivos. Reduza suas fileiras antes que cheguem as cidades." },
    { id = 12, tipo = 1, subTipo = "NPC", npcID = 245, alvo = 1, premioZen = 100000, titulo = "Visita ao Mago", lore = "Poisongirl precisa de ingredientes. Va ate ela e veja se pode ajudar no estoque de pocoes." },
    { id = 13, tipo = 1, subTipo = "CACA", mobID = 63, alvo = 15, premioZen = 500000, titulo = "Ameaca Alada", lore = "Drakanes sobrevoam as ruinas celestiais. Abata-os antes que ataquem a cidade." },
    { id = 14, tipo = 1, subTipo = "COLETA", itemID = 6161, alvo = 1, premioZen = 600000, titulo = "Fragmentos de Criacao", lore = "A vida e fragil. Traga uma Life para ajudar na cura dos soldados feridos." },
    { id = 15, tipo = 1, subTipo = "CACA", mobID = 39, alvo = 35, premioZen = 350000, titulo = "Patrulha de Lost Tower", lore = "As sombras escondem horrores. Faca uma patrulha e elimine os Shadows que encontrar." },
    { id = 16, tipo = 1, subTipo = "NPC", npcID = 249, alvo = 1, premioZen = 80000, titulo = "Conselho de Guerra", lore = "O guarda real tem ordens sigilosas. Va ate ele para receber instrucoes de defesa." },
    { id = 17, tipo = 1, subTipo = "CACA", mobID = 34, alvo = 30, premioZen = 280000, titulo = "Furia das Sombras", lore = "Cursed Wizards conjuram feiticos proibidos. Interrompa os rituais imediatamente." },
    { id = 18, tipo = 1, subTipo = "COLETA", itemID = 6162, alvo = 1, premioZen = 1000000, titulo = "Recuperacao de Tesouros", lore = "Antigas reliquias estao espalhadas. Recupere uma Creation para os arquivos reais." },
    { id = 19, tipo = 1, subTipo = "CACA", mobID = 11, alvo = 50, premioZen = 200000, titulo = "Desafio do Pantano", lore = "As criaturas estao se multiplicando. Reduza a populacao para evitar infestacoes." },
    { id = 20, tipo = 1, subTipo = "CACA", mobID = 7, alvo = 45, premioZen = 150000, titulo = "Limpeza Profunda", lore = "Lichs corrompem as masmorras. Purifique o local eliminando essas aberracoes." },
}

-- [DIÁRIAS] 21 a 50: Automáticas para SideQuests de Suporte
for i = 21, 50 do
    table.insert(DailyQuests, { 
        id = i, tipo = 1, subTipo = "CACA", mobID = 1, alvo = 25 + i, premioZen = 50000 + (i * 1000), 
        titulo = "Manutencao de Ordem #"..i, 
        lore = "Ajude o Capitao da Guarda a manter a paz eliminando as ameacas que rondam as vilas locais." 
    })
end

return DailyQuests