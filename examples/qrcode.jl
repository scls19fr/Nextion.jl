using Nextion

nexSerial = NexSerial("/dev/ttyUSB0")

nexQRcode = NexQRcode(nexSerial, Name("qr0"), cid=ComponentID(1))

send(nexSerial, "page pg_qr")

sleep(1)

text = "Hello"
nexQRcode.text = text

sleep(2)

#text = "https://github.com/scls19fr/Nextion.jl"
text = "http://bit.ly/2vWS75r"
#nexQRcode.textmaxlength = length(text)
#nexQRcode.textmaxlength = 50
#sleep(1)
nexQRcode.text = text
