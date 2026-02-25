local MODULE = MODULE

MODULE.Name = "NPC Corpse Cleanup"
MODULE.Description = "A simple timer that deletes NPC Corpses"
MODULE.Author = "KarmaLN"

local function CleanUpTimer()
    if !timer.Exists("DeleteNPCCorpses") then
        timer.Create("DeleteNPCCorpses", 180, 0, function()
            RunConsoleCommand("g_ragdoll_maxcount", "0")
                
            timer.Simple(2, function()
                RunConsoleCommand("g_ragdoll_maxcount", "15")
                RunConsoleCommand("vj_run_cleanup","corpses")
            end)
            
        end)
    end
end

function MODULE:InitPostEntity()
	CleanUpTimer()
end
