local textP = game.ServerStorage.TextP
local text = game.ServerStorage.Text
game.Players.PlayerAdded:Connect(function(plr)
	local lead = plr:WaitForChild("leaderstats")
	local Times = lead:WaitForChild("Time")
	plr.CharacterAdded:Connect(function(char)
		local hum =char:FindFirstChild("Humanoid")
		local cloneT = text:Clone()
		local cloneP = textP:Clone()
		wait(0.1)
		cloneT.Parent = char.UpperTorso
		cloneT.Part0 = cloneT.Parent
		cloneP.Parent = char
		cloneT.Part1 = char.TextP
		while true do
			wait(0.1)
			hum:SetAttribute("time",Times.Value)
			cloneP.BillboardGui.Timetext.Text = Times.Value
			if char:WaitForChild("Humanoid").Health == 0 then
				cloneP:Destroy()
				return
			end
		end
	end)
end)