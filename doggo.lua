-- dog script
-- made by luastun!!

local lp = game.Players.LocalPlayer
local hum = lp.Character.Humanoid
local function craeturn(id, name)
    getgenv()["global_animations_"..name] = Instance.new("Animation", game:GetService("ReplicatedStorage"))
    getgenv()["global_animations_"..name].Name = "67PLUS"..name..""..math.random(6, 7)
    getgenv()["global_animations_"..name].AnimationId = id

    return getgenv()["global_animations_"..name]
end

local anim = {
    idle = "rbxassetid://73763568356686",
    walk = "rbxassetid://104330520761782"
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
