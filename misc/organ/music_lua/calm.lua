local S_CHANNEL = 6000
local modem = peripheral.find("modem") or error("No modem attached", 0)
modem.transmit(6002.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6011.0, 0, 1.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6011.0, 0, 1.0 .. "/" .. "false")
sleep(1.428571)
modem.transmit(6002.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6009.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6002.0, 0, 1.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6002.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 1.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6006.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6009.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 1.0 .. "/" .. "true")
modem.transmit(6001.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6001.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 1.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6004.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6008.0, 0, 2.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6004.0, 0, 2.0 .. "/" .. "false")
sleep(1.428571)
modem.transmit(6008.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6006.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6011.0, 0, 1.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6011.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 2.0 .. "/" .. "false")
sleep(1.428571)
modem.transmit(6006.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 1.0 .. "/" .. "true")
modem.transmit(6001.0, 0, 3.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6009.0, 0, 2.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6009.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 1.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6001.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6008.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 1.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6001.0, 0, 2.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6004.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6001.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 1.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6008.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6011.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6008.0, 0, 2.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6004.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6008.0, 0, 2.0 .. "/" .. "false")
sleep(1.428571)
modem.transmit(6011.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6006.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6011.0, 0, 1.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6011.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 2.0 .. "/" .. "false")
sleep(1.428571)
modem.transmit(6006.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 1.0 .. "/" .. "true")
modem.transmit(6001.0, 0, 3.0 .. "/" .. "true")
modem.transmit(6009.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6009.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 1.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6001.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6008.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 1.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6001.0, 0, 2.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6004.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6001.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 1.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6008.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6011.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6008.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6004.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6008.0, 0, 2.0 .. "/" .. "false")
sleep(1.428571)
modem.transmit(6011.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6011.0, 0, 1.0 .. "/" .. "true")
modem.transmit(6002.0, 0, 2.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6011.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 3.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6004.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 3.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6006.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 1.0 .. "/" .. "true")
modem.transmit(6001.0, 0, 3.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6009.0, 0, 2.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6002.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 1.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6009.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6001.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6009.0, 0, 2.0 .. "/" .. "true")
sleep(0.35714275)
modem.transmit(6009.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6011.0, 0, 2.0 .. "/" .. "true")
sleep(0.35714275)
modem.transmit(6011.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6008.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 1.0 .. "/" .. "true")
modem.transmit(6001.0, 0, 2.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6001.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 1.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6004.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6008.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6001.0, 0, 3.0 .. "/" .. "true")
sleep(0.35714275)
modem.transmit(6001.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 3.0 .. "/" .. "true")
sleep(0.35714275)
modem.transmit(6002.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6011.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6008.0, 0, 2.0 .. "/" .. "true")
sleep(2.857142)
modem.transmit(6011.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6008.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6002.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6011.0, 0, 1.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6011.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6009.0, 0, 3.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6009.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 3.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6006.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 3.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6004.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6001.0, 0, 3.0 .. "/" .. "true")
modem.transmit(6009.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6002.0, 0, 1.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6002.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 1.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6004.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6009.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6001.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6009.0, 0, 2.0 .. "/" .. "true")
sleep(0.35714275)
modem.transmit(6009.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6011.0, 0, 2.0 .. "/" .. "true")
sleep(0.35714275)
modem.transmit(6011.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6008.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 1.0 .. "/" .. "true")
modem.transmit(6001.0, 0, 2.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6001.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 1.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6008.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 3.0 .. "/" .. "true")
sleep(0.35714275)
modem.transmit(6004.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6001.0, 0, 3.0 .. "/" .. "true")
sleep(0.35714275)
modem.transmit(6002.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6001.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6011.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6008.0, 0, 2.0 .. "/" .. "true")
sleep(2.857142)
modem.transmit(6008.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6011.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6011.0, 0, 1.0 .. "/" .. "true")
modem.transmit(6002.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6006.0, 0, 2.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6011.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 3.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6004.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 3.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6006.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6009.0, 0, 3.0 .. "/" .. "true")
modem.transmit(6009.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6002.0, 0, 1.0 .. "/" .. "true")
modem.transmit(6001.0, 0, 3.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6009.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6001.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 1.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6006.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6009.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6001.0, 0, 4.0 .. "/" .. "true")
modem.transmit(6009.0, 0, 2.0 .. "/" .. "true")
sleep(0.35714275)
modem.transmit(6009.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6001.0, 0, 4.0 .. "/" .. "false")
modem.transmit(6011.0, 0, 3.0 .. "/" .. "true")
modem.transmit(6011.0, 0, 2.0 .. "/" .. "true")
sleep(0.35714275)
modem.transmit(6011.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6011.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6009.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6001.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 1.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6008.0, 0, 3.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6001.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 1.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6009.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6008.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6009.0, 0, 3.0 .. "/" .. "true")
modem.transmit(6001.0, 0, 3.0 .. "/" .. "true")
sleep(0.35714275)
modem.transmit(6001.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6009.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6008.0, 0, 3.0 .. "/" .. "true")
sleep(0.35714275)
modem.transmit(6002.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6008.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 3.0 .. "/" .. "true")
modem.transmit(6011.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6008.0, 0, 2.0 .. "/" .. "true")
sleep(2.857142)
modem.transmit(6004.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6008.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6011.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6006.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6011.0, 0, 1.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6006.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6011.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 3.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6006.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 3.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6004.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6009.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6001.0, 0, 3.0 .. "/" .. "true")
modem.transmit(6002.0, 0, 1.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6002.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 1.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6001.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6009.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6009.0, 0, 2.0 .. "/" .. "true")
sleep(0.35714275)
modem.transmit(6009.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6011.0, 0, 2.0 .. "/" .. "true")
sleep(0.35714275)
modem.transmit(6011.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6008.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6001.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 1.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6001.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 1.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6004.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6008.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6001.0, 0, 3.0 .. "/" .. "true")
sleep(0.35714275)
modem.transmit(6001.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 3.0 .. "/" .. "true")
sleep(0.35714275)
modem.transmit(6002.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6008.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6011.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "true")
sleep(2.857142)
modem.transmit(6004.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6011.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6008.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6002.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6011.0, 0, 1.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6011.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 3.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6004.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 3.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6006.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 1.0 .. "/" .. "true")
modem.transmit(6009.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6001.0, 0, 3.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6002.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 1.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6004.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6001.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6009.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6009.0, 0, 2.0 .. "/" .. "true")
sleep(0.35714275)
modem.transmit(6009.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6011.0, 0, 2.0 .. "/" .. "true")
sleep(0.35714275)
modem.transmit(6011.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6001.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6008.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 1.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6004.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6001.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 1.0 .. "/" .. "true")
modem.transmit(6001.0, 0, 4.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6008.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6001.0, 0, 4.0 .. "/" .. "false")
modem.transmit(6001.0, 0, 3.0 .. "/" .. "true")
sleep(0.35714275)
modem.transmit(6001.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 3.0 .. "/" .. "true")
sleep(0.35714275)
modem.transmit(6004.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6011.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6008.0, 0, 2.0 .. "/" .. "true")
sleep(2.857142)
modem.transmit(6011.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6008.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6001.0, 0, 3.0 .. "/" .. "true")
modem.transmit(6009.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6006.0, 0, 1.0 .. "/" .. "true")
modem.transmit(6006.0, 0, 2.0 .. "/" .. "true")
sleep(2.1428565)
modem.transmit(6009.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6001.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 3.0 .. "/" .. "true")
sleep(0.35714275)
modem.transmit(6006.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 3.0 .. "/" .. "true")
sleep(0.35714275)
modem.transmit(6006.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6011.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6011.0, 0, 1.0 .. "/" .. "true")
modem.transmit(6003.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6006.0, 0, 2.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6011.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6003.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6011.0, 0, 2.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6011.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6009.0, 0, 2.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6009.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6011.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6011.0, 0, 1.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 1.0 .. "/" .. "true")
modem.transmit(6008.0, 0, 2.0 .. "/" .. "true")
sleep(2.1428565)
modem.transmit(6004.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6011.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6008.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6009.0, 0, 2.0 .. "/" .. "true")
sleep(0.35714275)
modem.transmit(6009.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6011.0, 0, 2.0 .. "/" .. "true")
sleep(0.35714275)
modem.transmit(6004.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6011.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6009.0, 0, 1.0 .. "/" .. "true")
modem.transmit(6006.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6002.0, 0, 1.0 .. "/" .. "true")
sleep(2.857142)
modem.transmit(6002.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6009.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 1.0 .. "/" .. "true")
modem.transmit(6009.0, 0, 3.0 .. "/" .. "true")
modem.transmit(6001.0, 0, 3.0 .. "/" .. "true")
modem.transmit(6006.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6009.0, 0, 2.0 .. "/" .. "true")
sleep(2.1428565)
modem.transmit(6001.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6009.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6009.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 3.0 .. "/" .. "true")
sleep(0.35714275)
modem.transmit(6006.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 3.0 .. "/" .. "true")
sleep(0.35714275)
modem.transmit(6006.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6011.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6003.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6011.0, 0, 1.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6003.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6011.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6011.0, 0, 2.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6011.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6009.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6011.0, 0, 3.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6011.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6009.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6011.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6011.0, 0, 1.0 .. "/" .. "true")
modem.transmit(6008.0, 0, 3.0 .. "/" .. "true")
modem.transmit(6004.0, 0, 1.0 .. "/" .. "true")
modem.transmit(6008.0, 0, 2.0 .. "/" .. "true")
sleep(1.428571)
modem.transmit(6008.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6008.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6004.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6011.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6009.0, 0, 3.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6009.0, 0, 3.0 .. "/" .. "false")
modem.transmit(6001.0, 0, 4.0 .. "/" .. "true")
sleep(0.7142855)
modem.transmit(6004.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6001.0, 0, 4.0 .. "/" .. "false")
modem.transmit(6009.0, 0, 1.0 .. "/" .. "true")
modem.transmit(6006.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6006.0, 0, 3.0 .. "/" .. "true")
modem.transmit(6006.0, 0, 2.0 .. "/" .. "true")
modem.transmit(6002.0, 0, 2.0 .. "/" .. "true")
sleep(2.857142)
modem.transmit(6009.0, 0, 1.0 .. "/" .. "false")
modem.transmit(6002.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 2.0 .. "/" .. "false")
modem.transmit(6006.0, 0, 3.0 .. "/" .. "false")
