# Como instalar o Docker (via terminal)

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

## 1. Precisa salvar o historico inteiro do terminal mysql?
```bash
sudo docker cp turma-db:/root/.mysql_history ~/Faculdade/banco-de-dados-com-docker/history.sql
# copie do container (turma-db:/root/.mysql_history)
# para o destino(~/Faculdade/banco-de-dados-com-docker/history.sql)
```
 > Esse método é mais rápido, mas é preciso ajustar o arquivo (remover o `\040` com `Ctrl`+`h`) e as permissões dele. 

## 2. Salvar o historico de forma dinâmica em cada sessão?
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