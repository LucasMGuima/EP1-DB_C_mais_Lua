function ProcessarEntrada(comando, chave, valor)
    if string.match(comando, "ADD") then
        if string.find(chave, "cpf_") then 
            return ValidarCpf(valor) 
        elseif string.find(chave, "data_") then 
            return ValidarData(valor)
        else return true, ""
        end
    elseif string.match(comando, "GET") then
        if string.find(chave, "cpf_") then
            return FormatarCpf(valor)
        elseif string.find(chave, "data_") then
            return FormatarData(valor)
        else return true, ""
        end
    end
end

function ValidarCpf(cpf)
    local prim_verificador = string.sub(cpf, -2, -2)
    local segundo_verificador = string.sub(cpf, -1)

    -- Calcula o primiero digito validador
    local pos_numBase = 1
    local sum_d1 = 0
    for i = 10, 2, -1
    do
        local num_s = string.sub(cpf, pos_numBase, pos_numBase)
        pos_numBase = pos_numBase + 1
        local num = tonumber(num_s)

        sum_d1 = sum_d1 + (num*i)
    end

    local r = sum_d1 % 11
    local d1 = 0
    if r > 1 then d1 = 11 - r end

    -- Verifica se o primeiro digito e igual ao digito informado, se nao retorna
    if d1 ~= tonumber(prim_verificador) then return false, "O primeiro digito valiador e invalido" end
    
    -- Calcula o segundo digito validador
    pos_numBase = 2
    local sum_d2 = 0
    for i = 10, 2, -1
    do
        local num_s = string.sub(cpf, pos_numBase, pos_numBase)
        pos_numBase = pos_numBase + 1
        local num = tonumber(num_s)
        
        sum_d2 = sum_d2 + (num*i)
    end

    r = sum_d2 % 11
    local d2 = 0
    if r > 1 then d2 = 11 - r end
    
    -- Verifica se o segundi digito e iagual ao digito informado, se nao retorna
    if d2 ~= tonumber(segundo_verificador) then return false, "O segundo digito validador e invalido" end

    -- Se chegou até aqui o cpf e valido, retorna true
    return true, ""
end

function FormatarCpf(cpf)
    local cpf_formatado = string.format("%s.%s.%s-%s", string.sub(cpf, 1, 3), string.sub(cpf, 4, 6), string.sub(cpf, 7, 9), string.sub(cpf, -2, -1))
    return true, cpf_formatado
end

function ValidarData(data)
    -- Verifica se o formato da data é valido, se nao for retrona false
    if string.match(data, "%d[4][-]%d[2][-]%d[2]") == false then
        return false, "A data nao esta no formato YYYY/MM/DD"
    end

    -- Coleta as inforamcoes da data
    local data_parte = {}
    local num = 1;
    for i in string.gmatch(data, "%d+")
    do
        data_parte[num] = i
        num = num + 1
    end
    local ano = data_parte[1]
    local mes = data_parte[2]
    local dia = data_parte[3]
    -- Verifica se o mes é valido, se invalido retrona false
    if tonumber(mes) > 12 or tonumber(mes) < 1 then
        return false, "Mes entrado invalido"
    end
    -- Verifica se o dia é valido, se invalido retorna false
    if tonumber(dia) > 31 or tonumber(dia) < 1 then 
        return false, "Dia entrado invalido"
    end
    -- Verifica se o ano é valido, se invalido retrona false
    if tonumber(ano) < 1 then
        return false, "Ano entrado invalido"
    end

    -- Se a data for valida retorna true
    return true, ""
end

function FormatarData(data)
    local data_parte = {}
    local num = 1;
    for i in string.gmatch(data, "%d+")
    do
        data_parte[num] = i
        num = num + 1
    end
    local ano = data_parte[1]
    local mes = data_parte[2]
    local dia = data_parte[3]
    local data_formatada = string.format("%02d/%02d/%04d", dia, mes, ano)
    return true, data_formatada
end