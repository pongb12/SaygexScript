local Games = loadstring(game:HttpGet("https://raw.githubusercontent.com/pongb12/SaygexScript/refs/heads/main/Gamelist.lua"))()

local URL = Games[game.PlaceId]

if URL then
  loadstring(game:HttpGet(URL))()
end
