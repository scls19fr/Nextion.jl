using Nextion

nexSerial = NexSerial("/dev/ttyUSB0")

nexQRcode = NexQRcode(nexSerial, Name("qr0"), cid=ComponentID(1))
nexText = NexText(nexSerial, Name("t1"), cid=ComponentID(3))

send(nexSerial, "page pg_qr")

sleep(1)

text = "Hello"
nexQRcode.text = text
nexText.text = text

sleep(2)

#text = "https://github.com/scls19fr/Nextion.jl"
text = "http://bit.ly/2vWS75r"
nexText.text = text
#nexQRcode.textmaxlength = length(text)
#nexQRcode.textmaxlength = 50
#sleep(1)
nexQRcode.text = text
