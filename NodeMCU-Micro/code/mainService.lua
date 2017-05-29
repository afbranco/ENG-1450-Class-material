

local user = require("userScript")
local lastHeap=0;

local _html = {}
-- Tabela com os últimos valores selecionados nos controles select/options
local _lastValue={}


-- Funções para geração de diferentes textos HTML
_html.sensor = function (name,value, format, unit)
        return "<h3>".. (name or "--") ..": ".. string.format(format,(value or 0)) .. (unit or " ") .. "</h3>";
    end

_html.time = function ()
        local diffHeap = lastHeap - node.heap();
        lastHeap = node.heap();
        return "<h5>Tempo: " .. string.format("%.2f",tmr.now()/1000000.0) .. " segundos. Heap:" .. node.heap() .. " [" .. diffHeap .. "]" .. "</h5>";
    end
    
_html.booleanState = function (name, controlName, text_true, text_false)
        local lastVal = tonumber(_lastValue[controlName]) or 0;
        local part1 = "<p>" .. (name or "--") .. ":" ..  (((lastVal == 0) and (text_false or "False")) or (text_true or "True"))
        local part2 = "  :  <a href=\"?command=".. controlName .. ",value=1 \"><button><b>" .. text_true .. "</b></button></a> <a href=\"?command=".. controlName .. ",value=0\" ><button><b>" .. text_false .. "</b></button></a></p>";
        return  part1 .. part2
    end

_html.pin_wr = function (name,pinx, text_high, text_low)
        local part1 = "<p>" .. (name or "--") .. ":" ..  (((gpio.read(pinx) == 0) and (text_low or "Low")) or (text_high or "High"))
        local part2 = "  :  <a href=\"?pin=" .. (pinx or 0) .. ",value=1\"><button><b>" .. text_high .. "</b></button></a> <a href=\"?pin=".. (pinx or 0) .. ",value=0 \"><button><b>" .. text_low .. "</b></button></a></p>";
        return  part1 .. part2
    end

_html.pin_rd = function (name,pinx, text_high, text_low)
        return "<p>" .. (name or "--") .. ":" ..  (((gpio.read(pinx) == 0) and (text_low or "Low")) or (text_high or "High")) .. "</p>";
    end

_html.select = function (label,optTab,controlName)
        local lastVal = tonumber(_lastValue[controlName]) or 1;
        if type(optTab) ~= "table" then return "Erro na lista de opções"; end
        local text = "<label>" .. (label or "--") .. ":</label> <select id=\"".. (controlName or "a") .. "_opt\" onchange=\"selectChanged(event,true)\">";
        for k,v in ipairs(optTab) do
            text = text .. "<option value=" .. k .. ((lastVal==k and " selected") or " ") ..">" .. v .. "</option>";
        end
        text = text .. "</select>";
        text = text .. "<a id=\"".. (controlName or "a") .. "\" href=\"?command=".. controlName .. ",value=" .. lastVal .. "\"><button><b>Envia ".. label .. "</b></button></a></p></p>";
        return text;
    end
    
_html.slider = function (label,controlName, min, max)
        min = min or 0;
        max = max or 100;
        local lastVal = tonumber(_lastValue[controlName]) or min;
        local text = "<label>" .. label .. ": [" .. min .. ":" .. max .."] </label><br>";
        text = text .. "<input type=\"range\" name=\"" .. controlName .. "_sld\" id=\"" .. controlName .. "_sld\" value=\"" .. lastVal .. "\" min=\"".. min .. "\" max=\"".. max .. "\" onchange=\"selectChanged(event,true)\">";
        text = text .. "<input type=\"text\" id=\"" .. controlName .. "_val\" value=" .. (lastVal or 0) .. " readonly size=3>&nbsp"; 
        text = text .. "<a id=\"".. (controlName or "a") .. "\" href=\"?command=".. controlName .. ",value=" .. lastVal .. "\"><button><b>Envia ".. label .. "</b></button></a></p></p>";
        return text;
    end

_html.inText = function (label,controlName,size)
        size = size or 4;
        local lastVal = _lastValue[controlName] or "--";
        local text = "<label>" .. label .. " </label><br>";
        text = text .. "<input title='Use only alfanumeric and/or ()[]:;.,-_*' type=\"text\" id=\"" .. controlName .. "_val\" value=" .. lastVal .. " size=".. size .. " onchange=\"selectChanged(event,false)\">&nbsp"; 
        text = text .. "<a id=\"".. (controlName or "a") .. "\" href=\"?inputtext=".. controlName .. ",value=" .. lastVal .. "\"><button><b>Envia ".. label .. "</b></button></a></p></p>";
        return text;
    end

_html.outText = function (label, utext)
        local text = "<label>" .. (label or "") .. ": " .. (utext or "").. "</label><br>";
        return text;
    end

  
node.egc.setmode(node.egc.ALWAYS);
--tmr.alarm(1, 2000, 1, function() print("Heap="..node.heap()); end );

-- Processa as conexões Web/HTTP
local function mainService()
    print("Iniciando Servidor WEB.");
    local s = net.createServer(net.TCP) 
    s:listen(80,function (conn)
            conn:on("receive", 
                    function(client,request) 
            local a1, b1, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
    
            if(method == nil)then
                a1, b1, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
            end
            local _HTTP = {}
            if (request ~= nil)then
                for k, v in string.gmatch(request, "(%w+):%s*([%w%p]+)") do
                    --print("HTTP:", k,v)
                    _HTTP[k] = v;
                end
            end
            local _GET = {}
            if (vars ~= nil)then
                -- match: alfanumeric, . : ; * / ( ) [ ] 
                for k, v in string.gmatch(vars, "(%w+)=([%w.:_;%-*/\(\)%[%]]+)&*") do
                    _GET[k] = v;
                end
            end
            if _HTTP.Accept == "*/*" then return; end
    
            if _GET.pin then
                if user.execCommand.setPin then
                    user.execCommand.setPin(_GET.pin,_GET.value);
                else
                    print("Comando setPin() não implementado!")
                end
            end
    
            if _GET.command then
                _lastValue[_GET.command] = tonumber(_GET.value);
                if user.execCommand[_GET.command] then
                    user.execCommand[_GET.command](_lastValue[_GET.command]);
                else
                    print("Comando " .. (_GET.command or "--") .. " não implementado!")
                end
            end
            if _GET.inputtext then
                print(_GET.inputtext,_GET.value)
                _lastValue[_GET.inputtext] = _GET.value;
                if user.execCommand[_GET.inputtext] then
                    user.execCommand[_GET.inputtext](_lastValue[_GET.inputtext]);
                else
                    print("Comando " .. (_GET.inputtext or "--") .. " não implementado!")
                end
            end
            -- Executa sempre em todos requests
            if user.execCommand.newRequest then
                user.execCommand.newRequest();
            end
    
            -- Monta string HTML
-- Textos HTML constantes --
local html_pre = "HTTP/1.0 200 OK\r\nServer: nodemcu-httpserver\r\nContent-Type: text/html\r\nConnection: close\r\n\r\n"
local html_begin = [[
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body> <div>
<h1><u>PUC Rio - DEE/DI</u>
<a href=\".\"><button><b>Atualizar</b></button></a></p>
</h1>
<h2><i>NodeMCU Web Server</i></h2>
]]

local html_end =[[
</div></body>
<script>
function selectChanged(event,isNum){
    selId = event.target.id
    hrefId =  selId.substring(0,selId.length-4)
    document.getElementById(hrefId).href = (isNum?"?command=":"?inputtext=") + hrefId + ",value=" + event.target.value;
    if (document.getElementById(hrefId+"_val")) {
        document.getElementById(hrefId+"_val").value = event.target.value;
    }
}
</script>
</html>
]]
            local _html_text = html_pre .. html_begin .. user.page(_html)  .. html_end;
            client:send(_html_text,function (sk) 
                        sk:close();
                    end);
                     end) 

      end)
end

-- Enable or disable the print() output.
function _printOn(outStr) uart.write(0,outStr); end
function _printOff(outStr) end
function printOn() node.output(_printOn, 0); end
function printOff() node.output(_printOff, 0); end

-- Início da execução
if user.ap then
    require("configAP")(user.ap);
    user.setup();
    mainService();
else
    if user.station then
        user.setup();
        require("configStation")(user.station,mainService);
    else
        print("Error: Missing user.ap or user.station");
    end
end


