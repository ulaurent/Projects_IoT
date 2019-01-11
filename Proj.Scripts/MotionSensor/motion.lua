local motionpin = 1
local ledpin = 7
local ledstatus = gpio.LOW
local duration = 1000

gpio.mode(motionpin, gpio.INPUT)
gpio.mode(ledpin, gpio.OUTPUT)


tmr.alarm(0,duration,tmr.ALARM_AUTO, function()
    motionstatus = gpio.read(motionpin)
    if motionstatus == 0 then
        gpio.write(ledpin, ledstatus)
        print("No Motion Detected")
    else 
        gpio.write(ledpin, gpio.HIGH)
        print ("Motion Detected")
    end

    end)
