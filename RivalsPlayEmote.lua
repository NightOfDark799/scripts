--[[
    play any emotes in rivals without buying
        by luastun.

    quicknotes:
        the anims & sounds cancell when u move.

        ima make the props soon, so just wait please gang :pray:
]]

local Config = {
    Animation = "Smile", -- // Change this with any emote name from KnownAnimations (case-sensitive) for tutorial: https://youtu.be/YMuS87FbZEs

    KnownAnimations = {
        ["Agree"] = {
            ID = 85429197687197,
            SOUNDS = {
                78663178795648
            },

            LOOPSOUNDS = false
        },

        ["Coo Coo"] = {
            ID = 125921589993721,
            SOUNDS = {
                134218301690577,
                71288358864209
            },

            LOOPSOUNDS = false
        },

        ["Cream Cheese Honey"] = {
            ID = 71250144811352,
            SOUNDS = {
                120250934207816
            },

            LOOPSOUNDS = true
        },

        ["Criss Cross"] = {
            ID = 95986480266032,
            SOUNDS = {
                120250934207816
            },

            LOOPSOUNDS = true
        },

        ["Denial"] = {
            ID = 81555757574094,
            SOUNDS = {
                75485128790168,
                13158735106,
                13158735106,
                13158735106
            },

            LOOPSOUNDS = false
        },

        ["Facepalm"] = {
            ID = 103862270973168,
            SOUNDS = {
                88377109323880,
                13160326139
            },

            LOOPSOUNDS = false
        },

        ["Kneel"] = {
            ID = 84754316528381,
            SOUNDS = {
                134140996504107
            },

            LOOPSOUNDS = false
        },

        ["Off of You"] = {
            ID = 105875604689697,
            SOUNDS = {
                137662451042014
            },

            LOOPSOUNDS = true
        },

        ["ROFL"] = {
            ID = 73786487009083,
            SOUNDS = {
                122605533507524,
                126514820442685
            },

            LOOPSOUNDS = false
        },

        ["Round & Round"] = {
            ID = 104273989039620,
            SOUNDS = {
                129000171133220
            },

            LOOPSOUNDS = true
        },

        ["Shivering"] = {
            ID = 102458102253574,
            SOUNDS = {
                121062822157622
            },

            LOOPSOUNDS = true
        },

        ["Shoulder Brush"] = {
            ID = 119282539520778,
            SOUNDS = {
                79768694812211,
                79768694812211,
                79768694812211,
                79768694812211
            },

            LOOPSOUNDS = false
        },

        ["Side To Side"] = {
            ID = 77255514751814,
            SOUNDS = {
                88051081362116
            },

            LOOPSOUNDS = true
        },

        ["Smile"] = {
            ID = 98020061651338,
            SOUNDS = {
                98020061651338,
                100664444144490
            },

            LOOPSOUNDS = true
        },

        ["Snow Angels"] = {
            ID = 93924392025280,
            SOUNDS = {},

            LOOPSOUNDS = false
        },

        ["Superhero"] = {
            ID = 115000869501227,
            SOUNDS = {
                80133530921906,
                98970356172671
            },

            LOOPSOUNDS = true
        },

        ["Take The L"] = {
            ID = 104639476409829,
            SOUNDS = {
                116605809326430
            },

            LOOPSOUNDS = true
        },

        ["Think"] = {
            ID = 133733650708343,
            SOUNDS = {
                13160326139,
                13160326139
            },

            LOOPSOUNDS = false
        },

        ["Vegetable"] = {
            ID = 95292230449040,
            SOUNDS = {
                120797927157164
            },

            LOOPSOUNDS = true
        }
    }
}

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
    local function PlayAnimation(id)
        local Folder = Instance.new("Folder")
        Folder.Name = "Animations"
        Folder.Parent = LocalPlayer

        local Animation = Instance.new("Animation")
        Animation.AnimationId = id
        Animation.Parent = Folder

        local LoadedAnimation = LocalPlayer.Character.Humanoid:LoadAnimation(Animation)

        LoadedAnimation:Play()
        LocalPlayer.Character.Humanoid.Running:Connect(function()
            LoadedAnimation:Stop()
        end)
    end

    local function PlaySound(id, looped)
        local Folder = Instance.new("Folder")
        Folder.Name = "Sounds"
        Folder.Parent = LocalPlayer

        local Sound = Instance.new("Sound")
        Sound.SoundId = id
        Sound.Parent = Folder
        Sound.Looped = looped
        Sound.Volume = 1
        Sound:Play()

        LocalPlayer.Character.Humanoid.Running:Connect(function()
            Sound:Stop()
        end)
    end

    local CurrentAnimation = Config.KnownAnimations[Config.Animation]
    PlayAnimation("rbxassetid://"..tostring(CurrentAnimation.ID))
    for i, v in ipairs(CurrentAnimation.SOUNDS) do
        PlaySound("rbxassetid://"..tostring(v), CurrentAnimation.LOOPSOUNDS)
        wait(0.5)
    end
end
