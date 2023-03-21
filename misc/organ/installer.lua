REPO_ROOT = "https://raw.githubusercontent.com/Coombszy/CC/master/"

local targets = {"misc/organ/startup.lua", "misc/organ/pipe.lua"}

print("Installing Organ Code...")

for i = 1, table.getn(targets) do

    print("")
    print("Downloading file:"..targets[i])
    shell.run("wget "..REPO_ROOT.."/"..targets[i])
end

print("Complete! rebooting")
sleep(1)
shell.run("reboot")