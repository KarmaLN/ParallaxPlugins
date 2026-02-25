local MODULE = MODULE

MODULE.Name = "Workshop Loader"
MODULE.Description = ""
MODULE.Author = "Riggs and Karma"

local EXCLUDED_WORKSHOP_IDS_LIST = {
    "875631347", "105984257",
}

local EXCLUDED_WORKSHOP_IDS = {}

for _, id in ipairs(EXCLUDED_WORKSHOP_IDS_LIST) do
    EXCLUDED_WORKSHOP_IDS[id] = true
end

local function IncludeWorkshopAddons()
    ax.util:Print("Loading workshop addons...")

    local total = 0
    local skipped = 0
    local addons = engine.GetAddons()

    for _, v in ipairs(addons) do
        if (v.mounted and v.wsid ~= "0") then
            if (EXCLUDED_WORKSHOP_IDS[v.wsid]) then
                skipped = skipped + 1
                ax.util:Print(Color(255, 150, 0), "Skipped workshop addon: " .. v.title)
                continue
            end

            total = total + 1
            resource.AddWorkshop(v.wsid)
            ax.util:Print("Added workshop addon: " .. v.title)
        end
    end

    ax.util:Print(
        Color(0, 255, 0),
        "Completed workshop addon load (" .. total .. " added, " .. skipped .. " skipped)."
    )
end

function MODULE:OnSchemaLoaded()
    IncludeWorkshopAddons()
end

