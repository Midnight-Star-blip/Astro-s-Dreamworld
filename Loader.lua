local AstroTheBestDud = "htt"
local DandyCantMakeThis = "ps://"
local BoxtenAndCosmoForever = "raw.githubusercontent.com"
local PebblesIsCute = "/Midnight-Star-blip/Astro-s-Dreamworld/refs/heads/main/"
local GoobLovesYou = "AstroMain"

local function AstroSecretFunction()
    local url = AstroTheBestDud .. DandyCantMakeThis .. BoxtenAndCosmoForever .. PebblesIsCute .. GoobLovesYou .. ".lua"
    print("Loading: " .. url)
    return game:HttpGet(url)
end

print("Astro Loading...")

local success, code = pcall(AstroSecretFunction)

if success and code and #code > 10000 then
    print("✅ Loaded yay!")
    loadstring(code)()
else
    warn("❌ Error :c, Goddammit Dandy")
    
end

print("Astro the best dud :> Proceso terminado")
