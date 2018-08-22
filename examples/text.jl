using Nextion

nexSerial = NexSerial("/dev/ttyUSB0")

#nexText = NexText(nexSerial, Name("t1"), pid=PageID(2), cid=ComponentID(1))
#nexText = NexText(nexSerial, Name("t1"))
nexText = NexText(nexSerial, Name("t1"), cid=ComponentID(1))

reset(nexSerial)

sleep(1)

send(nexSerial, "page pg_text")

sleep(1)

nexText.text = "Hello!"

sleep(0.5)

nexText.text = "1"

sleep(0.5)

nexText.text = "2"

sleep(0.5)

nexText.text = "3"

sleep(0.5)

nexText.text = "Bye nexText"

sleep(0.5)

nexText.visible = false

sleep(2)

nexText.visible = true

sleep(0.5)


nexText.alignment.horizontal = Alignment.Horizontal.RIGHT
nexText.alignment.vertical = Alignment.Vertical.DOWN

# Change fontid from 0 to 1
nexText.font = Font(1)


#reset(nexSerial)
#sleep(0.5)

close(nexSerial)