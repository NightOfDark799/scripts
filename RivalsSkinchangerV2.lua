--[[
    skinchanger.lua v2 (beta)
        by luastun

    updates:
        the ANIMATION changes with skin you choose.
]]

local Config = {
    Skin = game:GetService("Players").LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"].Karambit, -- skin path
    Weapon = game:GetService("Players").LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons.Knife, -- weapon path

    AnimationTable = {
        ["rbxassetid://12613363718"] = "rbxassetid://18742841521",
        ["rbxassetid://12613190591"] = "rbxassetid://18742849437",
        ["rbxassetid://12886796453"] = "rbxassetid://18742894186",
        ["rbxassetid://12613329711"] = "rbxassetid://18742879471",
        ["rbxassetid://12613340305"] = "rbxassetid://18742860878",
        ["rbxassetid://12613350645"] = "rbxassetid://18742864831",
        ["rbxassetid://12613354440"] = "rbxassetid://18742868264"
    }
}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local Notify = function(i, v, x, y)
    if getgenv().AlreadyNotified then
        return
    end

    getgenv().AlreadyNotified = true

    StarterGui:SetCore("SendNotification", {
        Title = i,
        Text = v,
        Button1 = x,
        Callback = y()
    })
end

Notify(
    "Made By @Luastun",
    "Hello if you like my scripts please subscribe to my Youtube Channel! It would help me! :D",
    "Sure! (Copys my youtube channel)",
    function()
        -- // every executor got setclipboard atp xD
        local clipboard = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set) -- // ty inf yield <3
        if clipboard then
            clipboard("https://www.youtube.com/@luastun")
        end
    end
)

local LocalPlayer = game:GetService("Players").LocalPlayer
do
    local ViewModel
    local EquippedWeapon
    local FirstPerson = workspace.ViewModels.FirstPerson

    local Animator
    local LoadedTracks = {}

    local function ChangeWeaponSkin(skinpath, weaponpath)
        weaponpath:ClearAllChildren()

        for i, v in ipairs(skinpath:GetChildren()) do
            v:Clone().Parent = weaponpath
        end
    end

    ChangeWeaponSkin(Config.Skin, Config.Weapon)

    -- // initialize viewmodel

    repeat
        for _, vm in ipairs(FirstPerson:GetChildren()) do
            if vm.Name:match("^" .. LocalPlayer.Name .. "%s%-") then
                ViewModel = vm

                local Parts = string.split(ViewModel.Name, " - ")
                EquippedWeapon = Parts[2]
                break
            end
        end
        task.wait()
    until ViewModel

    Animator = ViewModel:WaitForChild("AnimationController"):WaitForChild("Animator")

    local function ChangeAnimationNameBasedOnSkin(WeaponToSkinTable)
        -- // throws an error if no
        repeat
            task.wait()
        until EquippedWeapon == tostring(Config.Weapon.Name)

        Animator.AnimationPlayed:Connect(function(track)
            local CurrentAnimation = track.Animation.AnimationId
            if WeaponToSkinTable[CurrentAnimation] then
                track:Stop()
                track:Destroy()
                
                local newAnimId = WeaponToSkinTable[CurrentAnimation]

                if not LoadedTracks[newAnimId] or not LoadedTracks[newAnimId].IsPlaying then
                    if LoadedTracks[newAnimId] then
                        LoadedTracks[newAnimId]:Stop()
                        LoadedTracks[newAnimId]:Destroy()
                    end
                    
                    local Animation = Instance.new("Animation")
                    Animation.AnimationId = newAnimId

                    local newTrack = Animator:LoadAnimation(Animation)
                    LoadedTracks[newAnimId] = newTrack
                    newTrack:Play()
                    
                    newTrack.Stopped:Connect(function()
                        if LoadedTracks[newAnimId] == newTrack then
                            LoadedTracks[newAnimId] = nil
                        end
                    end)
                else
                    LoadedTracks[newAnimId]:Play()
                end
            end
        end)
    end

    ChangeAnimationNameBasedOnSkin(Config.AnimationTable)
end
