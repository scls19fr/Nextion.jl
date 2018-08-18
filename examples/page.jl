using Nextion
using Nextion: NexID


nexSerial = NexSerial("/dev/ttyUSB0")

# Nextion pages are 0-indexed
# nexPages is a Julia Vector and is 1-indexed

nexPages = NexPage[]
pages_nb = 10
for i in 0:pages_nb-1
    nexPage = NexPage(nexSerial, Name("page$i"), pid=PageID(i), cid=ComponentID(0))
    push!(nexPages, nexPage)
end

for i in 1:pages_nb
    show(nexPages[i], PageID)
    sleep(0.5)
end

nexPage = nexPages[1]  # page0
show(nexPage)
@assert PageID(NexID(nexPage)) == PageID(0x00)

sleep(0.1)

#@show isshown(nexPage[2])  #ToDo!!!
#@show !isshown(nexPage[1])

close(nexSerial)
