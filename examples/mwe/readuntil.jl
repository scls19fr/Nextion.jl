using LibSerialPort


v_uint8_eoc = [0xff, 0xff, 0xff]  # Array{UInt8,1}
v_char_eoc = Char.(v_uint8_eoc)  # Array{Char,1} ['ÿ', 'ÿ', 'ÿ']
s_eoc = String(copy(v_uint8_eoc))  # "\xff\xff\xff"

function _format_command(cmd)
    cmd * s_eoc
end

port = "/dev/ttyUSB0"
baudrate = 9600

sp = open(port, baudrate)

cmd = "sendme"
cmd = _format_command(cmd)
write(sp, cmd)

function my_readuntil(sp::SerialPort, delim::AbstractString, timeout_ms::Real)
   return String(take!(readuntil(sp, Vector{Char}(delim), timeout_ms)))
end

function my_readuntil(sp::SerialPort, delim::Vector{T}, timeout_ms::Real) where {T}
    start_time = time_ns()
    out = Vector{T}()
    lastchars = T[0 for i=1:length(delim)]
    while !eof(sp)
        if (time_ns() - start_time)/1e6 > timeout_ms
            break
        end
        if bytesavailable(sp) > 0
            c = read(sp, T)
            push!(out, c)
            lastchars = circshift(lastchars,-1)
            lastchars[end] = c
            if lastchars == delim
                break
            end
        end
    end
    return out
end

timeout_ms = 4000


#s = readuntil(sp, s_eoc, timeout_ms)
#println(s)
#r = transcode(UInt8, s)
#println(r)

#r = my_readuntil(sp, v_char_eoc, timeout_ms)
#println(r)

r = my_readuntil(sp, v_uint8_eoc, timeout_ms)
println(r)
