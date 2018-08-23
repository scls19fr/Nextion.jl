using Nextion
using Test


nexSerial = NexSerial("/dev/ttyUSB0")

nexProgressBar = NexProgressBar(nexSerial, Name("j0"), cid=ComponentID(1))

send(nexSerial, "page pg_pbar")

sleep(1)

nexProgressBar.value = 30

@test_throws ErrorException nexProgressBar.value = 105  # should raise error because value must be in 0-100
@test_throws ErrorException nexProgressBar.value = -1  # should raise error because value must be in 0-100

sleep(1)

close(nexSerial)
