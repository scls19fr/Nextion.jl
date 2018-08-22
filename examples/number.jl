using Nextion

nexSerial = NexSerial("/dev/ttyUSB0")

nexNumber = NexNumber(nexSerial, Name("n0"), cid=ComponentID(1))

send(nexSerial, "page pg_num")

sleep(1)

nexNumber.value = 1

sleep(1)

nexNumber.value = 2
nexNumber.backcolor = Colour.RED
nexNumber.forecolor = Colour.WHITE

sleep(1)

nexNumber.value = 3
nexNumber.backcolor = Colour.WHITE
nexNumber.forecolor = Colour.RED

close(nexSerial)