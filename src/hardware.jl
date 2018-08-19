using LibSerialPort


"""
Module storing return codes and modes
"""
module Return

    """
    Module storing return codes enum

    Usage:
    - `Return.Code.CMD_FINISHED`
    - ...
    """
    module Code
        """
        Return code enum
        """
        @enum ReturnCode::UInt8 begin
            CMD_FINISHED   = 0x01
            EVENT_LAUNCHED = 0x88
            EVENT_UPGRADED = 0x89
            EVENT_TOUCH_HEAD = 0x65
            EVENT_POSITION_HEAD = 0x67
            EVENT_SLEEP_POSITION_HEAD = 0x68
            CURRENT_PAGE_ID_HEAD      = 0x66
            STRING_HEAD               = 0x70
            NUMBER_HEAD               = 0x71
            INVALID_CMD          = 0x00
            INVALID_COMPONENT_ID = 0x02
            INVALID_PAGE_ID      = 0x03
            INVALID_PICTURE_ID   = 0x04
            INVALID_FONT_ID      = 0x05
            INVALID_BAUD         = 0x11
            INVALID_VARIABLE     = 0x1A
            INVALID_OPERATION    = 0x1B
        end
    end

    function code(val::UInt8)
        Code.ReturnCode[val][1]
    end

    """
    Module storing return modes enum

    Usage:
    - `Return.Mode.NO_RETURN`
    - ...
    """
    module Mode
        """
        Return mode enum
        """
        @enum ReturnMode::UInt8 begin
            NO_RETURN    = 0x00  # No return
            SUCCESS_ONLY = 0x01  # Only return the successful data
            FAIL_ONLY    = 0x02  # Only return the failed data
            ALWAYS       = 0x03  # Always return
        end
    end
end


"""
Module storing font alignment modes
(Horizontal or Vertical)
"""
module Alignment

    """
    Module storing horizontal alignment modes
    
    Usage:
    - `Alignment.Horizontal.LEFT`
    - ...
    """
    module Horizontal
        @enum AlignmentHorizontalCode::Int8 begin
            NONE = -1  # Undefined
            LEFT = 0   # Left (x)
            CENTRE = 1 # Centre
            RIGHT = 2  # Right (x)
        end
    end

    """
    Module storing vertical alignment modes
    
    Usage:
    - `Alignment.Vertical.DOWN`
    - ...
    """
    module Vertical
        @enum AlignmentVerticalCode::Int8 begin
            NONE = -1  # Undefined
            UP = 0     # Top (y)
            CENTRE = 1 # Centre
            DOWN = 2   # Bottom (y)
        end
    end
end


"""
Module storing background modes for widgets/drawables with backgrounds

Usage:
- `Background.SOLIDCOLOUR`
- ...
"""
module Background
    @enum BackgroundCode::Int8 begin
        NONE = -1        # Undefined
        CROPIMAGE = 0    # Cropped image
        SOLIDCOLOUR = 1  # Solid colour
        IMAGE = 2        # Full size image
        NOBACKCOLOUR = 3 # No backcolour
    end
end


"""
Module storing several default colour values

Usage:
- Colour.RED
- ...
"""
module Colour
    @enum ColourCode::Int32 begin
        NONE = -1
        BLACK = 0
        WHITE = 65535
        RED = 63488
        GREEN = 2016
        BLUE = 31
        GRAY = 33840
        BROWN = 48192
        YELLOW = 65504
    end
end


module Scroll
    """
    Module storing scrolling properties (such as directions for scrolling

    Usage:
    - Scroll.Direction.LEFT_TO_RIGHT
    """
    module Direction
        @enum ScrollDirectionCode::Int8 begin
            NONE = -1
            LEFT_TO_RIGHT = 0
            RIGHT_TO_LEFT = 1
            UP_TO_DOWN = 2
            DOWN_TO_UP = 3
        end
    end
end


abstract type AbstractNexSerial end


const DEFAULT_BAUDRATE = 9600

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
    _write_end_of_command(ser)

Write end of command (3 times `0xff`) to serial `ser`
"""
function _write_end_of_command(ser)
    for i in 0:2
        write(ser, 0xff)
    end
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
    write(nexSerial, cmd)

Write a command `cmd` to Nextion using serial communication
defined by `nexSerial`.
"""
function write(nexSerial::NexSerial, cmd::String)
    ser = nexSerial._serial
    @info "write '$cmd' to $ser"
    write(ser, cmd)
    _write_end_of_command(ser)
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