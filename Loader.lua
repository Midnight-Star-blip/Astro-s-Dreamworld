
   -- Astro the best dud :> | Dandy can't make this | Boxten and Cosmo forever :P
   -- Protected by Meh Astro's Dreamworld get out of here!


local AstroTheBestDud = "htt";
local DandyCantMakeThis = "ps://";
local BoxtenAndCosmoForever = "raw.githubusercontent.com";
local PebblesIsCute = "/Midnight-Star-blip/Astro-s-Dreamworld/refs/heads/main/";
local GoobLovesYou = "AstroMain.lua";

local function AstroSecretFunction()
    local TishaLovesSprout = AstroTheBestDud..DandyCantMakeThis..BoxtenAndCosmoForever..PebblesIsCute..GoobLovesYou;
    return game:HttpGet(TishaLovesSprout);
end

local CosmoAndBoxten = {};
CosmoAndBoxten["Astro"] = game;
CosmoAndBoxten["Dandy"] = CosmoAndBoxten["Astro"].HttpGet;
CosmoAndBoxten["Vee"] = loadstring;
CosmoAndBoxten["Scraps"] = pcall;

local function GoobIsBest()
    local SproutIsAdorable = AstroSecretFunction();
    if SproutIsAdorable and #SproutIsAdorable > 2000 then
        local GigiLovesYou = CosmoAndBoxten["Vee"](SproutIsAdorable);
        if GigiLovesYou then
            CosmoAndBoxten["Scraps"](GigiLovesYou);
            return true;
        end
    end
    return false;
end

local RodgerTheDetective = 0;
for AstroLoop = 1, 6 do
    RodgerTheDetective = RodgerTheDetective + 1;
    if GoobIsBest() then break end;
    task.wait(0.3 + (AstroLoop * 0.1));
end

if RodgerTheDetective < 3 then
    warn("Astro the best dud :> failed to load... Dandy wins this time");
end
