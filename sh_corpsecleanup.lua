local MODULE = MODULE

MODULE.Name = "NPC Corpse Cleanup"
MODULE.Description = "A simple timer that deletes NPC Corpses"
MODULE.Author = "KarmaLN"

ax.config:Add("corpseCleanupTime", ax.type.number, 180, {
    description = "Sets the Cooldown on NPC Corpse Cleanup",
    min = 30,
    max = 3600,
    decimals = 0,
    category = "Plugins",
})

local function CleanUpTimer()
    if !timer.Exists("DeleteNPCCorpses") then
        timer.Create("DeleteNPCCorpses", ax.config:Get("corpseCleanupTime"), 0, function()
            RunConsoleCommand("g_ragdoll_maxcount", "0")
                
            timer.Simple(2, function()
                RunConsoleCommand("g_ragdoll_maxcount", "15")
                if SERVER then
                	game.ConsoleCommand("vj_run_cleanup corpses")
                end
            end)
            ax.util:Print(Color(0, 255, 0),"Completed NPC Corpse Cleanup")
        end)
    end
end

function MODULE:OnSchemaLoaded()
	CleanUpTimer()
end
