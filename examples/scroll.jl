using Nextion

nexSerial = NexSerial("/dev/ttyUSB0")

nexPage = NexPage(nexSerial, Name("pg_scroll"), pid=PageID(6))
show(nexPage)

