-- Globals
-- remake by Geta#0983 pro handsome hahahahhahahha
-- credit? IDK NIGGA

-- Needed Locals
local Player = game.Players.LocalPlayer;
local Char = Player.Character;
local board_radius = 10;
local job_radius = 15;
local Mission = Player.PlayerGui.Mission.Frame;
local Dirt = game:GetService("Workspace").Dirt;
local Posters = game:GetService("Workspace").Posters;
local Delivery = game:GetService("Workspace").Delivery;
local jobboard = game:getService("Workspace").Corkboard.Board["Color this to paint the board"]

-- Clicky support [Sentinel already supports fireclickdetector]
if click_detector then -- Proto
    getgenv().fireclickdetector = function (...) click_detector(..., 0) end -- switch the function around
end
function floatniggatvkidolomghuhuhuhuhuhu()
    if not Player.Character.HumanoidRootPart:FindFirstChild("EffectsSY") then
        local BV = Instance.new("BodyVelocity")
        BV.Parent = Player.Character.HumanoidRootPart
        BV.Name = "EffectsSY"
        BV.MaxForce = Vector3.new(100000, 100000, 100000)
        BV.Velocity = Vector3.new(0, 0, 0)
    end
end
function destroyfloat()
    if Player.Character:FindFirstChild("HumanoidRootPart") then
        if Player.Character.HumanoidRootPart:FindFirstChild("EffectsSY") then
            Player.Character.HumanoidRootPart.EffectsSY:Destroy()
        end
     end
end
-- Anti Chair Technology
for i,v in pairs(game.Workspace:GetChildren()) do -- WE OUT TO FIND EM!
    if v.Name == "Model" then
        for i,z in pairs(v:GetDescendants()) do -- SEARCH FOR EM CHAIRS! REEEEEE
            if z:IsA("Seat") then -- GET OUTTA HERE!
                z:Destroy(); -- MUAHAHAHAH
            end
        end
    end
end

-- Teleport Bypass (Via Tween)
function TP(Object) -- Object = part teleporting to.
    local tweenService, tweenInfo = game:GetService("TweenService"), TweenInfo.new((game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.Position - Object.Position).Magnitude/_G.Speed, Enum.EasingStyle.Linear) -- change the number to a higher number if you get kicked for TP.
    local tween = tweenService:Create(game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(Object.Position + Vector3.new(0,0,0))})
    tween:Play()  
end

-- Name Hide (Credits to Rziln on V3RM)
function Hide_Name()
    pcall(function()
        local ign = Player.PlayerGui.HUD.Naming.Text
        for i,v in pairs(Char:GetChildren()) do
           if v:IsA("Accessory") or v:IsA("Pants") or v:IsA("Shirt") then
               print(v)
               v:Destroy()
           end
        end
        
        for i,v in pairs(Char:GetChildren()) do
           if v:IsA("Part") then
               warn(v)
               v.Color = Color3.new(0, 0, 0)
           end
        end
        Char[ign]:Destroy()
    end)
end

-- Auto Farm
function Farm()
    pcall(function() -- Avoid breaking the script
        _G.Farming = true; -- Started
        
        TP(jobboard); -- Teleport us to Board
        
       repeat wait() until (Char.HumanoidRootPart.Position - jobboard.Position).magnitude < board_radius -- If Player is around board..
            wait(2) -- Wait for the teleport tween to stop
            fireclickdetector(jobboard.ClickDetector); -- If we fire too soon we get kicked.
        
        wait(1); -- Just incase.. lel
        
        local Job = nil; -- Current Job
        
        -- Check if we got the job and what we're doing.
        if Mission.Visible == true then
            
            local JobDesc = Mission.Desc.Text
            
            -- FACKIN DISCUSTANG (google it)
            if string.match(JobDesc, "groceries") then
                Job = "Delivery";
            elseif string.match(JobDesc, "dirt") then
                Job = "Dirt";
            elseif string.match(JobDesc, "posters") then
                Job = "Posters" 
            end
            
            print("Current Job: "..Job);
            
            -- Dirt Job
            if Job == "Dirt" then
                local dirtchildren = Dirt:GetChildren()
                local dirtneeded = 1337;
                repeat
                for i, dirtchild in ipairs(dirtchildren) do
                    if Mission.Visible == true then -- Still jobing!
                        if dirtchild.Decal.Transparency == 0 then -- Not taken
                            Char.Humanoid.Jump = true;
                            TP(dirtchild);
                            repeat wait() until (Char.HumanoidRootPart.Position - dirtchild.Position).magnitude < job_radius -- Rub hands and wait for us to get close enough
                                fireclickdetector(dirtchild.ClickDetector);
                            wait(0.5)
                            dirtneeded = tonumber(string.match(Mission.Desc.Text, "%d+"));
                        end
                    else
                        _G.Farming = false;
                    end
                end
                wait();
                until dirtneeded <= 0 or Mission.Visible == false
                _G.Farming = false;
            end
            
            -- Posters Job
            if Job == "Posters" then
                local postchildren = Posters:GetChildren()
                local postneeded = 1337;
                repeat
                for i, postchild in ipairs(postchildren) do
                    if Mission.Visible == true then -- Still jobing!
                        if postchild.Decal.Transparency == 1 then -- Not taken
                            Char.Humanoid.Jump = true;
                            TP(postchild);
                            repeat wait() until (Char.HumanoidRootPart.Position - postchild.Position).magnitude < job_radius -- Rub hands and wait for us to get close enough
                                fireclickdetector(postchild.ClickDetector);
                            wait(0.5)
                            postneeded =  tonumber(string.match(Mission.Desc.Text, "%d+"));
                        end
                    else
                        _G.Farming = false;
                    end
                end
                wait();
                until postneeded <= 0 or Mission.Visible == false
                _G.Farming = false;
            end
            
            -- Delivery Job
            if Job == "Delivery" then
                local deliverychildren = Delivery:GetChildren()
                for i, delivechild in ipairs(deliverychildren) do
                    if delivechild.Name == "Part" then
                        wait(1);
                        Char.Humanoid.Jump = true;
                        TP(delivechild);
                        repeat wait() until (Char.HumanoidRootPart.Position - delivechild.Position).magnitude < job_radius or Mission.Visible == false
                    end
                end
                wait(1);
                _G.Farming = false;
            end
            
            _G.Farming = false;
        end
        
        _G.Farming = false;
    end)
end

Char.Humanoid.Changed:Connect(function()
    if Char.Humanoid.Health <= 0 then -- ded
        pcall(function() 
            _G.ScriptEnabled = false; -- Stop it from calling the Farm Function;
            _G.Farming = false; -- Stop it from calling the Farm Function;
            wait(10); -- Wait for respawn and ect.
            Hide_Name(); -- Rehide our name
            Char.Humanoid:Move(Vector3.new(0, 0, -5), true) -- Move a bit to avoid getting kicked.
            -- If there isn't a humanoid then rip.
            _G.ScriptEnabled = true;
        end)
end
end)

-- Call Hide_Name first execution.
Hide_Name();
if _G.ScriptEnabled == true then
    floatniggatvkidolomghuhuhuhuhuhu()
else
    destroyfloat()
end
while _G.ScriptEnabled do
    wait(1); -- No need to cause un-needed lag..
    if not _G.Farming and not Mission.Visible then
        Farm();
    end
end
