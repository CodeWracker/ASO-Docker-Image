# Usar a imagem oficial do Ubuntu como base
FROM ubuntu:20.04

# Desativar interações durante a instalação de pacotes
ENV DEBIAN_FRONTEND=noninteractive

# Atualizar os pacotes e instalar as dependências necessárias
RUN apt-get update && apt-get install -y \
    libssl-dev \
    cmake \
    g++ \
    gdb \
    valgrind \
    git

# Clonar e instalar o Google Test
RUN apt install libgtest-dev -y
RUN cd /usr/src/gtest && cmake CMakeLists.txt && make 

# Cria um alias permanente para compilar os programas
RUN echo "alias compileaso='shopt -s nullglob; cpp_files=(*.cpp); c_files=(*.c); cmd=\"g++ -std=c++17\"; [[ \${#cpp_files[@]} -ne 0 ]] && cmd=\"\$cmd \${cpp_files[*]}\"; [[ \${#c_files[@]} -ne 0 ]] && cmd=\"\$cmd \${c_files[*]}\"; \$cmd -o out -lgtest -lcrypto -lpthread; shopt -u nullglob'" >> ~/.bashrc
RUN echo "alias compileaso-debug='shopt -s nullglob; cpp_files=(*.cpp); c_files=(*.c); cmd=\"g++ -std=c++17\"; [[ \${#cpp_files[@]} -ne 0 ]] && cmd=\"\$cmd \${cpp_files[*]}\"; [[ \${#c_files[@]} -ne 0 ]] && cmd=\"\$cmd \${c_files[*]}\"; \$cmd -o out -lgtest -lcrypto -lpthread -g; shopt -u nullglob'" >> ~/.bashrc
# --------------------------------------------------------------
# Alias: compileaso e compileaso-debug
# 
# Estes aliases são usados para compilar arquivos C e C++ no diretório atual.
# Eles verificam a presença de arquivos .cpp e .c e, em seguida, constroem um comando g++ apropriado.
# 
# - `shopt -s nullglob`: Garante que, se não houver correspondência para os padrões *.cpp ou *.c, 
#   eles se expandam para uma lista vazia em vez de si mesmos.
# 
# - `cpp_files=(*.cpp)`: Cria um array com todos os arquivos .cpp no diretório atual.
# 
# - `c_files=(*.c)`: Cria um array com todos os arquivos .c no diretório atual.
# 
# - O comando g++ é construído dinamicamente com base na presença de arquivos .cpp e .c.
# 
# - `-lgtest -lcrypto -lpthread`: São flags para linkar as bibliotecas gtest, crypto e pthread.
# 
# - A diferença entre os aliases é a flag `-g` no `compileaso-debug`, que é usada para compilação com informações de depuração.
# 
# - `shopt -u nullglob`: Desativa a opção nullglob após a compilação.
# --------------------------------------------------------------


# alias cls para clear
RUN echo "alias cls='clear'" >> ~/.bashrc

# Definir o diretório de trabalho
WORKDIR /workspace

# Comando padrão
CMD ["/bin/bash"]
