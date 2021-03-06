local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Util = require(ReplicatedStorage.Util)

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local character = player.Character or player.CharacterAdded:wait()
local humanoid = character:WaitForChild("Humanoid");

local torso = Util:GetTorsoFromPlayer(player)


-- https://devforum.roblox.com/t/how-to-boost-a-player-backwards/831473
torso.Touched:Connect(function(hit)
	if not hit:IsDescendantOf(character) then
		print(player.Name .. " bump " .. hit.Name)
		local boost = Instance.new("BodyVelocity", torso)

		-- Get the vector pointing away from the hit part
		local vector = -(CFrame.new(torso.Position, hit.Position).LookVector)
		local magnitude = 25
		local fling = vector * magnitude
		print(fling)
    boost.MaxForce = Vector3.new(1e8,1e8,1e8)
		boost.Velocity = fling
		Util:RealWait(.3)
		boost:Destroy()
	end
end)
