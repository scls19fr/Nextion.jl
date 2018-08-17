using Nextion

nexSerial = NexSerial("/dev/ttyUSB0")

#nexText = NexText(nexSerial, Name("t1"), pid=PageID(2), cid=ComponentID(1))
#nexText = NexText(nexSerial, Name("t1"))
nexText = NexText(nexSerial, Name("t1"), cid=ComponentID(1))

reset(nexSerial)

sleep(1)

send(nexSerial, "page pg_text")

sleep(1)

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

setAlignment(nexText, Alignment.Horizontal.RIGHT)  # RIGHT CENTRE LEFT
setAlignment(nexText, Alignment.Vertical.DOWN)  # UP CENTRE DOWN

#reset(nexSerial)
#sleep(0.5)

close(nexSerial)