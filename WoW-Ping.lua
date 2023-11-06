SLASH_PING1 = "/ping"


local function PingHandler(latency)
    if latency ~= '3' and latency ~= '4' then
        print("use 3 or 4");
    end
    if latency == '3' then
        print("Home Latency: " .. select(latency, GetNetStats()) .. "ms.");
    end

    if latency == '4' then
        print("World Latency: " .. select(latency, GetNetStats()) .. "ms.");
    end
end
SlashCmdList["PING"] = PingHandler;


local MAX_PING_HISTORY = 5
local pingHistory = {}
local pingText = {}


local frame = CreateFrame("Frame", "Ping Frame", UIParent, "BasicFrameTemplateWithInset")
frame:SetSize(200, 200)
frame:SetPoint("CENTER", 0, 0)
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

for i = 1, MAX_PING_HISTORY do
    pingText[i] = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    pingText[i]:SetText("")
    pingText[i]:SetPoint("CENTER", 0, -20 * (i - 1))
    
end


local function UpdatePing()
    local latency = select(3, GetNetStats())
    
    table.insert(pingHistory, 1, latency)

    if #pingHistory > MAX_PING_HISTORY then
        table.remove(pingHistory)
    end
    
    for i = 1, MAX_PING_HISTORY do
        if pingHistory[i] then
            pingText[i]:SetText("Home Latency: " .. pingHistory[i] .. "ms")
        else
            pingText[i]:SetText("")
        end
    end
end



local timer = 0
frame:SetScript("OnUpdate", function(self, elapsed)
    timer = timer + elapsed
    if timer >= 1 then
        UpdatePing()
        timer = 0
    end
end)