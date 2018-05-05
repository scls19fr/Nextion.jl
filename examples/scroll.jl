using Nextion

nexSerial = NexSerial("/dev/ttyUSB0")

nexPage = NexPage(nexSerial, Name("pg_scroll"), pid=PageID(6))
show(nexPage)

nexScrollText = NexScrollText(nexSerial, Name("g0"), pid=PageID(1))
setText(nexScrollText, "Hello Nextion!")

close(nexSerial)
