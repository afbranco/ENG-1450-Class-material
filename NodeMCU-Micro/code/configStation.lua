local module = ... 
return function (parTab,cb_function)
    ssid, pwd = parTab.ssid, parTab.pwd
    package.loaded[module]=nil
    module = nil
    -- Conexao da rede Wifi como Station 
    wifi.setmode(wifi.STATION);
    wifi.sta.config({ssid=ssid,pwd=pwd,auto=true});
    tmr.alarm(1, 1000, tmr.ALARM_SEMI, function()
        print('.'); 
        if wifi.sta.getip() then
            print("\nGot IP:",wifi.sta.getip()); 
            if cb_function then cb_function(); end
        else
            tmr.start(1);
        end
    end );
end
