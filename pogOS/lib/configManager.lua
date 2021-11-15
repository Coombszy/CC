-- IMPORTS
----------------------------------------------------------------
local utils = require("lib/utils")
----------------------------------------------------------------

local configManager = {}

configManager.new = function()
    local self = {}

    -- VARIABLES
    local targetFile = ""
    local configDelimiter = ":"
    ----------------------------------------

    -- GETTERS and SETTERS
    function self.getTargetConfig() return targetFile end
    function self.setTargetConfig(configFile) targetFile = configFile end
    function self.getConfigDelimiter() return configDelimiter end
    function self.setConfigDelimiter(deli) configDelimiter = deli end
    ----------------------------------------

    -- FUNCTIONS
    ----------------------------------------

    -- does target file actually exist
    function self.present()
        local f = io.open(targetFile, "rb")
        if f then 
            f:close() 
            return true
        else
            return false
        end
    end

    -- gets the target config file and returns it as a dictionary
    function self.fetch()

        -- return nil if not present
        if not self.present() then return nil end

        local data = {}

        -- for each line in config
        for line in io.lines(targetFile) do

            split = utils.splitString(line, configDelimiter)

            local key = split[1]
            local value = split[2]

            -- if config value contains a delimiter, merge it into one value
            if table.getn(split) > 2 then

                value = ""
                for i = 2, table.getn(split) do

                    if (value == "") then
                        value = value..split[i]
                    else
                        value = value..configDelimiter..split[i]
                    end
                end

            end
            -- insert config line into data
            data[key] = value

        end
        return data
    end

    return self
end


return configManager.new()