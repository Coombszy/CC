-- Play filename through speaker
--
-- Version 1.0
-- Initial Release
------------------------------------------------------------
local dfpwm = require("cc.audio.dfpwm")
local speaker = peripheral.find("speaker") or error("No speaker attached", 0)

local filename, volume = ...
if filename == nil then
    print("Did not provide filename!")
    return
end
local target = "./"..filename..".dfpwm"

if not fs.exists(target) then
    print("Could not find: ./".. filename .. ".dfpwm")
    return
end

if volume == nil then volume = 100 end
local decoder = dfpwm.make_decoder()
for chunk in io.lines(target, 16 * 1024) do
    local buffer = decoder(chunk)

    while not speaker.playAudio(buffer, volume) do
        os.pullEvent("speaker_audio_empty")
    end
end

speaker.playAudio("./"..filename..".dfpwm", volume)

