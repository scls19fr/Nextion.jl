using Nextion

nexSerial = NexSerial("/dev/ttyUSB0", 9600)

#nexText = NexText(nexSerial, Name("t0"), pid=PageID(0), cid=ComponentID(1))
#nexText = NexText(nexSerial, Name("t0"))
nexText = NexText(nexSerial, Name("t0"), cid=ComponentID(1))

setText(nexText, "Hello!")

sleep(0.5)

setText(nexText, "1")

sleep(0.5)

setText(nexText, "2")

sleep(0.5)

setText(nexText, "3")

sleep(0.5)

setText(nexText, "Bye")

sleep(0.5)

setVisible(nexText, false)

sleep(0.5)

setVisible(nexText, true)

sleep(0.5)

reset(nexSerial)

sleep(0.5)

close(nexSerial)