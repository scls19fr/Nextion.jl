using Nextion

nexSerial = NexSerial("/dev/ttyUSB0")

nexNumber = NexNumber(nexSerial, Name("n0"), cid=ComponentID(1))

send(nexSerial, "page pg_num")

sleep(1)

#nexNumber.val = 123  # ToDo: shouldn't work (setproperty! should be fixed!)

nexNumber.value = 123
