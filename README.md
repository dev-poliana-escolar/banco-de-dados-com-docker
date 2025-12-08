# banco-de-dados-com-docker
este repositório vai versionar meus arquivos docker e scripts mysql


---

# Como instalar o Docker (via terminal)?
> Nota: Eu utilizo o Linux Mint que é baseado no Ubuntu

```bash
sudo apt install docker.io
docker --version #ver se instalou corretamente
```

Para criar volumes é necessario instalar o `docker compose`;

```bash 
sudo apt install docker-compose-v2
sudo docker compose up -d # rodar o container existente
sudo docker exec -it turma-db mysql -u root -p # executar o container e depois colocar a senha
sudo docker exec turma-db mysqldump -u root -p nome_database > nome_database.sql # converter automaticamente
mysql -u root -p < empresa_treinamento.sql # importar sql

```