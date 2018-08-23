using Nextion
using Test


nexSerial = NexSerial("/dev/ttyUSB0")

nexSlider = NexSlider(nexSerial, Name("h0"), cid=ComponentID(4))

send(nexSerial, "page pg_slider")

sleep(1)

nexSlider.value = 30

sleep(1)

send(nexSerial, "h0.wid=10")
#nexSlider.cursor.width = 10

sleep(1)

send(nexSerial, "h0.hig=10")
# nexSlider.cursor.height = 10

sleep(1)

close(nexSerial)
