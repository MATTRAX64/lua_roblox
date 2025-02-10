local DataStoreService = game:GetService("DataStoreService")
local WinsLeaderboard = DataStoreService:GetOrderedDataStore("WinsLeaderboard")
local leaderboardlocation = game.Workspace.LeaderBoardwin
local function updateleaderboardwin()
	local success,errorMessage = pcall(function()
		local Data = WinsLeaderboard:GetSortedAsync(false,100)
		local WinsPage = Data:GetCurrentPage()
		for Rank,data in ipairs(WinsPage) do
			local username = game.Players:GetNameFromUserIdAsync(tonumber(data.key))
			local Name = username
			local Wins = data.value
			local isOnLeaderboard = false
			for i,v in pairs(leaderboardlocation.SurfaceGui.Holder:GetChildren()) do
				if v.Player.Text == Name then
					isOnLeaderboard = true
					break
				end
			end
			if Wins and isOnLeaderboard == false then
				local newLbFrame = game.ReplicatedStorage:WaitForChild("LeaderboardFrame"):Clone()
				newLbFrame.Player.Text = Name
				newLbFrame.Wins.Text = Wins
				newLbFrame.Rank.Text= "#"..Rank
				newLbFrame.Position = UDim2.new(0, 0, newLbFrame.Position.Y.Scale + (.04 * #leaderboardlocation.SurfaceGui.Holder:GetChildren()), 0)
				newLbFrame.Parent = leaderboardlocation.SurfaceGui.Holder
			end
		end
	end)
	if not success then
		print(errorMessage)
	end
end

while true do
	for _, Player in pairs(game.Players:GetPlayers()) do
		WinsLeaderboard:SetAsync(Player.UserId,Player.leaderstats.Time.Value)
	end
	for _, frame in pairs(leaderboardlocation.SurfaceGui.Holder:GetChildren()) do
		frame:Destroy()
	end
	updateleaderboardwin()
	print("update_win")
	wait(60)
end