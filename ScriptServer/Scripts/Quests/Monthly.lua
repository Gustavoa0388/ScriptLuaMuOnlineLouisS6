-- Data\Script\Scripts\Quests\Monthly.lua
local Monthly = {
    -- CAPÍTULO 1: O CERCO DE FERRO (LVL 1 - 100)
    { 
        id = 201, tipo = 3, subTipo = "CACA", mobID = 3, alvo = 100, 
        titulo = "Cap 1.1: Praga nas Sombras", 
        lore = "[Lvl Rec: 10] O Capitao da Guarda (168/129) notou aranhas estranhas. Elimine-as para proteger os portoes.",
        PreviewID = 1, RewardID = 6159
    },
    { 
        id = 202, tipo = 3, subTipo = "COLETA", itemID = 6159, alvo = 5, 
        titulo = "Cap 1.2: Selos de Protecao", 
        lore = "[Lvl Rec: 30] O metal das muralhas apodrece. O Capitao precisa de 5 Bless para criar um selo magico.",
        PreviewID = 6159, RewardID = 7181
    },
    { 
        id = 203, tipo = 3, subTipo = "NPC", npcID = 251, alvo = 1, 
        titulo = "Cap 1.3: O Relato de Hanzo", 
        lore = "[Lvl Rec: 50] Desconfiamos de sabotagem. Va ate o Ferreiro Hanzo e investigue as forjas.",
        PreviewID = 251, RewardID = 0
    },

    -- CAPÍTULO 2: OS ECOS DE DUNGEON (LVL 100 - 250)
    { 
        id = 204, tipo = 3, subTipo = "EXPLORAR", mapID = 2, alvo = 1, 
        titulo = "Cap 2.1: O Portal de Pedra", 
        lore = "[Lvl Rec: 120] A magia negra vem de Dungeon. Desca ate as catacumbas e localize a entrada.",
        PreviewID = 2, RewardID = 6160
    }
}
return Monthly