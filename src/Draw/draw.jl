"""
The `Draw` module provides a low-level API to perform some drawings on the Nextion display.
"""
module Draw
    using Nextion

    export cls, circle, xstr, line, rectangle, picture

    
    """
        cls(nexSerial)
        cls(nexSerial, colour)

    Clear screen (CLear Screen).

    `colour` can be:
    - a string
    - a decimal value
    - a `Colour.ColourCode` enum

    Usage:
    ```julia
    using Nextion
    Draw.cls(nexSerial)
    ```

    or

    ```julia
    using Nextion.Draw
    cls(nexSerial)
    ```
    """
    cls(nexSerial::NexSerial, colour::String) = send(nexSerial, "cls $colour")
    function cls(nexSerial::NexSerial, colour::Colour.ColourCode)
        c = string(Int(colour))
        cls(nexSerial, c)
    end
    function cls(nexSerial::NexSerial, colour::Int)
        c = string(colour)
        cls(nexSerial, c)
    end
    cls(nexSerial::NexSerial) = cls(nexSerial, Colour.NONE)


    """
        rectangle(nexSerial, x1, y1, x2, y2, color, mode=Background.NOBACKCOLOUR)

    Draw a rectangle, the top left coordinate is (x1, y1) 
    and bottom right corner is (x2, y2)
    
    If `mode` is not set (or set `NOBACKCOLOUR`)
    `color` is used for frame color.

    If `mode` is set to `SOLIDCOLOUR`
    `color` is used for fill color.
    """
    function rectangle(nexSerial::NexSerial,
        x1::UInt16, y1::UInt16,
        x2::UInt16, y2::UInt16,
        color, mode=Background.NOBACKCOLOUR)
        if mode == Background.NOBACKCOLOUR
            send(nexSerial, "draw $x1,$y1,$x2,$y2,$color")
        elseif mode == Background.SOLIDCOLOUR
            send(nexSerial, "fill $x1,$y1,$x2,$y2,$color")
        else
            error("Unsupported $mode")
        end
    end


    """
        circle(nexSerial, x, y, r, color, mode=Background.NOBACKCOLOUR)

    Draw a hollow circle whose radius is `r` with the coordinate (`x`, `y`) 
    as the center of a circle.

    If `mode` is not set (or set `NOBACKCOLOUR`)
    `color` is used for circle frame line.

    If `mode` is set to `SOLIDCOLOUR`
    `color` is used for fill color.
    """
    function circle(nexSerial::NexSerial,
        x::UInt16, y::UInt16,
        r::UInt16, color, mode=Background.NOBACKCOLOUR)
        if mode == Background.NOBACKCOLOUR
            send(nexSerial, "cir $x,$y,$r,$color")
        elseif mode == Background.SOLIDCOLOUR
            send(nexSerial, "cirs $x,$y,$r,$color")
        else
            error("Unsupported $mode")
        end
    end


    """
        xstr(nexSerial, x, y, w, h, fontid, fontcolor, backcolor, xcenter, ycenter, sta, str)
    
    Print string on the device.
    
    - `x`: x coordinate starting point;
    - `y`: y coordinate starting point;
    - `w`: area width;
    - `h`: area height;
    - `fontid`: Font ID;
    - `fontcolor`: Font color;
    - `backcolor`: Background color (when set sta as Crop Image or Image, backcolor means image ID );
    - `xcenter`: Horizontal alignment (0 is left-aligned, 1 is centered, 2 is right-aligned);
    - `ycenter`: Vertical alignment (0 is upper-aligned, 1 is centered, 2 is lower-aligned);
    - `sta`: Background fill(0-crop image;1-solid color;2-Image; 3-No backcolor, when set sta as Crop Image or Image, backcolor means image ID);
    - `str`: Character content
    """
    function xstr(nexSerial::NexSerial,
                x::UInt16, y::UInt16,
                w::UInt16, h::UInt16,
                fontid::UInt8,
                fontcolor, backcolor,
                xcenter::Alignment.Horizontal.AlignmentHorizontalCode,
                ycenter::Alignment.Vertical.AlignmentVerticalCode,
                sta::Background.BackgroundCode,
                str::String)
        xcenter = Int(xcenter)
        ycenter = Int(ycenter)
        sta = Int(sta)
        send(nexSerial, "xstr $x,$y,$w,$h,$fontid,$fontcolor,$backcolor,$xcenter,$ycenter,$sta,\"$str\"")
    end
    
    
    """
        line(nexSerial, x1, y1, x2, y2, color)

    Draw a line in color `color` between 
    the coordinate (`x1`, `y1`) and the coordinate (`x2`, `y2`)
    """
    function line(nexSerial::NexSerial,
                x1::UInt16, y1::UInt16,
                x2::UInt16, y2::UInt16,
                color)
        send(nexSerial, "line $x1,$y1,$x2,$y2,$color")
    end


    """
        picture(nexSerial, x, y, picid)

    Display the picture (ID is `picid`) in resource file 
    at the coordinate (`x`, `y`)
    """
    function picture(nexSerial::NexSerial,
                x::UInt16, y::UInt16,
                picid::UInt8)
        send(nexSerial, "pic $x,$y,$picid")
    end


    """
        picture(nexSerial, x, y, w, h, picid)

    !!! warning

    Untested
    """
    function picture(nexSerial::NexSerial,
                x::UInt16, y::UInt16,
                w::UInt16, h::UInt16,
                picid::UInt8)
        send(nexSerial, "picq $x,$y,$w,$h,$picid")
    end


    """
        picture(nexSerial, x, y, w, h, x0, y0, picid)

    !!! warning

        Untested
    """
    function picture(nexSerial::NexSerial,
                x::UInt16, y::UInt16,
                w::UInt16, h::UInt16,
                x0::UInt16, y0::UInt16,
                picid::UInt8)
        send(nexSerial, "xpic $x,$y,$w,$h,$x0,$y0,$picid")  # xpic or picq?
    end     

end
