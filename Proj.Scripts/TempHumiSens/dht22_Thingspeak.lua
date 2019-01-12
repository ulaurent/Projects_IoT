require("credentials")

wifi.setmode(wifi.STATION)
wifi.sta.config(ssid,password)

local pin = 7

tmr.alarm(1,5000, tmr.ALARM_AUTO, function()
    status, temp, humi, temp_dec, humi_dec = dht.read(pin)
    
    if status == dht.OK then
        print("DHT temperature is: " ..temp.." Humidity is: "..humi)
        sendDataToThingSpeak(temp,humi)
    elseif status == dht.ERROR_CHECKSUM then
        print("Checksum error")
    elseif status == dht.ERROR_TIMEOUT then
        print("Timeout Error")
    end 
end)


function sendDataToThingSpeak(temp,humi)
    -- Get IP adress
    myip = wifi.sta.getip()
    print(myip)
    if myip ~= nil then
        print("Sending Data to Thingspeak...")

        --HTTP Post Module(url,headers,body,callback)
        http.post('http://api.thingspeak.com/update',
            'Content-Type: application/json\r\n',
            '{"apikey":"4YPKTX4MF1C1BBTM", "field1":'..temp..', "field2":'..humi..'}',
            function(code, data)
                if (code < 0) then
                    print("HTTP request failed")
                else
                    print(code, data)
            end
        end)
    else
        print("Not connected to wifi yet...")
    end
end