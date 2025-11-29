-- say "follow" or "fol" to make me follow you! (case-insensitive) (SCRIPT BY LUASTUN)

local lp = game.Players.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")
local pf = game:GetService("PathfindingService")

_G.config = {
	msg1 = "follow",
	msg2 = "fol"
}

local target = nil
local running = false

local follow = function()
	if running or not target then return end
	running = true
	while target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") do
		local path = pf:CreatePath()
		path:ComputeAsync(hrp.Position, target.Character.HumanoidRootPart.Position)
		if path.Status == Enum.PathStatus.Success then
			for _, waypoint in ipairs(path:GetWaypoints()) do
                if waypoint.Action ==Enum.PathWaypointAction.Jump then
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end

				hum:MoveTo(waypoint.Position)
				hum.MoveToFinished:Wait()
			end
		end
		task.wait(0.1)
	end
	running = false
end

for i, v in ipairs(game.Players:GetChildren()) do
	v.Chatted:Connect(function(msg)
		local m = string.lower(msg)
		if m == _G.config.msg1 or m == _G.config.msg2 or string.find(m, _G.config.msg1) or string.find(m, _G.config.msg2) then
			target = v
			task.spawn(follow)
		end
	end)
end

game.Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(msg)
		local m = string.lower(msg)
		if m == _G.config.msg1 or m == _G.config.msg2 or string.find(m, _G.config.msg1) or string.find(m, _G.config.msg2) then
			target = player
			task.spawn(follow)
		end
	end)
end)
