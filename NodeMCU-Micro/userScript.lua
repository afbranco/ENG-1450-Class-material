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
    --uart.setup(0, 57600, 8, uart.PARITY_NONE, uart.STOPBITS_1, 1);

end

-- ----------------------------------------------------------
-- Definição/Customização da Interface WEB
-- ----------------------------------------------------------
function user.page(html)
    local page="";
    page = page .. html.time();
    page = page .. html.booleanState("UART","uartChange","PIC","USB");
    page = page .. html.sensor("Temperatura",gbl.temperature,"%2.1f","&#8451;");
    page = page .. html.pin_wr("Led 1",gbl.ledPin, "ON", "OFF");
    page = page .. html.select("Acoes",{"Ação 1", "Ação 2", "Ação 3", "Ação 4"},"action");
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
        print("setPin_"..pin .." = " .. value);
        gpio.write(pin,value);
    end,
-- Funções chamadas para cada controle configurado. Definir para cada "id" de controle
uartChange = function(value)
        -- Liga/Desliga a saída do print()
        if (value == 0) then printOn(); else printOff(); end
        -- Troca os pinos da UART USB <--> PinosAlternativos (D7,D8)
        uart.alt(value);
    end,
action = function(value)
        print("Action:", value);
        uart.write(0,"Teste Uart:",string.format("%d",value));
    end,
}

return user;

