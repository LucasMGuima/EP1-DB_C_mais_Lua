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

