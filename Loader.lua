local AstroTheBestDud = "htt"
local DandyCantMakeThis = "ps://"
local BoxtenAndCosmoForever = "raw.githubusercontent.com"
local PebblesIsCute = "/Midnight-Star-blip/Astro-s-Dreamworld/refs/heads/main/"
local GoobLovesYou = "AstroPart"

local function AstroSecretFunction(part)
    local TishaLovesSprout = AstroTheBestDud .. DandyCantMakeThis .. BoxtenAndCosmoForever .. PebblesIsCute .. GoobLovesYou .. part .. ".lua"
    return game:HttpGet(TishaLovesSprout)
end

local CosmoAndBoxten = {}
CosmoAndBoxten["Astro"] = game
CosmoAndBoxten["Dandy"] = CosmoAndBoxten["Astro"].HttpGet
CosmoAndBoxten["Vee"] = loadstring
CosmoAndBoxten["Scraps"] = pcall

local function GoobIsBest(part)
    local SproutIsAdorable = AstroSecretFunction(part)
    if SproutIsAdorable and #SproutIsAdorable > 500 then
        local GigiLovesYou = CosmoAndBoxten["Vee"](SproutIsAdorable)
        if GigiLovesYou then
            CosmoAndBoxten["Scraps"](GigiLovesYou)
            return true
        end
    end
    return false
end

local RodgerTheDetective = 0
local fullCode = ""

for AstroLoop = 1, 3 do
    RodgerTheDetective = RodgerTheDetective + 1
    if GoobIsBest(tostring(AstroLoop)) then
        -- part loaded  yayy
    end
    task.wait(0.2)
end

if RodgerTheDetective >= 2 then
    print("Astro the best dud :> Loaded successfully!")
else
    warn("Dandy can't make this... Astro failed to load :(")
end
