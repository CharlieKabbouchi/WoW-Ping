SLASH_PING1 = "/ping"


local function PingHandler(ping)
    if ping ~= '3' and ping ~= '4' then
        print("use 3 or 4");
    end
    if ping == '3' then
        print("Home Latency: "..select(ping, GetNetStats()).."ms.");
    end

    if ping == '4' then
        print("World Latency: "..select(ping, GetNetStats()).."ms.");
    end

end
SlashCmdList["PING"] = PingHandler;


local frame = CreateFrame("Frame", "Ping Frame", UIParent, "BasicFrameTemplateWithInset")
frame:SetSize(300, 100)
frame:SetPoint("CENTER", 0, 0)
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

local pingText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
pingText:SetText("Current Latency: 0ms")
pingText:SetPoint("CENTER", 0, 0)

local function UpdatePing()
    local latency = select(3, GetNetStats())
    pingText:SetText("Current Latency: " .. latency .. "ms")
end

local timer = 0
frame:SetScript("OnUpdate", function(self, elapsed)
    timer = timer + elapsed
    if timer >= 1 then
        UpdatePing()
        timer = 0
    end
end)

