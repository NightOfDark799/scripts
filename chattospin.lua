-- SCRIPT BY LUASTUN!
-- say "spin" or "s", "slow" or "w" to make me spin slower or faster! (case-insensitive)

_G.config = {
	msg1 = "spin",
	msg2 = "s",

	msg3 = "slow",
	msg4 = "w",
	increment = 1
}

local function spin(val)
	for i, v in pairs(game.Players.LocalPlayer.Character.HumanoidRootPart:GetChildren()) do
		if v.Name == "Spinning"	then v:Destroy() end
	end

	local Spin = Instance.new("BodyAngularVelocity")
	Spin.Name = "Spinning"
	Spin.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
	Spin.MaxTorque = Vector3.new(0, math.huge, 0)
	Spin.AngularVelocity = Vector3.new(0,val,0)	
end

local number = 1
spin(number)
for i, v in ipairs(game.Players:GetChildren()) do
	v.Chatted:Connect(function(msg)
		if string.lower(msg) == _G.config.msg1 or string.lower(msg) == _G.config.msg2 or string.find(string.lower(msg), _G.config.msg1) then
			number = number + _G.config.increment
			spin(number)
		elseif string.lower(msg) == _G.config.msg3 or string.lower(msg) == _G.config.msg4 then
			number = number - _G.config.increment
			spin(number)
		end
	end)
end

game.Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(msg)
		if string.lower(msg) == _G.config.msg1 or string.lower(msg) == _G.config.msg2 or string.find(string.lower(msg), _G.config.msg1) then
			number = number + _G.config.increment
			spin(number)
		elseif string.lower(msg) == _G.config.msg3 or string.lower(msg) == _G.config.msg4 then
			number = number - _G.config.increment
			spin(number)
		end
	end)
end)
