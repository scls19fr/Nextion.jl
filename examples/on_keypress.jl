using SFML

dt = now()
dt_last = dt
td_debounce = Dates.Millisecond(500)

while true
    if is_key_pressed(KeyCode.K)
        dt = now()
        td = dt - dt_last
        if td >= td_debounce
            println("NEXT")
            #exit(0)
            dt_last = dt
        end
    end
end
