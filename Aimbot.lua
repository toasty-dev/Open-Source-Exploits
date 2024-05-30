local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Holding = false

_G.aiming = {
	TeamCheck = false
	AimbotEnabled = true
	AimPart = "Head"
	Sensitivity = 0.05
	CircleSides = 24
	CircleColor = Color3.fromRGB(255,255,255)
	CircleTransparency = 0.7
	CircleRadius = 80
	CircleFilled = false
	CircleVisible = true
	CircleThickness = 0
}

local FCircle = Drawing.new("Circle")
FCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
FCircle.Radius = _G.aiming.CircleRadius
FCircle.Filled = _G.aiming.CircleFilled
FCircle.Color = _G.aiming.CircleColor
FCircle.Visible = _G.aiming.CircleVisible
FCircle.Transparency = _G.aiming.CircleTransparency
FCircle.NumSides = _G.aiming.CircleSides
FCircle.Thickness = _G.aiming.CircleThickness

local function GetClosestPlayer()
    local MaximumDistance = _G.CircleRadius
    local Target = nil

    for _, v in next, Players:GetPlayers() do
        if v.Name ~= LocalPlayer.Name then
            if _G.aimbot.TeamCheck == true then
                if v.Team ~= LocalPlayer.Team then
                    if v.Character ~= nil then
                        if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                            if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                                local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                                local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude

                                if VectorDistance < MaximumDistance then
                                    Target = v
                                end
                            end
                        end
                    end
                end
            else
                 if v.Character ~= nil then
                    if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                        if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                            local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                            local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
            
                            if VectorDistance < MaximumDistance then
                            Target = v
                            end
                        end
                    end
                end
            end
        end
    end

    return Target
end

UserInputService.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        Holding = true
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        Holding = false
    end
end)

RunService.RenderStepped:Connect(function()
    FCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
	FCircle.Radius = _G.aiming.CircleRadius
	FCircle.Filled = _G.aiming.CircleFilled
	FCircle.Color = _G.aiming.CircleColor
	FCircle.Visible = _G.aiming.CircleVisible
	FCircle.Transparency = _G.aiming.CircleTransparency
	FCircle.NumSides = _G.aiming.CircleSides
	FCircle.Thickness = _G.aiming.CircleThickness
    if Holding == true and _G.aiming.AimbotEnabled == true then
        TweenService:Create(Camera, TweenInfo.new(_G.aiming.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, GetClosestPlayer().Character[_G.aiming.AimPart].Position)}):Play()
    end
end)
