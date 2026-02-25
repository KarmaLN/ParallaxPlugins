local MODULE = MODULE

MODULE.Name = "NPC Corpse Cleanup"
MODULE.Description = "A simple timer that deletes NPC Corpses"
MODULE.Author = "KarmaLN"

MODULE.CleanupTime = 180

local function CleanUpTimer()
    if !timer.Exists("DeleteNPCCorpses") then
        timer.Create("DeleteNPCCorpses", MODULE.CleanupTime, 0, function()
            RunConsoleCommand("g_ragdoll_maxcount", "0")
                
            timer.Simple(2, function()
                RunConsoleCommand("g_ragdoll_maxcount", "15")
                RunConsoleCommand("vj_run_cleanup","corpses")
            end)
            ax.util:Print(Color(0, 255, 0),"Completed NPC Corpse Cleanup)
        end)
    end
end

hook.Add("OnSchemaLoaded", "ParallaxCorpseCleanup", function()
	CleanUpTimer()
end)
