using Nextion
using Test


nexSerial = NexSerial("/dev/ttyUSB0")

nexSlider = NexSlider(nexSerial, Name("h0"), cid=ComponentID(4))

send(nexSerial, "page pg_slider")

sleep(1)

#nexSlider.cursor.color = Colour.GRAY
nexSlider.forecolor = Colour.GRAY
nexSlider.value = 30

sleep(1)

nexSlider.cursor.width = 10

sleep(1)

nexSlider.cursor.height = 13

sleep(1)

close(nexSerial)
