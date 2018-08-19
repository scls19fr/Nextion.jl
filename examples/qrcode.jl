using Nextion

nexSerial = NexSerial("/dev/ttyUSB0")

nexQRcode = NexQRcode(nexSerial, Name("qr0"), cid=ComponentID(1))

send(nexSerial, "page pg_qr")

sleep(1)

nexQRcode.text = "Hello"

sleep(2)

nexQRcode.textmaxlength = 40
nexQRcode.text = "https://github.com/scls19fr/Nextion.jl"
