# Como instalar o Docker (via terminal)

## Sumário
1. [Instalação](#instalação)
2. [Manual de utilização](#manual-de-utilização)
3. [Casos](#casos)\
    3.1 [Método 1](#método-1---mais-rápido-mas-com-limitações-menos-recomendado)\
    3.2 [Método 2](#método-2---mais-simples-rápido-e-quase-automatico)

---


# Instalação
> Nota: Linux Mint (baseado em Ubuntu). Em outras distribuições, o comando de instalação pode variar.

```bash 
sudo apt install docker.io
docker --version   # verificar se instalou corretamente
```

## Manual de utilização

1. Instalar o Docker Compose:
    ```bash
    sudo apt install docker-compose-v2
    ```

2. Subir o container:
    ```bash
    sudo docker compose up -d 
    sudo docker compose stop #para fechar o container sem perder os dados.
    ```

3. Acessar o MySQL dentro do container:
    ```bash
    sudo docker exec -it turma-db mysql -u root -p
    ```

4. Gerar um arquivo .sql (backup com mysqldump):
    ```bash
    sudo docker exec turma-db mysqldump -u root -p nome_database > nome_database.sql
    ```

5. Importar um arquivo .sql para dentro do container:
    > Se ele estiver dentro de uma pasta, entre nela antes de fazer o comando a seguir:
    ```bash
    sudo docker exec -i turma-db mysql -u root -p nome_database < arquivo.sql
    ```

---

# Casos

## Método 1 - Mais rápido, mas com limitações (menos recomendado)

É menos recomendado, pois é necessário ficar copiando do o arquivo de log do container. 

### 1. Precisa salvar o historico inteiro do terminal mysql?
```bash
sudo docker cp turma-db:/root/.mysql_history ~/Faculdade/banco-de-dados-com-docker/history.sql
# copie do container (turma-db:/root/.mysql_history)
# para o destino(~/Faculdade/banco-de-dados-com-docker/history.sql)
```
 > Esse método é mais rápido, mas é preciso ajustar o arquivo (remover o `\040` com `Ctrl`+`h`) e as permissões dele. 


### 2. Salvar o historico de forma dinâmica em cada sessão?
1. Utiliza-se comando `tee`:

    ```mysql
    tee /tmp/academico2_sessao1.log
    ```
    > `tee /tmp/<nome_da_sessao.log>`

2. Encerrar gravação:
    ```mysql
    notee
    ```
3. Saia do prompt mysql, copie o arquivo para o host:
    ```bash
    sudo docker cp turma-db:/tmp/<nomedasessao.log> ~Faculdade/banco-de-dados/banco-de-dados-com-docker/<nomedasessao.log>
    ```
4. Mude a permisao se necessário:
    ```bash
    sudo chown user:user caminho-do-arquivo #existem outras formas, mas no meu caso é mais rapido assim.
    ```

## Método 2 - Mais simples, rápido e quase automatico

1. Você precisa atualizar a estrutura do `compose` na seção de `[volumes]`:
    ```yaml
    services:
    db:
        image: mysql:8.0
        container_name: turma-db
        restart: always
        environment:
        MYSQL_ROOT_PASSWORD: 1234
        MYSQL_DATABASE: escola_db
        ports:
        - "3306:3306"
        volumes:
        - meus-dados-mysql:/var/lib/mysql
        - ./historicos:/historicos #pasta de historico
        - ./scripts:/scripts #pasta de scripts

    volumes:
    meus-dados-mysql:

    ```

2. Subir o container atualizado
    ```bash
    sudo docker compose down # Isso vai DELETAR o seu antigo (optei por excluir)
    sudo docker compose up -d # Subir o container novamente
    ```
3. Mudar as permissões das pastas criadas:
    ```bash
    sudo chown <user>:<user> ~/caminho/scripts
    sudo chown <user>:<user> ~/caminho/historicos
    ```

4. Ser feliz\
    Ao executar o comando `tee` no mysql, você deve: 
    ```mysql
    tee /historicos/arquivo.log
    ```
    > Não irá mais precisar fazer `sudo docker cp`
