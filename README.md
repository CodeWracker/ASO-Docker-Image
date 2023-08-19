# ASO-Docker-Image

Repositório para compartilhar a imagem para a disciplina de Arquitetura de Sistemas Operacionais (funciona para Estrutura de Dados com o Martin tb)

# Guia Básico para Usar a Imagem Docker `ubuntu-aso`

## 1. Instalação do Docker

### Windows

1. Acesse o site oficial do Docker em [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop) e baixe o Docker Desktop para Windows.
2. Execute o instalador e siga as instruções na tela.
3. Após a instalação, inicie o Docker Desktop. Você verá um ícone do Docker na barra de tarefas, indicando que o Docker está em execução.
4. Atualise o WSL com: `wsl --update`

## 2. Construir a Imagem Docker

1. Abra o terminal (PowerShell ou CMD) no Windows.
2. Navegue até a pasta onde você tem o `Dockerfile` e o `docker-compose.yml`.
3. Altere o nome da pasta para o mirror com o container em `docker-compose.yml`
4. Execute o seguinte comando para construir a imagem: `docker-compose build`

Isso construirá a imagem com o nome `ubuntu-aso`.

## 3. Executar e Acessar o Container

1. Para iniciar um container a partir da imagem que você construiu, use: `docker-compose up -d`

> O argumento `-d` significa "detached", o que significa que o container será executado em segundo plano.

2. Para saber o nome da sua imagem (não é exatamente o `ubuntu-aso`) execute o comando: `docker-compose ps`

> Copie o NAME do container
> ![image](https://github.com/CodeWracker/ASO-Docker-Image/assets/42501669/17d0ec85-bff7-4705-b4f7-cd4a3526c33f)

3. Para acessar o bash do container em execução: `docker exec -it <NAME> /bin/bash`

> ![image](https://github.com/CodeWracker/ASO-Docker-Image/assets/42501669/4440bd49-0dfe-4f22-868d-cf48b50aa9d3)
> Isso abrirá uma sessão bash interativa dentro do container, onde você pode executar comandos diretamente no ambiente Ubuntu.

4. Para sair da sessão bash do container, digite: `exit`

## 4. Parar o Container

Quando terminar de usar o container, você pode pará-lo com: `docker-compose down`

## 5. Comandos Personalizados

Dentro do container, foram definidos alguns comandos personalizados (aliases) para facilitar a compilação de seus programas:

- **compileaso**: Este comando compila todos os arquivos `.cpp` no diretório atual usando o padrão C++17 e vincula as bibliotecas `gtest`, `crypto` e `pthread`. O executável resultante é nomeado `out`. Para usar, simplesmente digite: `compileaso`

> Após a execução, você pode rodar seu programa com `./out`.

- **compileaso-debug**: Similar ao `compileaso`, mas inclui informações de depuração (flag `-g`). Isso é útil se você estiver usando um depurador como o `gdb`. Para usar, digite: `compileaso-debug`

> Assim como antes, você pode rodar seu programa com `./out`.

Estes comandos foram criados para agilizar o processo de compilação e permitir que você se concentre no desenvolvimento. Se você adicionar mais arquivos `.cpp` ao seu projeto, eles serão automaticamente incluídos na compilação ao usar esses comandos.

## 6. Usando o GDB para Depuração

O GDB (GNU Debugger) é uma ferramenta poderosa para depurar programas. Se você compilou seu programa com o comando `compileaso-debug`, você pode usar o GDB para depurá-lo.

1. Inicie o GDB com seu programa: `gdb ./out`
2. No prompt do GDB, você pode definir pontos de interrupção usando o comando `break` (ou `b` para abreviar). Por exemplo, para definir um ponto de interrupção na função `main`, digite: `break main`
3. Execute seu programa dentro do GDB com: `run`

> O programa irá parar quando atingir um ponto de interrupção.

4. No GDB, você tem vários comandos à sua disposição, como:

- `next` (ou `n`): Executa a próxima linha de código.
- `step` (ou `s`): Entra em uma função.
- `continue` (ou `c`): Continua a execução até o próximo ponto de interrupção.
- `print` (ou `p`): Imprime o valor de uma variável. Por exemplo, `print minhaVariavel`.

5. Quando terminar a depuração, você pode sair do GDB com o comando `quit` ou simplesmente `q`.

## 7. Usando o Valgrind

O Valgrind é uma ferramenta de análise que ajuda a detectar vazamentos de memória e outros problemas relacionados à memória.

1. Para executar seu programa sob o Valgrind, use: `valgrind ./out`

> Isso executará seu programa e, ao final, o Valgrind fornecerá um resumo de quaisquer problemas de memória detectados.

2. Para uma análise mais detalhada, especialmente para detectar vazamentos de memória, use: `valgrind --leak-check=full ./out`

> Isso fornecerá informações detalhadas sobre qualquer vazamento de memória detectado, incluindo onde a memória foi alocada.

Lembre-se de que, para obter os melhores resultados com o Valgrind, é útil compilar seu programa com informações de depuração (usando `compileaso-debug`).
