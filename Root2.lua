local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Fallen King's OP Murder Mystery 2 Script",
   LoadingTitle = "Made by @fallenkingchannel3627 on Youtube!",
   LoadingSubtitle = "by Fallen King",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = MurderMysteryFre, -- Create a custom folder for your hub/game
      FileName = "FreScriptsScriptblox"
   }
})

local Tab = Window:CreateTab("Main", 4483362458) -- Title, Image
local Section = Tab:CreateSection("Player Section")

local TextBox = Tab:CreateInput({
    Name = "Player Name",
    PlaceholderText = "Enter player name...",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        -- The function that takes place when the input is changed
        playerNameTextbox = Text
    end,
})

local Button = Tab:CreateButton({
    Name = "Force Trade",
    Callback = function()
        if playerNameTextbox and playerNameTextbox ~= "" then
            local player = game.Players:FindFirstChild(playerNameTextbox)

            if player then
                local args = {
                    [1] = player
                }

                game:GetService("ReplicatedStorage"):WaitForChild("Trade"):WaitForChild("SendRequest"):InvokeServer(unpack(args))

                game:GetService("ReplicatedStorage"):WaitForChild("Trade"):WaitForChild("AcceptRequest"):FireServer()

                Rayfield:Notify({
                    Title = "Trade System",
                    Content = "Force Traded Player: " .. playerNameTextbox,
                    Duration = 5,
                    Image = 4483362458,
                    Actions = {
                        Ignore = {
                            Name = "Okay!",
                            Callback = function()
                            end
                        },
                    },
                })
            else
                Rayfield:Notify({
                    Title = "Trade System",
                    Content = "Player not found.",
                    Duration = 5,
                    Image = 4483362458,
                    Actions = {
                        Ignore = {
                            Name = "Okay!",
                            Callback = function()
                            end
                        },
                    },
                })
            end
        else
            Rayfield:Notify({
                Title = "Trade System",
                Content = "Please enter a valid player name.",
                Duration = 5,
                Image = 4483362458,
                Actions = {
                    Ignore = {
                        Name = "Okay!",
                        Callback = function()
                        end
                    },
                },
            })
        end
    end,
})

local Section = Tab:CreateSection("Misc")

local Button = Tab:CreateButton({
   Name = "Chat Expose Roles",
   Callback = function()
   local allPlayers = game.Players:GetPlayers()

for _, player in pairs(allPlayers) do
    local backpack = player:FindFirstChild("Backpack")
    
    if backpack then
        if backpack:FindFirstChild("Knife") then
            local args = {
                [1] = player.Name .. ": Has The Knife",
                [2] = "normalchat"
            }

            game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(unpack(args))
        end
        
        if backpack:FindFirstChild("Gun") then
            local args = {
                [1] = player.Name .. ": Has The Gun",
                [2] = "normalchat"
            }

            game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(unpack(args))
        end
    end
end
   end,
})

local Label = Tab:CreateLabel("Gun Not Dropped") -- Use "Label" instead of "GunLabel"
coroutine.wrap(function()
    local gunDropped = false
    while wait(1) do
        local gunExists = Workspace:FindFirstChild("GunDrop")
        
        if gunExists then
            Label:Set("Gun Dropped") -- Update to use "Label" instead of "GunLabel"
            
            -- Only send notification if the gun has been dropped since last check
            if not gunDropped then
                gunDropped = true
                Rayfield:Notify({
                    Title = "Gun Status",
                    Content = "Gun Dropped",
                    Duration = 6.5,
                    Image = 5578470911,
                    Actions = {
                        Ignore = {
                            Name = "Okay!",
                            Callback = function()
                                print("The user tapped Okay!")
                            end
                        },
                    },
                })
            end
        else
            Label:Set("Gun Not Dropped") -- Update to use "Label" instead of "GunLabel"
            gunDropped = false
        end
    end
end)()

local MurdererLabel = Tab:CreateLabel("Murderer is: Unknown")
local SheriffLabel = Tab:CreateLabel("Sheriff is: Unknown")

-- Function to check and update the roles based on tools in players' backpacks
local function updateRolesInfo()
    while true do
        local players = game:GetService("Players"):GetPlayers()
        local murderer, sheriff = "Unknown", "Unknown"

        for _, player in ipairs(players) do
            if player.Character then
                local backpack = player.Backpack
                if backpack then
                    for _, tool in ipairs(backpack:GetChildren()) do
                        if tool:IsA("Tool") then
                            if tool.Name == "Knife" then
                                murderer = player.Name
                            elseif tool.Name == "Gun" then
                                sheriff = player.Name
                            end
                        end
                    end
                end
            end
        end

        MurdererLabel:Set("Murderer is: " .. murderer)
        SheriffLabel:Set("Sheriff is: " .. sheriff)

        wait(1)
    end
end

-- Start updating the Murderer and Sheriff information
coroutine.wrap(updateRolesInfo)()

local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "ESP Holder"
ESPFolder.Parent = game.CoreGui

local function AddBillboard(player)
    local Billboard = Instance.new("BillboardGui")
    Billboard.Name = player.Name .. "Billboard"
    Billboard.AlwaysOnTop = true
    Billboard.Size = UDim2.new(0, 200, 0, 50)
    Billboard.ExtentsOffset = Vector3.new(0, 3, 0)
    Billboard.Enabled = false
    Billboard.Parent = ESPFolder

    local TextLabel = Instance.new("TextLabel")
    TextLabel.TextSize = 20
    TextLabel.Text = player.Name
    TextLabel.Font = Enum.Font.FredokaOne
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.TextStrokeTransparency = 0
    TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    TextLabel.Parent = Billboard

    repeat
        wait()
        pcall(function()
            Billboard.Adornee = player.Character.Head
            if player.Character:FindFirstChild("Knife") or player.Backpack:FindFirstChild("Knife") then
                TextLabel.TextColor3 = Color3.new(1, 0, 0)
                if getgenv().MurderEsp then
                    Billboard.Enabled = true
                end
            elseif player.Character:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Gun") then
                TextLabel.TextColor3 = Color3.new(0, 0, 1)
                if getgenv().SheriffEsp then
                    Billboard.Enabled = true
                end
            else
                TextLabel.TextColor3 = Color3.new(0, 1, 0)
                if getgenv().AllEsp then
                    Billboard.Enabled = true
                end
            end
        end)
    until not player.Parent
end

for _, player in pairs(game.Players:GetPlayers()) do
    if player ~= game.Players.LocalPlayer then
        coroutine.wrap(AddBillboard)(player)
    end
end

game.Players.PlayerAdded:Connect(function(player)
    if player ~= game.Players.LocalPlayer then
        coroutine.wrap(AddBillboard)(player)
    end
end)

game.Players.PlayerRemoving:Connect(function(player)
    local billboard = ESPFolder:FindFirstChild(player.Name .. "Billboard")
    if billboard then
        billboard:Destroy()
    end
end)

local ToggleAllESP = Tab:CreateToggle({
    Name = "Every Player ESP",
    CurrentValue = false,
    Flag = "AllESP",
    Callback = function(state)
        getgenv().AllEsp = state
        for _, billboard in ipairs(ESPFolder:GetChildren()) do
            if billboard:IsA("BillboardGui") then
                local playerName = billboard.Name:sub(1, -10)
                local player = game.Players:FindFirstChild(playerName)
                if player and player.Character then
                    local hasKnife = player.Character:FindFirstChild("Knife") or player.Backpack:FindFirstChild("Knife")
                    local hasGun = player.Character:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Gun")
                    if not (hasKnife or hasGun) then
                        billboard.Enabled = state
                    end
                end
            end
        end
    end,
})



local ToggleMurderESP = Tab:CreateToggle({
    Name = "Murder ESP",
    CurrentValue = false,
    Flag = "MurderESP",
    Callback = function(state)
        getgenv().MurderEsp = state
        for _, billboard in ipairs(ESPFolder:GetChildren()) do
            if billboard:IsA("BillboardGui") then
                local playerName = billboard.Name:sub(1, -10)
                local player = game.Players:FindFirstChild(playerName)
                if player and (player.Character:FindFirstChild("Knife") or player.Backpack:FindFirstChild("Knife")) then
                    billboard.Enabled = state
                end
            end
        end
    end,
})

local ToggleSheriffESP = Tab:CreateToggle({
    Name = "Sherif ESP",
    CurrentValue = false,
    Flag = "SheriffESP",
    Callback = function(state)
        getgenv().SheriffEsp = state
        for _, billboard in ipairs(ESPFolder:GetChildren()) do
            if billboard:IsA("BillboardGui") then
                local playerName = billboard.Name:sub(1, -10)
                local player = game.Players:FindFirstChild(playerName)
                if player and (player.Character:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Gun")) then
                    billboard.Enabled = state
                end
            end
        end
    end,
})

local Tab = Window:CreateTab("Credits", 4483362458)
local Section = Tab:CreateSection("Discord Server invite Link")

local Button = Tab:CreateButton({
    Name = "Discord Server Invite Link",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/minecraftminegun/discord-invite-link-string-setup/main/string%20setup'))()
      end
})
