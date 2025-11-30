-- rc cat script fe roblox
-- made by luastun

repeat task.wait() until game:IsLoaded()

-- config
local host="" -- enter your main account or anybody's name idk (USERNAME NOT DISPLAY)

-- commands (case-insensitive, means doesn't matter if its uppercase or lowercase):
-- sit! | makes your car sit and wait you forever
-- follow! | makes your car follow you back
-- ooia! | makes your car spin
-- stop! | makes car stop what hes doing

local lp = game.Players.LocalPlayer
local hum = lp.Character.Humanoid
local heartbeat = game:GetService("RunService").Heartbeat
local function craeturn(id, name)
    getgenv()["global_animations_"..name] = Instance.new("Animation", game:GetService("ReplicatedStorage"))
    getgenv()["global_animations_"..name].Name = "67PLUS"..name..""..math.random(6, 7)
    getgenv()["global_animations_"..name].AnimationId = id

    return getgenv()["global_animations_"..name]
end
host = game.Players[host]

local anim = {
    idle = "rbxassetid://86345507952689",
    walk = "rbxassetid://128650099590921"
}

-- credits to infinite yield
local function anim2track(asset_id)
    local objs = game:GetObjects(asset_id)
    for i = 1, #objs do
        if objs[i]:IsA("Animation") then
            return objs[i].AnimationId
        end
    end
    return asset_id
end

local tracks = {
    idle1 = hum:LoadAnimation(craeturn(anim2track(anim.idle), "Idle1")),
    walk  = hum:LoadAnimation(craeturn(anim2track(anim.walk), "Walk"))
}

tracks.idle1.Looped = true
tracks.walk.Looped = true

tracks.idle1:Play()

hum.Running:Connect(function(s)
	if s > 1 then
        if tracks.idle1.IsPlaying then tracks.idle1:Stop() end
        if not tracks.walk.IsPlaying then tracks.walk:Play() end
    else
        if tracks.walk.IsPlaying then tracks.walk:Stop() end
        if not tracks.idle1.IsPlaying then tracks.idle1:Play() end
    end
end)

hum.StateChanged:Connect(function(_, new)
    if new == Enum.HumanoidStateType.Landed then
        if tracks.walk.IsPlaying then return end
        if not tracks.idle1.IsPlaying then tracks.idle1:Play() end
    end
end)

heartbeat:Connect(function()
    task.wait(0.01) -- gotta make sure

    hum:MoveTo((host.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 6)).Position)
end)

ooiaanim = hum:LoadAnimation(craeturn(anim2track("rbxassetid://75739251269771"), "Ooia"))
host.Chatted:Connect(function(args)
    args = string.split(string.lower(args), " ")

    if args[1] == "sit!" or args[1] == "sit" then
        hum.RootPart.Anchored = true
    elseif args[1] == "follow!" or args[1] == "follow" then
        hum.RootPart.Anchored = false
    elseif args[1] == "ooia" or args[1] == "spin" then
        hum.RootPart.Anchored = false

        tracks.idle1:Stop()
        tracks.walk:Stop()

        ooiaanim:Play()
    elseif args[1] == "stop!" or args[1] == "stop" then
        ooiaanim:Stop()

        hum.RootPart.Anchored = false
    end
end)
