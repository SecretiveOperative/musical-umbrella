_G.HubData = loadstring(game:HttpGet("https://raw.githubusercontent.com/SecretiveOperative/musical-umbrella/main/HubInformation"))()
local Name = game.Players.LocalPlayer.Name
local Key = _G.HubData[1][1][1][1][1][1][1][1][1].Key
local req = request or (http and http.request) or (syn and syn.request) or false
local DebugMode = true

_G.Login = false

-- MAIN

--// OrionLib

print("[LIB] - Joining Discord Server now!")

if DebugMode == false then
syn.request(
    {
        Url = "http://127.0.0.1:6463/rpc?v=1",
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json",
            ["origin"] = "https://discord.com"
        },
        Body = game:GetService("HttpService"):JSONEncode(
            {
                ["args"] = {
                    ["code"] = "nhS6RDRFYz"
                },
                ["cmd"] = "INVITE_BROWSER",
                ["nonce"] = "."
            }
        )
    }
)
end

print("[LIB] - Library has started to load.")

local OrionLib = loadstring(game:HttpGet(("https://raw.githubusercontent.com/shlexware/Orion/main/source")))()
local Window =
    OrionLib:MakeWindow(
    {
        Name = "Vectorise X",
        HidePremium = true,
        SaveConfig = false,
        Icon = "http://www.roblox.com/asset/?id=6034687957",
        ConfigFolder = "OrionTest",
        IntroEnabled = false
    }
)

--// Login

local InsertedKey = "N/A"
local function Login(InKey)
    if _G.Login then
        return
    end

    if InKey == Key then
        _G.Login = true

        OrionLib:MakeNotification(
            {
                Name = "Correct Key",
                Content = "Please wait a moment...",
                Image = "rbxassetid://4483345998",
                Time = 5
            }
        )

        wait(5)

        _G.HubData[1][1][1][1][1][1][1][1][1].KeyInserted = InKey
        if Name == "celestialqi" then
            _G.HubData[1][1][1][1][1][1][1][1][1].Authorization = {
                Number = 100;
                Name = "Owner"
            }
        end

        local LS = nil
        task.spawn(function()
            LS = game:HttpGet("https://raw.githubusercontent.com/SixZens/SolScript/main/" .. tostring(game.PlaceId) .. ".lua")
        end)
        if LS then

            loadstring(LS)()

        else
            OrionLib:MakeNotification(
            {
                Name = "Uh oh!",
                Content = "It looks like we don't support this game.",
                Image = "rbxassetid://4483345998",
                Time = 10
            }
        )

        end

    else
        OrionLib:MakeNotification(
            {
                Name = "Incorrect Key",
                Content = "Are you sure you have the right key?",
                Image = "rbxassetid://4483345998",
                Time = 5
            }
        )
    end
end

local LoginTab =
    Window:MakeTab(
    {
        Name = "Login",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    }
)
LoginTab:AddTextbox(
    {
        Name = "Key",
        Default = "",
        TextDisappear = false,
        Callback = function(Value)
            InsertedKey = Value
        end
    }
)
LoginTab:AddButton(
    {
        Name = "Login",
        Callback = function()
            Login(InsertedKey)
        end
    }
)
LoginTab:AddButton(
    {
        Name = "Copy Discord Invite",
        Callback = function()
            setclipboard("https://discord.gg/nhS6RDRFYz")
        end
    }
)

--// Other

local OtherTab =
    Window:MakeTab(
    {
        Name = "Other",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    }
)

OtherTab:AddButton(
    {
        Name = "Rejoin",
        Callback = function()
            local Players = game.Players

            if #Players:GetPlayers() <= 1 then
                Players.LocalPlayer:Kick("\nRejoining...")
                wait()
                game:GetService("TeleportService"):Teleport(game.PlaceId, Players.LocalPlayer)
            else
                game:GetService("TeleportService"):TeleportToPlaceInstance(
                    game.PlaceId,
                    game.JobId,
                    Players.LocalPlayer
                )
            end
        end
    }
)

OrionLib:Init()
