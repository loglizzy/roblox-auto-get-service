-- loglizzy#3431

local services = {}
local oldgame = game

table.foreach(oldgame:GetChildren(), function(i,v)
    if type(v) == 'userdata' then
        local name
        for i,v in pairs(string.split(v.Name, ' ')) do
            name = (name or '')..v
        end
        
        table.insert(services, v)
        services[i].Name = name
    end
end)

local game = setmetatable({}, {
    __index = function(self, k, ...)
        if table.find(services, k) then
            return game:GetService(k)
        else
            return game:FindFirstChild(k)
        end
    end
})

game.RunService.RenderStepped:Connect(function()
    print'auto get service for shit exploits'
end)
