# EP01 - Banco de dados C + Lua

## Configurando
Configurando o ambiente para desenvolvimento:

<details>
<summary><b>Windows</b></summary>

1. Instalando o Lua
    
    Primeiro precisamos instalar o Lua em nosso computador, para isso podemos usar o programada criado pelo [rjpcomputing](https://github.com/rjpcomputing):

    >[LuaForWindows_v5.1.5-52](https://github.com/rjpcomputing/luaforwindows/releases/download/v5.1.5-52/LuaForWindows_v5.1.5-52.exe)

    Seguimos a instalação normalmente.

2. Gerando o executável

    Com o lua instalado, agora vamos gerar o excutavel do projeto. Para isso usamos o seginte comando

        gcc -o banco main.c command.c kvs.c -I"[pasta do lua]/include" -L"[pasta do lua]\lib" -llua51

    Agora temos nosso executável e podemos começar a desenvolver o programa.
</details>

## Usando o projeto
Para utilizar o projeto, precisamos apenas do excutavel *banco.exe* e do arquivo *script.lua*, podemos baixar apenas a pasta [banco](./banco) onde encontramos ambos os arquivos.

Agora basta executar o *banco.exe*, e seguir os passos informados.
> [!IMPORTANT]  
> Tanto o executavel banco.exe quanto o script.lua devem ficar na mesma pasta.

### Incrementando
Para incrementar o banco, pode colocar mais validadires e ou formatadores, para isso basta adicionalos ao arquivo *script.lua*. Basta seguir o padrão já existente.

<details>
<summary><b>Novo Validador</b></summary>

1. Chamando a função

    O novo validador deve ser chamado dentro da função **PorcessarEntrada**:
    ```Lua
        function ProcessarEntrada(comando, chave, valor)
            if string.match(comando, "ADD") then
                if string.find(chave, "cpf_") then 
                    return ValidarCpf(valor) 
                elseif string.find(chave, "data_") then 
                    return ValidarData(valor)
                elseif string.find(chave, [sua chave]) then
                    return [Chama sua função]
                else return true, ""
                end
                .
                .
                .
            end
        end
    ```
    Basta substituir onde encontramos **[sua chave]** pela sua chave, exemplo, criamos uma para armazenar telefones, logo nossa chave poderia ser **telefone_**.

    Quando chamamos a função que válida, precisamos apenas nos sertificarmos que retornamos se o valor é válido e uma mensagem, a mensagem pode ser vázia.

2. Sua função

    Aqui sua função pode fazer o processo que desejar, precisamos apenas retornar uma tupla de valores, sendo um se o valor é válido e o outro uma mensagem, podendo ser vázia.

</details>
<details>
<summary><b>Novo Formatador</b></summary>

1. Chamando a função

    O novo formatador deve ser chamado na função **ProcessarEntrada**:
    ```Lua
    function ProcessarEntrada(comando, chave, valor)
        .
        .
        .
        elseif string.match(comando, "GET") then
            if string.find(chave, "cpf_") then
                return FormatarCpf(valor)
            elseif string.find(chave, "data_") then
                return FormatarData(valor)
            elseif string.find(chave, [sua chave]) then
                return [Chama sua função]
            else return true, ""
            end
        end
    end
    ```
    Basta substituir onde encontramos **[sua chave]** pela sua chave, exemplo, queremos formatar telefones, logo nossa chave poderia ser **telefone_**.

    Quando chamamos a função que formata, precisamos apenas nos sertificarmos que retornamos true e a o valor formatado.

2. Sua função

    Aqui sua função pode fazer o processo que desejar, precisamos apenas retornar uma tupla de valores, sendo o valor true e o valor informado formatado.

</details>