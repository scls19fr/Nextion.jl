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
        Code.ReturnCode(val)
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


"""
Module storing Nextion supported baudrates
"""
module Baudrate
    SUPPORTED = [2400, 4800, 9600, 19200, 38400, 57600, 115200]

    function _assert_supported(value)
        if !(value in SUPPORTED)
            error("baudrate=$value not in $SUPPORTED")
        end
    end

    function at(value)
        _assert_supported(value)
        value
    end
    
    function id(value)
        _assert_supported(value)
        findall(x -> x == value, SUPPORTED)[1]
    end
end
