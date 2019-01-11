wifi.setmode(wifi.STATION)
wifi.sta.config("FiOS-DC10Q","ron6039dean7358ana")

print("Fetching IP Address...")

tmr.alarm(1,2500, tmr.ALARM_AUTO, function()
    ip = wifi.sta.getip()
    if ip ~= nil then
        print("IP IS.."..ip)
        tmr.stop(1)
    else 
        print("Trying to fetch the IP address")
    end
end
)