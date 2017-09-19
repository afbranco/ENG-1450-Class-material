-- ************************************************************
--    Programa exemplo utilizando a biblioteca "webSupport.lua"
-- ************************************************************
local user = {}
user.ap={ssid="LCA-10",pwd="12345678",ip="192.168.3.1"}
--user.station={ssid="terra_iot",pwd="projeto_iot"}

local gbl={
    -- Configuração pin do LED
    ledPin = 3,
    -- Configutação do sensor DHT11
    dhtPin = 4,

    -- Sensor values
    temperature = 0.0,
    humidity = 0.0,
}

function user.setup()
    -- ----------------------------------------------------------
    -- Configurações dos pinos utilizados
    -- ----------------------------------------------------------
    gpio.mode(gbl.ledPin, gpio.OUTPUT)
    gpio.write(gbl.ledPin, gpio.LOW);
    -- Coonfiguração UART/Serial
    uart.setup(0, 57600, 8, uart.PARITY_NONE, uart.STOPBITS_1, 1);

end

-- ----------------------------------------------------------
-- Definição/Customização da Interface WEB
-- ----------------------------------------------------------
function user.page(html)
    local page="";
    page = page .. html.outText("Texto","Meu texto... ");
    page = page .. html.time();
    page = page .. html.booleanState("UART","uartDir","PIC","USB");
    page = page .. html.sensor("Temperatura",gbl.temperature,"%2.1f","&#8451;");
    page = page .. html.sensor("Umidade",gbl.humidity,"%2.1f","%");
    page = page .. html.pin_wr("Led 1",gbl.ledPin, "ON", "OFF");
    page = page .. html.pin_rd("Led 2",gbl.ledPin, "Aceso", "Apagado");
    page = page .. html.select("Acoes",{"Comando 1", "Comando 2", "Comando 3", "Comando 4"},"action");
    page = page .. html.select("Teste",{"Opt1", "Opt2"},"myOpts");
    page = page .. html.slider("Slider", "mySlider",0,255);
    page = page .. html.inText("InText", "myInText",10);
    return page;
end

-- ----------------------------------------------------------
-- Tratadores dos comandos do usuário para os select/options, sliders e setPin
-- ----------------------------------------------------------
user.execCommand = {

-- Função chamada após cada comando select/options, sliders e setPin.
-- É executado antes de montar a página HTML
newRequest = function()
        local status, temp, humi, temp_dec, humi_dec = dht.read(gbl.dhtPin)
        if status == dht.OK then
            gbl.temperature = temp;
            gbl.humidity = humi;
        end
    end,
-- Função chamada para todos setPins
setPin = function(pin,value)
        gpio.write(pin,value);
        print("setPin_"..pin .." = " .. value);
    end,
-- Funções chamadas para cada controle configurado. Definir para cada "id" de controle
uartDir = function(value)
        local nValue = tonumber(value);
        if (nValue == 0) then printOn(); else printOff(); end
        uart.alt(nValue);
    end,
myOpts = function(value)
        print("myOpt:", value);
    end,
action = function(value)
        print("Action:", value);
        uart.write(0,"Teste Uart:",value);
    end,
mySlider = function(value)
        print("mySlider:", value);
    end,
myInText = function(value)
        print("myInText:", value);
    end,

}

return user;

