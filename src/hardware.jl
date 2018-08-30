using LibSerialPort


abstract type AbstractNexSerial end


const DEFAULT_BAUDRATE = 9600


v_uint8_eoc = [0xff, 0xff, 0xff]  # Array{UInt8,1}
# v_char_eoc = Char.([0xff, 0xff, 0xff])  # Array{Char,1} ['ÿ', 'ÿ', 'ÿ']
s_eoc = String(copy(v_uint8_eoc))  # "\xff\xff\xff"


"""
    NexSerial(portname, bps=DEFAULT_BAUDRATE, args...; kwargs...)

Nextion Screen serial connexion object.

By default communication speed is set to DEFAULT_BAUDRATE = 9600 baud.
"""
struct NexSerial <: AbstractNexSerial
    function NexSerial(portname, bps=DEFAULT_BAUDRATE, args...; kwargs...)
        # new(SerialPort(args...; kwargs...))  # with SerialPorts.jl
        new(open(portname, bps, args...; kwargs...))  # with LibSerialPort.jl
    end
    _serial::SerialPort
end

"""
    NexSerialMock(portname, bps=DEFAULT_BAUDRATE, args...; kwargs...)

Nextion Screen serial connexion object.

This is a mock.

Only use it for unit tests that don't need hardware
"""
struct NexSerialMock <: AbstractNexSerial
end
function NexSerialMock(portname, bps=DEFAULT_BAUDRATE, args...; kwargs...)
    NexSerialMock()
end


"""
    init(nexSerial)

Initialize Nextion serial communication.

Serial communication is initialized by baudrate=9600
"""
function init(nexSerial::NexSerial)
    # ...
end

"""
    send(nexSerial, cmd)

Send a command `cmd` to Nextion using serial communication
defined by `nexSerial` and return code.

`cmd` must be lowercased
"""
function send(nexSerial::NexSerial, cmd::String)
    write(nexSerial, cmd)
    @info "reading..."
    r = read(nexSerial)
    @info "end of read."
    r
end


"""
    _format_command(cmd)


Add \xff\xff\xff at the end of String

# Usage

```
 julia> _format_command("sendme")
"sendme\xff\xff\xff"

julia> transcode(UInt8, _format_command("sendme"))
9-element Base.CodeUnits{UInt8,String}:
 0x73
 0x65
 0x6e
 0x64
 0x6d
 0x65
 0xff
 0xff
 0xff
 ```

"""
function _format_command(cmd)
    cmd * s_eoc
end

"""
See https://github.com/andrewadare/LibSerialPort.jl/issues/23
https://github.com/andrewadare/LibSerialPort.jl/issues/24
"""
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
 


"""
    write(nexSerial, cmd)

Write a command `cmd` to Nextion using serial communication
defined by `nexSerial`.
"""
function write(nexSerial::NexSerial, cmd::String)
    ser = nexSerial._serial
    @info "write '$cmd' to $ser"
    cmd = _format_command(cmd)
    write(ser, cmd)
end


"""
    read(nexSerial)

Read state of a Nextion using serial communication
defined by `nexSerial`.
"""
function read(nexSerial::NexSerial)
    ser = nexSerial._serial
    r = read(ser, UInt8)
end


"""
    close(nexSerial)

Close serial communication with Nextion display.
"""
function close(nexSerial::NexSerial)
    ser = nexSerial._serial
    close(ser)
end


"""
    reset(nexSerial)

Reset Nextion device.
"""
function reset(nexSerial::NexSerial)
    send(nexSerial, "rest")
end


"""
    checkcommandcomplete(nexSerial)

Return true if command returned succesfully
"""
function checkcommandcomplete(nexSerial::NexSerial)
    #ret = false
    error("ToDo")
    timeout = 10
    port = nexSerial._serial.ref
    returned_bytes = sp_blocking_read(port, 4, timeout)
    returned_bytes
end


struct Backlight
    value::Unsigned
    persist::Bool

    function Backlight(value, persist=false)
        r = 0:100
        if !(value in r)
            error("Backlight value must be in $r")
        end
        new(value, persist)
    end
end


"""
    nexSerial.backlight = Backlight(100)  # Backlight(100, true)  # for persistance

Set backlight.
"""
function setproperty!(nexSerial::NexSerial, property::Symbol, new_val::Backlight)  # caution! new_val type
    if property == :backlight
        val = new_val.value
        persist = new_val.persist
        if persist
            send(nexSerial, "dims=$val")
        else
            send(nexSerial, "dim=$val")
        end
    else
        setfield!(obj, property, new_val)
    end
end

#function getproperty(nexSerial::NexSerial, property::Symbol)
#    if property == :backlight
#        send(nexSerial, "get dim")
#        val = receivenumber()
#        val
#    else
#        setfield!(obj, property, new_val)
#    end
#end