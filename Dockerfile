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
# compileaso -> g++ -std=c++17 *.cpp -o out -lgtest -lcrypto -lpthread
RUN echo "alias compileaso='g++ -std=c++17 *.cpp -o out -lgtest -lcrypto -lpthread'" >> ~/.bashrc
RUN echo "alias compileaso-debug='g++ -std=c++17 *.cpp -o out -lgtest -lcrypto -lpthread -g'" >> ~/.bashrc


# Definir o diretório de trabalho
WORKDIR /workspace

# Comando padrão
CMD ["/bin/bash"]
