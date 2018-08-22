using Nextion

nexSerial = NexSerial("/dev/ttyUSB0")

nexNumber = NexNumber(nexSerial, Name("n0"), cid=ComponentID(1))

send(nexSerial, "page pg_num")

sleep(1)

nexNumber.value = 1

sleep(1)

nexNumber.value = 2

sleep(1)

nexNumber.value = 3

close(nexSerial)