-- cat script fe by luastun
-- keybinds: H, P, R, E, F
-- note: might be buggy sorry will fix it later
local lp = game.Players.LocalPlayer
local hum = lp.Character.Humanoid
local function craeturn(id, name)
    getgenv()["global_animations_"..name] = Instance.new("Animation", game:GetService("ReplicatedStorage"))
    getgenv()["global_animations_"..name].Name = "67PLUS"..name..""..math.random(6, 7)
    getgenv()["global_animations_"..name].AnimationId = id

    return getgenv()["global_animations_"..name]
end

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

local function playsound(id)
    local sound = Instance.new("Sound", game:GetService("ReplicatedStorage"))
    sound.Name = "67GODMUSTARD"..math.random(6, 7)
    sound.Volume = 1
    sound.Looped = false
    sound.SoundId = "rbxassetid://"..id
    sound:Play()
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

local keys4emotes = {
    P = 95300714212921,
    E = 128001544587233,
    R = 75739251269771,
    F = 109734081202577
}

local keys4enabled = {
    P = false,
    E = false,
    R = false,
    F = false
}

local loadedTracks = {}

for key, id in pairs(keys4emotes) do
    loadedTracks[key] = hum:LoadAnimation(craeturn(anim2track(id), "Emote67God"..math.random(6, 7)))
    loadedTracks[key].Looped = true
end

game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if gpe then return end
    local keyName = input.KeyCode.Name

    if keys4emotes[keyName] then
        keys4enabled[keyName] = not keys4enabled[keyName]

        if tracks.walk.IsPlaying then
            tracks.walk:Stop()
        end

        if tracks.idle1.IsPlaying then
            tracks.idle1:Stop()
        end

        if keys4enabled[keyName] then
            for k, tr in pairs(loadedTracks) do
                if tr.IsPlaying then tr:Stop() end
            end
            loadedTracks[keyName]:Play()
        else
            if loadedTracks[keyName].IsPlaying then
                loadedTracks[keyName]:Stop()
            end
        end
    end

    if input.KeyCode == Enum.KeyCode.H then
        playsound(83454004588488)
    end
end)
