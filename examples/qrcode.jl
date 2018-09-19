using Nextion


@testset "qrcode" begin
    nexSerial = NexSerial("/dev/ttyUSB0")

    nexQRcode = NexQRcode(nexSerial, Name("qr0"), cid=ComponentID(1))
    nexText = NexText(nexSerial, Name("t1"), cid=ComponentID(3))

    send(nexSerial, "page pg_qr")

    sleep(1)

    msg = "Hello"
    nexQRcode.text = msg
    nexText.text = msg
  
    @test nexQRcode.text = msg

    sleep(2)

    # text = "https://github.com/scls19fr/Nextion.jl"
    msg = "http://bit.ly/2vWS75r"
    nexText.text = msg
    #nexQRcode.textmaxlength = length(text)
    #nexQRcode.textmaxlength = 50
    #sleep(1)
    nexQRcode.text = msg

    close(nexSerial)
end
