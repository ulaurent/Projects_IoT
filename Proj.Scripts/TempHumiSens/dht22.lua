local pin = 7

tmr.alarm(1,5000, tmr.ALARM_AUTO, function()
    status, temp, humi, temp_dec, humi_dec = dht.read(pin)
    
    if status == dht.OK then
        print("DHT temperature is: " ..temp.." Humidity is: "..humi)
    elseif status == dht.ERROR_CHECKSUM then
        print("Checksum error")
    elseif status == dht.ERROR_TIMEOUT then
        print("Timeout Error")
    end 
end)