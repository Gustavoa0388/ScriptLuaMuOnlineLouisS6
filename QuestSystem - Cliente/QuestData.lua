-- ScriptClient/Script/Scripts/QuestSystem/QuestData.lua

local QuestData = {}
QuestData.Quests = {}
QuestData.PlayerQuests = {}
QuestData.CurrentQuest = nil

QuestData.Quests[1001] = {
    id = 1001,
    title = "O Vilarejo Sob Ameaça",
    chapter = 1,
    arc = "O Despertar",
    level_required = 1,
    description = "O capitão da guarda pede ajuda para eliminar aranhas que infestam o vilarejo.",
    lore = "Há séculos, Lorencia era um lugar pacífico. Mas recentemente, criaturas corrompidas começaram a emergir do submundo. O capitão da guarda está desesperado e procura por qualquer um que possa ajudar...",
    npc_id = 1,
    npc_name = "Capitão da Guarda",
    
    objective_type = "hunt",
    target_mob = 3,
    target_count = 10,
    
    rewards = {
        exp = 1000,
        money = 5000,
        items = {
            {index = 0, level = 0, count = 1},
        },
    },
    
    next_quest_id = 1002,
    unlocked = true,
    repeatable = false,
}

QuestData.Quests[1002] = {
    id = 1002,
    title = "Os Segredos das Sombras",
    chapter = 2,
    arc = "O Despertar",
    level_required = 10,
    description = "Investigar a origem das criaturas corrompidas coletando artefatos.",
    lore = "Após eliminar as aranhas, você descobre que elas não são simples animais. Existem símbolos antigos em seus corpos...",
    npc_id = 1,
    npc_name = "Capitão da Guarda",
    
    objective_type = "collect",
    target_item = 6159,
    target_count = 5,
    
    rewards = {
        exp = 2000,
        money = 10000,
        items = {},
    },
    
    next_quest_id = 1003,
    unlocked = false,
    repeatable = false,
}

QuestData.Quests[1003] = {
    id = 1003,
    title = "O Mago das Ruínas",
    chapter = 3,
    arc = "O Despertar",
    level_required = 20,
    description = "Encontre o antigo mago que pode explicar a corrupção.",
    lore = "As pistas levam você a ruínas antigas. Lá, você encontra um mago que viveu por séculos...",
    npc_id = 2,
    npc_name = "Mago Antigo",
    
    objective_type = "talk",
    target_npc = 2,
    
    rewards = {
        exp = 5000,
        money = 20000,
        items = {},
    },
    
    next_quest_id = nil,
    unlocked = false,
    repeatable = false,
}

QuestData.Quests[2001] = {
    id = 2001,
    title = "O Cristal Corrompido",
    chapter = 4,
    arc = "A Ascensão da Corrupção",
    level_required = 30,
    description = "Encontre pedaços de um cristal antigo que alimenta a corrupção.",
    lore = "O mago revela a existência de um cristal antigo que foi corrompido. Você deve encontrar seus fragmentos espalhados pelo reino.",
    npc_id = 2,
    npc_name = "Mago Antigo",
    
    objective_type = "collect",
    target_item = 6160,
    target_count = 10,
    
    rewards = {
        exp = 8000,
        money = 30000,
        items = {},
    },
    
    next_quest_id = 2002,
    unlocked = false,
    repeatable = false,
}

QuestData.Quests[2002] = {
    id = 2002,
    title = "Purificação do Cristal",
    chapter = 5,
    arc = "A Ascensão da Corrupção",
    level_required = 40,
    description = "Derrote os guardiões que protegem o cristal e o purifique.",
    lore = "Com os fragmentos reunidos, agora você deve enfrentar os guardiões que o protegem...",
    npc_id = 3,
    npc_name = "Sacerdotisa",
    
    objective_type = "hunt",
    target_mob = 50,
    target_count = 1,
    
    rewards = {
        exp = 15000,
        money = 50000,
        items = {},
    },
    
    next_quest_id = nil,
    unlocked = false,
    repeatable = false,
}

function QuestData.GetQuestById(id)
    return QuestData.Quests[id]
end

function QuestData.GetQuestsByArc(arc_name)
    local quests = {}
    for _, quest in pairs(QuestData.Quests) do
        if quest.arc == arc_name then
            table.insert(quests, quest)
        end
    end
    return quests
end

function QuestData.GetPlayerQuestStatus(quest_id)
    return QuestData.PlayerQuests[quest_id] or {
        state = 0,
        progress = 0,
    }
end

function QuestData.InitializePlayerQuests()
    QuestData.PlayerQuests[1001] = {
        state = 0,
        progress = 0,
        max_progress = 10,
    }
    
    QuestData.PlayerQuests[1002] = {
        state = 0,
        progress = 0,
        max_progress = 5,
    }
    
    QuestData.PlayerQuests[1003] = {
        state = 0,
        progress = 0,
        max_progress = 1,
    }
    
    QuestData.PlayerQuests[2001] = {
        state = 0,
        progress = 0,
        max_progress = 10,
    }
    
    Console(1, "[QuestData] PlayerQuests inicializado com dados de teste")
end

QuestData.InitializePlayerQuests()

return QuestData