using Nextion
using Nextion.Draw

nexSerial = NexSerial("/dev/ttyUSB0", 9600)

const LCD_WIDTH, LCD_HEIGHT = UInt16(480), UInt16(320)
const DEFAULT_COLOUR = Colour.WHITE
const IMG_WIDTH, IMG_HEIGHT = UInt16(200), UInt16(135)

cls(nexSerial, DEFAULT_COLOUR)

function swap(x, y)
    y, x
end

x, y = UInt16(0), UInt16(10)
w, h = LCD_WIDTH, UInt16(30)
fontid = UInt8(0)
fontcolor = "WHITE"
backcolor = "BLACK"
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
    xstr(nexSerial, x, y, w, h, fontid, fontcolor, backcolor, xcenter, ycenter, sta, line)
    y = y + h
    fontcolor, backcolor = swap(fontcolor, backcolor)    
end

sleep(2)
Draw.cls(nexSerial, DEFAULT_COLOUR)

x1, y1 = UInt16(0), UInt16(0)
x2, y2 = LCD_WIDTH, LCD_HEIGHT
colour = Colour.BLUE
line(nexSerial, x1, y1, x2, y2, colour)

sleep(2)
Draw.cls(nexSerial)

# France flag
w, h = UInt16(round(LCD_WIDTH/3)), LCD_HEIGHT
x1, y1 = UInt16(0), UInt16(0)
y2 = h
x2 = UInt16(x1 + w)
colour = Colour.BLUE
rectangle(nexSerial, x1, y1, x2, y2, colour, Background.SOLIDCOLOUR)
x1 = UInt16(x1 + 2*w)
x2 = UInt16(x1 + w)
colour = Colour.RED
rectangle(nexSerial, x1, y1, x2, y2, colour, Background.SOLIDCOLOUR)

sleep(1)

x1, y1 = UInt16(0), UInt16(0)
x2, y2 = LCD_WIDTH, LCD_HEIGHT
colour = Colour.BLACK
rectangle(nexSerial, x1, y1, x2, y2, colour)

sleep(0.5)

Draw.cls(nexSerial, Colour.BLUE)

sleep(0.5)

Draw.cls(nexSerial, Colour.WHITE)

sleep(0.5)

Draw.cls(nexSerial, Colour.RED)

sleep(0.5)

Draw.cls(nexSerial)

sleep(2)

# Julia logo
x = UInt16(round((LCD_WIDTH - IMG_WIDTH) / 2))
y = UInt16(round((LCD_HEIGHT - IMG_HEIGHT) / 2))
for picid in 0:4
    picture(nexSerial, x, y, UInt8(picid))
    sleep(0.5)
end

sleep(2)
Draw.cls(nexSerial)

# Japan
x = UInt16(round(LCD_WIDTH / 2))
y = UInt16(round(LCD_HEIGHT / 2))
r = UInt16(100)
colour = Colour.RED
Draw.circle(nexSerial, x, y, r, colour)
sleep(1)
Draw.circle(nexSerial, x, y, r, colour, Background.SOLIDCOLOUR)

sleep(1)
Draw.cls(nexSerial)


close(nexSerial)