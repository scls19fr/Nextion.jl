using Nextion

nexSerial = NexSerial("/dev/ttyUSB0", 9600)

send(nexSerial, "t0.txt=\"Hello\"")

sleep(0.5)

send(nexSerial, "t0.txt=\"1\"")

sleep(0.5)

send(nexSerial, "t0.txt=\"2\"")

sleep(0.5)

send(nexSerial, "t0.txt=\"3\"")

sleep(0.5)

send(nexSerial, "t0.txt=\"Bye\"")
