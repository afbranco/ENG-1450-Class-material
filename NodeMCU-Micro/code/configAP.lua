local module = ... 
return function (parTab)
    ssid, pwd, ip  = parTab.ssid, parTab.pwd, parTab.ip
    package.loaded[module]=nil
    module = nil
    -- Conexao da rede Wifi como Ponto de Acesso (AP)
    wifi.ap.deauth();
    wifi.setmode(wifi.SOFTAP);
    wifi.ap.config({ssid=ssid,pwd=pwd});
    wifi.ap.setip({ip=ip,netmask="255.255.255.0",gateway=ip});
    ap_ip, ap_mask = wifi.ap.getip();
    print("AP IP Addr:",ap_ip);
    print(" ");
end
