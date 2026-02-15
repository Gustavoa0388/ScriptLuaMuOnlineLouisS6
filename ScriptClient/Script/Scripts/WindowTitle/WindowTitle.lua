-- IgkGamers / Karuritoku
-- Grupo Whatsapp: https://chat.whatsapp.com/IYc6Qp5WL3d3USWrANTX5Y

local CONFIG = require("Scripts\\WindowTitle\\Config")

BridgeFunctionAttach('MainProcThread', 'WindowTitleMainProc')

local TimeToUpdate = 0

local titleParts = {
	{ enabled = function() return CONFIG.EnableName == 1 end,         value = UserGetName,            label = "Name" },
	{ enabled = function() return CONFIG.EnableLevel == 1 end,        value = UserGetLevel,           label = "Level" },
	{ enabled = function() return CONFIG.EnableMasterLevel == 1 end,  value = UserGetMasterLevel,     label = "M.Level" },
	{ enabled = function() return CONFIG.EnableReset == 1 end,        value = GetViewReset,           label = "Reset" },
	{ enabled = function() return CONFIG.EnableMasterReset == 1 end,  value = GetViewMasterReset,     label = "M.Reset" },
	{ enabled = function() return CONFIG.EnableCoin1 == 1 end,        value = GetCoin1,               label = "WC" },
	{ enabled = function() return CONFIG.EnableCoin2 == 1 end,        value = GetCoin2,               label = "WP" },
	{ enabled = function() return CONFIG.EnableCoin3 == 1 end,        value = GetCoin3,               label = "GP" },
	{ 
		enabled = function() return CONFIG.EnableVip == 1 end, 
		value = function()
			local level = GetViewAccountLevel()
			local vipNames = {
				[0] = "Gustavo",
				[1] = "BRONZE",
				[2] = "SILVER",
				[3] = "GOLDEN"
			}
			return vipNames[level] or ("VIP " .. tostring(level))
		end, 
		label = "Account" 
	},
}

function WindowTitleMainProc()
	TimeToUpdate = TimeToUpdate + 1

	if TimeToUpdate > 60 and GetMainScene() == 5 then
		TimeToUpdate = 0

		local StringWindowTitle = CONFIG.ServerName
		local parts = {}

		for _, part in ipairs(titleParts) do
			if part.enabled() then
				table.insert(parts, part.label .. ": " .. part.value())
			end
		end

		if #parts > 0 then
			StringWindowTitle = StringWindowTitle .. " | " .. table.concat(parts, " | ")
		end

		SetWindowTitle(StringWindowTitle)
	end
end
