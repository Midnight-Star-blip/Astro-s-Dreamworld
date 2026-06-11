local AstroTheBestDud = "htt"
local DandyCantMakeThis = "ps://"
local BoxtenAndCosmoForever = "raw.githubusercontent.com"
local PebblesIsCute = "/Midnight-Star-blip/Astro-s-Dreamworld/refs/heads/main/"
local GoobLovesYou = "AstroPart"

local function AstroSecretFunction(part)
    local TishaLovesSprout = AstroTheBestDud .. DandyCantMakeThis .. BoxtenAndCosmoForever .. PebblesIsCute .. GoobLovesYou .. part .. ".lua"
    print("Loading :D " .. TishaLovesSprout)
    return game:HttpGet(TishaLovesSprout)
end

local function GoobIsBest(part)
    local success, code = pcall(AstroSecretFunction, part)
    if success and code and #code > 500 then
        loadstring(code)()
        print("✅ " .. part .. " Loaded yay!")
        return true
    else
        warn("❌ Error :c " .. part)
        return false
    end
end

print("Astro Loading...")

for i = 1, 4 do
    print("Loading :D " .. i)
    if GoobIsBest(tostring(i)) then
        task.wait(0.6)
    else
        task.wait(0.8)
    end
end

print("Astro the best dud :> ")
