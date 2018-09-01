using Nextion
using Nextion.Draw
using Test


const LCD_WIDTH, LCD_HEIGHT = 480, 320
const DEFAULT_COLOUR = Colour.WHITE
const IMG_WIDTH, IMG_HEIGHT = 200, 135


@testset "draw" begin
    nexSerial = NexSerial("/dev/ttyUSB0")


    send(nexSerial, "page0")
    cls(nexSerial, DEFAULT_COLOUR)

    function print_several_lines(nexSerial; lcd_width=LCD_WIDTH, color1="WHITE", color2="BLACK")
        function swap(x, y)
            y, x
        end

        x, y = 0, 10
        w, h = lcd_width, 30
        font = Font(0)
        fontcolor = color1
        backcolor = color2
        xcenter = Alignment.Horizontal.CENTRE  # NONE/LEFT/CENTRE/RIGHT
        ycenter = Alignment.Vertical.CENTRE  # NONE/UP/CENTRE/DOWN
        sta = Background.SOLIDCOLOUR # NONE/CROPIMAGE/SOLIDCOLOUR/IMAGE/NOBACKCOLOUR

        lines = [
            "Hello Julia!",
            "",
            "This is Nextion",
            "",
            "I'm an intelligent display",
            "",
            "",
            "",
            "https://github.com/scls19fr",
            "/Nextion.jl"
        ]
        for line in lines
            xstr(nexSerial, x, y, w, h, font, fontcolor, backcolor, xcenter, ycenter, sta, line)
            y = y + h
            fontcolor, backcolor = swap(fontcolor, backcolor)    
        end
    end


    function diagonal_line(nexSerial; lcd_width=LCD_WIDTH, lcd_height=LCD_HEIGHT)
        x1, y1 = 0, 0
        x2, y2 = lcd_width, lcd_height
        colour = Colour.BLUE
        line(nexSerial, x1, y1, x2, y2, colour)
    end

    function circle_frame_fill(nexSerial; lcd_width=LCD_WIDTH, lcd_height=LCD_HEIGHT, delay=1)
        x = Int(round(lcd_width / 2))
        y = Int(round(lcd_height / 2))
        r = 100
        colour = Colour.BLUE
        circle(nexSerial, x, y, r, colour)
        sleep(delay)
        circle(nexSerial, x, y, r, colour, Background.SOLIDCOLOUR)    
    end


    function clear_screen_color_france(nexSerial, delay=1)
        cls(nexSerial, Colour.BLUE)

        sleep(delay)
        
        cls(nexSerial, Colour.WHITE)
        
        sleep(delay)
        
        cls(nexSerial, Colour.RED)
    end

    function france_flag(nexSerial; lcd_width=LCD_WIDTH, lcd_height=LCD_HEIGHT)
        w, h = Int(round(lcd_width/3)), lcd_height
        x1, y1 = 0, 0
        y2 = h
        x2 = x1 + w
        colour = Colour.BLUE
        rectangle(nexSerial, x1, y1, x2, y2, colour, Background.SOLIDCOLOUR)
        x1 = x1 + 2*w
        x2 = x1 + w
        colour = Colour.RED
        rectangle(nexSerial, x1, y1, x2, y2, colour, Background.SOLIDCOLOUR)    
    end

    function rectangle_frame_fill(nexSerial; lcd_width=LCD_WIDTH, lcd_height=LCD_HEIGHT)
        w, h = 120, 80
        x1 = Int(round((lcd_width - w) / 2))
        y1 = Int(round((lcd_height - h) / 2))
        x2 = x1 + w
        y2 = y1 + h
        colour = Colour.RED
        rectangle(nexSerial, x1, y1, x2, y2, colour)
        sleep(1)
        rectangle(nexSerial, x1, y1, x2, y2, colour, Background.SOLIDCOLOUR)    
    end

    function picture_julia(nexSerial; lcd_width=LCD_WIDTH, lcd_height=LCD_HEIGHT, img_width=IMG_WIDTH, img_height=IMG_HEIGHT, delay=0.5)
        x = Int(round((lcd_width - img_width) / 2))
        y = Int(round((lcd_height - img_height) / 2))
        for picid in 0:4
            picture(nexSerial, x, y, Picture(picid))
            sleep(delay)
        end    
    end


    print_several_lines(nexSerial)

    sleep(2)
    cls(nexSerial, DEFAULT_COLOUR)

    diagonal_line(nexSerial)

    sleep(2)
    cls(nexSerial)

    circle_frame_fill(nexSerial)

    sleep(2)
    cls(nexSerial)

    clear_screen_color_france(nexSerial)

    sleep(2)
    cls(nexSerial)

    france_flag(nexSerial)

    sleep(2)
    cls(nexSerial)
    sleep(1)

    rectangle_frame_fill(nexSerial)

    sleep(2)
    cls(nexSerial)

    picture_julia(nexSerial)

    close(nexSerial)
    @test true

end