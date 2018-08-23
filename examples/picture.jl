using Nextion

nexSerial = NexSerial("/dev/ttyUSB0")

nexPicture = NexPicture(nexSerial, Name("p0"), cid=ComponentID(1))

send(nexSerial, "page pg_pic")

for i in 1:4
    sleep(1)
    #nexPicture.picture = i
    nexPicture.picture = Picture(i)
end

close(nexSerial)
