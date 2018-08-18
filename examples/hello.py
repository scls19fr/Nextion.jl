import time
import serial


def _write_end_of_command(ser):
    for i in range(3):
        ser.write(chr(255))

def _execute_command(ser, cmd):
    print(cmd)
    ser.write(cmd)
    _write_end_of_command(ser)

def main():
    ser = serial.Serial("/dev/ttyUSB0", 9600, timeout=10)
    _execute_command(ser, "page 0")
    time.sleep(2)
    _execute_command(ser, "page 1")
    _write_end_of_command(ser)
    time.sleep(2)
    _execute_command(ser, "t0.txt=\"Hello\"")
    time.sleep(2)
    _execute_command(ser, "sendme")
    while(True):
        r = ser.read()
        if r is None or r=="":
            break
        #c = ord(r)
        print(r.encode('hex'))
        #print(c)
        #print(c==0x66)
    #should receive page number
    ser.close()


if __name__ == '__main__':
    main()
