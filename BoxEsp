--ESP

local plr = game.Players.LocalPlayer
local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local camera = game.Workspace.CurrentCamera
local boxes = {}

local function newLine() --Create and return a line to use
   local v = Drawing.new("Line")
   v.Color = Color3.fromRGB(255,255,255)
   v.From = Vector2.new(1,1)
   v.To = Vector2.new(0,0)
   v.Visible = true
   v.Thickness = 2
   return v
end
local function newBox(player) --Creates Box
   local box = { --List that has the player object, and all 4 lines of a box
       ["Player"] = player, newLine(), newLine(), newLine(), newLine()
   }
   --Using an box[1] skips over ["Player"]
   table.insert(boxes,box) --So we can mention it later on
end

local function shapeBox(box)
   local player = box["Player"]
   -- The humanoidrootpart's cframe * cframe.new(-5,5,0) is top left, while * cframe.new(5,-5,0) is bottom right
   -- CFrame.p returns the position and using camera:WorldToViewportPoint(worldPos) returns the screen point
   local TL = camera:WorldToViewportPoint(player.Character.HumanoidRootPart.CFrame * CFrame.new(-3,3,0).p)
   local TR = camera:WorldToViewportPoint(player.Character.HumanoidRootPart.CFrame * CFrame.new(3,3,0).p)
   local BL = camera:WorldToViewportPoint(player.Character.HumanoidRootPart.CFrame * CFrame.new(-3,-3,0).p)
   local BR = camera:WorldToViewportPoint(player.Character.HumanoidRootPart.CFrame * CFrame.new(3,-3,0).p)
   -- TL >> BL | TL >> TR | TR >> BR | BL >> BR |
   -- Left line
   box[1].From = Vector2.new(TL.X, TL.Y) --TL is still a vector3 so you have to take the x and y
   box[1].To = Vector2.new(BL.X, BL.Y)
   -- Top line
   box[2].To = Vector2.new(TR.X, TR.Y)
   box[2].From = Vector2.new(TL.X, TL.Y)
   -- Right line
   box[3].To = Vector2.new(BR.X, BR.Y)
   box[3].From = Vector2.new(TR.X, TR.Y)
   -- Bottom line
   box[4].To = Vector2.new(BR.X, BR.Y)
   box[4].From = Vector2.new(BL.X, BL.Y)
   
end
local function visBox(box, vis)
   for i,v in ipairs(box) do v.Visible = vis end -- Skips over ["Player"] with ipairs
end

local function hasBox(player)
   for i, v in ipairs(boxes) do
       if v["Player"] == player then return true end
   end
end

RS.RenderStepped:connect(function() -- On my first box esp I was told "- Make sure you put the ESP in render stepped connection or it will look like a 1980's computer is running it" - CornCatCornDog
   --Give boxes to players than need it
   for i, player in ipairs(Players:GetPlayers()) do
       if not hasBox(player) and player ~= plr then --Make sure they don't already have a box and we aren't boxing ourselves
           newBox(player)
       end
   end
   --Manage created boxes
   for i, v in ipairs(boxes) do -- You could use next, I have a habit of ipairs
       local player = v["Player"] --Get the player from the box list
       if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then --Without the player being loaded and having a HumanoidRootPart then the esp can't work
           shapeBox(v)
           local _, withinScreenBounds = camera:WorldToScreenPoint(player.Character.HumanoidRootPart.Position) --Withinscreenbounds will be if the player is on our screen
           if withinScreenBounds then
               visBox(v,true)
               
           else
               warn(withinScreenBounds)
               visBox(v,false)    
           end
       else
           --Player isn't loaded, so the box shouldn't be visible
           visBox(v, false)
       end
   end
end)
