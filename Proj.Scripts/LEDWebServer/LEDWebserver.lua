require("credentials") 
require("myHTML")
wifi.setmode(wifi.STATION)
wifi.sta.config(ssid,password)

local ledpin = 7
local status = gpio.LOW
gpio.mode(ledpin, gpio.OUTPUT)
gpio.write(ledpin,status)

print("Fetching IP address..")
tmr.alarm(1,10000,tmr.ALARM_SINGLE, function()
print(wifi.sta.getip())
print(tmr.ALARM_SINGLE)
end)

if srv == nil then
    srv = net.createServer(net.TCP,30)
end

srv:listen(80, function(netsocket)

    netsocket:on("receive",function(netsocket,data)
        print(data)
        local a,b = string.find(data, "GET(.+)HTTP")
        local ss1 = string.sub(data,a,b)
        local x,startofval = string.find(ss1,"pin=")
        local endofval, y = string.find(ss1,"HTTP")
        
        if startofval ~=nil and endofval ~=nil then
            local finalval = string.sub(ss1,startofval+1,endofval-2)
            if finalval == "ON" then
               status = gpio.HIGH
               gpio.write(ledpin,status)
            else
                status = gpio.LOW
                gpio.write(ledpin,status)
            --print("Final Value is.."..finalval)
            end
        end
        
        netsocket:send(s)
    end)

    netsocket:on("sent",function(netsocket)
        netsocket:close()
    end)
    
end)

