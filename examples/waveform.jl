# ToDo: working in progress

function get_values()
    values = Vector{UInt8}(undef, 4)
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
    values
end

using Nextion
using Test


nexSerial = NexSerial("/dev/ttyUSB0")
nexWaveform = NexWaveform(nexSerial, Name("s0"), cid=ComponentID(2))

send(nexSerial, "page pg_waveform")

nexWaveform.grid.width = 20
nexWaveform.grid.height = 20
nexWaveform.grid.color = Colour.GRAY

sleep(1)

#send(nexSerial, "s0.pco0=65535")

#nb_channels = length(nexWaveform.channels)
#@test nb_channels == 4
nb_channels = 4

#channel = nexWaveform.channels[0]
#channel.color = Colour.WHITE

#push!(channel, UInt8(123))  # values in 0:255 (add)
#push!(channel, UInt8[123, 123, 100])  # (addt)

cid = 2
values = get_values()
while true
    for ch in 0:nb_channels - 1
        channel = nexWaveform.channels[ch]
        value = values[ch + 1]
        push!(channel, value)
        values[ch + 1] = values[ch + 1] + 2 * rand(-1:1)
    end
    sleep(0.01)
end

close(nexSerial)