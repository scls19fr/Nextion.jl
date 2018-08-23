# ToDo: working in progress

using Nextion
using Test


nexSerial = NexSerial("/dev/ttyUSB0")
nexWaveform = NexWaveform(nexSerial, Name("s0"), cid=ComponentID(2))

#nexWaveform.grid.width = 10
#nexWaveform.grid.height = 10
#nexWaveform.grid.color = Colour.BLUE
#send(nexSerial, "cls 65535")

sleep(1)

send(nexSerial, "page pg_waveform")

#send(nexSerial, "s0.pco0=65535")

#nb_channels = length(nexWaveform.channels)
#@test nb_channels == 4
nb_channels = 4

#nexWaveform.channels[0].color = Colour.WHITE
#push!(nexWaveform.channels[0], UInt8(123))  # values in 0:255 (add)
#push!(nexWaveform.channels[0], UInt8[123, 123, 100])  # (addt)

cid = 2
values = Vector{UInt8}(undef, 4)
#fill!(values, 127)
delta_v = UInt8(51)
v = 0
v = v + delta_v
values[1] = v
v = v + delta_v
values[2] = v
v = v + delta_v
values[3] = v
v = v + delta_v
values[4] = v
while true
    for ch in 0:nb_channels - 1
        value = values[ch + 1]
        send(nexSerial, "add $cid,$ch,$value")
        values[ch + 1] = values[ch + 1] + 2 * rand(-1:1)
    end
    sleep(0.01)
end

close(nexSerial)