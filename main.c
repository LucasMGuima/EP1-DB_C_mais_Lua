#include <stdarg.h>
#include <stdio.h>
#include <string.h>

#include <lauxlib.h>
#include <lua.h>
#include <lualib.h>

#include "command.h"
#include "kvs.h"
#include "main.h"

typedef struct _tuple{
  int valido;
  const char* mensagem;
} tuple;

//Declaração de funções
void error (lua_State *L, const char *fmt, ...);
tuple processar_entrada(lua_State *L, Command *command);

int main(int argc, char *argv[]) {
  char input[100];
  KVSstore *banco;

  lua_State* L = luaL_newstate();
  luaL_openlibs(L);

  luaL_dofile(L, "script.lua");

  // Inicializando KVS
  banco = kvs_create();

  printf("Execute algum comando. Exemplos:\n");
  printf("- ADD abc 1234 ---> Adiciona o valor 1234 na chave abc\n");
  printf("- GET abc ---> Retorna o valor da chave abc se existir\n");
  printf("- EXIT --->  sair do programa\n");

  for (;;) {
    // Imprime e mantém na mesma linha
    printf("> ");
    fflush(stdout);
    gets(input);

    Command command = get_command(input);

    // se igual, strcmp == 0
    if (!strcmp(command.command, "EXIT")) {
      printf("Inté!\n");
      break;
    } else if (!strcmp(command.command, "ADD")) {
      tuple resp = processar_entrada(L, &command);

      if(!resp.valido){
        printf("%s", resp.mensagem);
        printf("\n");
      }else{
        kvs_put(banco, command.key, command.value);
      }
    } else if (!strcmp(command.command, "GET")) {
      char *value = kvs_get(banco, command.key);
      command.value = value;
      tuple resp = processar_entrada(L, &command);

      printf("%s", resp.mensagem);
      printf("\n");
    } else {
      printf("Comando não reconhecido!\n");
    }
  }

  kvs_destroy(banco);
  return 0;
}

tuple processar_entrada(lua_State *L, Command *command){
  //Prepara a função
  lua_getglobal(L, "ProcessarEntrada");
  lua_pushstring(L, command->command);
  lua_pushstring(L, command->key);
  lua_pushstring(L, command->value);

  //Chama a função
  if(lua_pcall(L, 3, 2, 0) != 0){
    error(L, "error running function `ProcessarEntrada': %s",lua_tostring(L, -1));
  }

  //Coleta o retorno
  const char* mensagem = lua_tostring(L, -1);
  lua_pop(L, 1);
  int valido = lua_toboolean(L, -1);
  lua_pop(L, 1);
  lua_pop(L, 1);

  tuple resp;
  resp.valido = valido;
  resp.mensagem = mensagem;
  return resp;
}

void error (lua_State *L, const char *fmt, ...) {
  va_list argp;
  va_start(argp, fmt);
  vfprintf(stderr, fmt, argp);
  va_end(argp);
  lua_close(L);
  exit(EXIT_FAILURE);
}