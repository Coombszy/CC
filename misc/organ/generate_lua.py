from mido import MidiFile
import sys

OCTAVE_OFFSET = 0

OFFSET = -42 # Note offset 
RANGE = 36 # Organ range

ARGS = sys.argv[1:]

# In game organ data
O_OCTAVE_WIDTH = 12
O_CHANNEL_OFFSET = 6000

OFFSET = OFFSET + (OCTAVE_OFFSET * 12)  # Note offset + OCTAVE OFFSET



mid = MidiFile(ARGS[0], clip = True)

def offset_midi_to_lua(note):
    if note == 0:
        return 0

    c = note + OFFSET
    if (c < 1 or c > 36):
        # print("Error in converting: ", c, " is not convertable")
        return 0
    return c


def convert_note_to_organ(note, type):
    out = "" 
    if note == 0:
        return (None, None, None)
    
    cc_octave = ((note - (note % O_OCTAVE_WIDTH)) / O_OCTAVE_WIDTH )  
    cc_note = note - (cc_octave * O_OCTAVE_WIDTH)

    cc_type = "false"
    if (type == "note_on"):
        cc_type = "true"
    # +1 offset, organ octaves and notes starts at 1
    return (cc_octave + 1, cc_note + 1, cc_type)

def convert_to_lua_instruction(note):
    if note[0] == None:
        return "NONE"
    s =  "modem.transmit("+str(O_CHANNEL_OFFSET+note[1])+", 0, "+str(note[0])+" .. \"/\" .. \""+str(note[2])+"\")"
    return s


######################################################################




data = []
data.append("local S_CHANNEL = 6000")
data.append("local modem = peripheral.find(\"modem\") or error(\"No modem attached\", 0)")

ERRORS = 0
TOTAL = 0

# Get midi data
for msg in mid:
    # If a note message
    if (msg.type == "note_on" or msg.type == "note_off"):
        TOTAL += 1
        # Convert to lua instruction
        n = offset_midi_to_lua(msg.note)
        if n == 0:
            ERRORS += 1
        i = convert_note_to_organ(n, msg.type)
        if msg.time != 0:
            sl = "sleep("+str(msg.time)+")"
            data.append(sl)
        s = convert_to_lua_instruction(i)
        if s != "NONE":
            data.append(s)


import os
if os.path.exists("output.lua"):
  os.remove("output.lua")

f = open("output.lua", "w")
for i in data:
    f.write(i+"\n")

print("Total: ", TOTAL)
print("Errors: ", ERRORS)



