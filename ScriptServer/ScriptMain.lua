require('System\\ScriptCore')
require('System\\ProtocolCore')
--require('Scripts\\WelcomeMessage')
require('Scripts\\NpcTalk')

require('Utils\\Database')
require('Utils\\DatabaseAsync')
require('Utils\\Cron')
require('Utils\\Functions')
require('Utils\\Schedule')
require('Utils\\QuestGenerator')


--requirefolder('Scripts\\TesteProtocol')
requirefolder('Scripts\\AutoPost')

require('Scripts\\QuestData') -- Carrega a lista de quests primeiro
require('Scripts\\MainQuest') -- O MainQuest vai dar require no QuestCore automaticamente

DataBase.Connect(3, "MuOnline", "sa", "Gu031988")