function ProcessarEntrada(comando, chave, valor)
    if string.match(comando, "ADD") then
        if string.find(chave, "cpf_") then 
            local valido, mensagem = ValidarCpf(valor)
            print(valido, mensagem)
            return false, mensagem
        elseif string.find(chave, "data_") then 
            return ValidarData(valor)
        end
     end
end

function ValidarCpf(cpf)
    local num_base = string.sub(cpf, 1,8)
    local dig_rf = string.sub(cpf, 9, 9)
    local prim_verificador = string.sub(cpf, -2, -2)
    local segundo_verificador = string.sub(cpf, -1)

    print(num_base, dig_rf, prim_verificador, segundo_verificador)

    return false, "CPF invalido entrado"
end

function FormatarCpf(cpf)
end

function ValidarData(data)
end

function FormatarData(data)
end