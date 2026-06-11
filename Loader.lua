
   -- Astro the best dud :> | Dandy can't make this | Boxten and Cosmo forever :P
   -- Protected by Meh Astro's Dreamworld get out of here!


local url = "https://raw.githubusercontent.com/Midnight-Star-blip/Astro-s-Dreamworld/refs/heads/main/AstroMain.lua"
local success, code = pcall(game.HttpGet, game, url)
if success then
    loadstring(code)()
else
    warn("Failed to load Astro Script")
end
