# PSET 1
Diretório criado para as entregas do PSET1 matéria Banco de Dados 1 do curso de Sistemas de Informação da UVV.

## Objetivos deste PSET
1. Aprender sobre sistemas de controles de versões, em especial o Git (https://git-scm.com/) e o serviço web GitHub (https://github.com);
2. Aprender sobre Markdown, em geral, e sobre a versão GitHub Flavored Markdown;
3. Aprender a implementar projetos lógicos de bancos de dados utilizando o PostgreSQL, o Sistemas de Gerenciamento de Bancos de Dados (SGBD) open source mais avançado que existe hoje em dia;
4. Refletir sobre diversos problemas que podem ocorrer se o projeto lógico está mal preparado; e
5. Aprender a Structured Query Language (SQL) em nível básico e intermediário.

## Meus passos seguindo os do PSET para a implementação do projeto

1- Abri o terminal Linux e me tornei um superusuario:
```
su -
```

2- Atualizei o Linux e outros softwares com:
```
yum -y check-update; yum -y update
```

3- Me conectei ao usuário postgre e inseri a senha para prosseguir com os passos:
```
psql -U postgres -W
```

4- Criei meu usuário que será dono do banco de dados que faremos, ele tem senha e permissões de criar bancos e roles:
```
CREATE USER "barbara_caetano" WITH CREATEDB CREATEROLE PASSWORD 'babi123';
```

5- Depois de criar usuário, conectei nele:
```
\c postgres barbara_caetano;
```

6- Com usuário logado, criei o banco de dados, atribuindo meu usuário como dono e algumas outras opções exigidas no pset:
```
CREATE DATABASE uvv
    WITH OWNER = barbara_caetano
         TEMPLATE = template0
         ENCODING = 'UTF8'
         LC_COLLATE = 'pt_BR.UTF-8'
         LC_CTYPE = 'pt_BR.UTF-8'
         ALLOW_CONNECTIONS = true;
```

7- Após criar o bancom adicionei um comentário nele:
```
COMMENT ON DATABASE uvv IS 'Banco de Dados UVV criado para as atividades do PSET1';
```

9- Aqui conectei a bacno, depois de criar ele:
```
\c uuv;
```

10- Como pedido, criei o schema lojas dando autorização ao meu usuário:
```
CREATE SCHEMA lojas AUTHORIZATION barbara_caetano;
```

11- Após criar o schema, precisei tornar ele como padrão, pois o padrão é o schema "public":
```
SELECT CURRENT_SCHEMA(); (Para confirmar o schema padrão "public")
```
```
SHOW SEARCH_PATH --(Para vizualizar a ordem dos schemas)
```
```
SET SEARCH_PATH TO lojas, "barbara_caetnao", public; --(Alterar o schema para o "lojas")
```
```
ALTER USER barbara_caetano SET SEARCH_PATH TO lojas, "barbara_caetano", public; --(Como o comando anterior altera o schema temporariamente, usamos esse para deixar permanente)
```
```
SHOW SEARCH_PATH --(Para confirmar a troca)
```

12- Depois de tudo pronto, criei as tabelas rodando um script de CREATE TABLE por vez gerados pelo SQL Power Architect após criar o modelo relacional lá:
```
CREATE TABLE lojas.produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT produto_id PRIMARY KEY (produto_id)
);
COMMENT ON TABLE lojas.produtos IS 'Tabela para dados dos produtos das lojas.';
COMMENT ON COLUMN lojas.produtos.produto_id IS 'Primary Key(PK) da tabela. Representa os IDs dos produtos.';
COMMENT ON COLUMN lojas.produtos.nome IS 'Coluna de nomes dos produtos.';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'Coluna de preços unitários dos produtos.';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'Coluna de detalhes dos produtos.';
COMMENT ON COLUMN lojas.produtos.imagem IS 'Coluna de imagens dos produtos em blob.';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'Coluna de imagens em MIME.';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'Coluna os arquivos de imagens.';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'Coluna de charset das imagens.';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'Coluna de data com a ultima atualização das imagens dos produtos.';
```
```
CREATE TABLE lojas.lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT loja_id PRIMARY KEY (loja_id)
);
COMMENT ON TABLE lojas.lojas IS 'Tabela para dados das lojas.';
COMMENT ON COLUMN lojas.lojas.loja_id IS 'Primary Key(PK) da tabela. Representa os IDs das lojas.';
COMMENT ON COLUMN lojas.lojas.nome IS 'Coluna de nomes das lojas';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'Coluna de endereços web(URL) das lojas.';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'Coluna de endereços físicos das lojas.';
COMMENT ON COLUMN lojas.lojas.latitude IS 'Coluna com as informações de latitude das lojas.';
COMMENT ON COLUMN lojas.lojas.longitude IS 'Coluna com as informações de longitude das lojas.';
COMMENT ON COLUMN lojas.lojas.logo IS 'Coluna com a logo em blob da loja.';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'Coluna com logo em MIME.';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'Coluna de arquivo da logo.';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'Coluna com charset da logo.';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'Coluna com a data da última atualização da logo.';
```
```
CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoque_id PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE lojas.estoques IS 'Tabela para armazenar os dados de estoque das lojas.';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'Primary Key(PK) da tabela. Representa os IDs dos estoques.';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'Foreign Key(FK) da tabela. Representa os IDs das lojas.';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'Foreign Key(FK) da tabela. Representa os IDs dos produtos.';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'Coluna com a quantidade de estoque.';
```
```
CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT cliente_id PRIMARY KEY (cliente_id)
);
COMMENT ON TABLE lojas.clientes IS 'Tabela para dados dos clientes.';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'Primary Key(PK) da tabela. Representa os IDs dos clientes.';
COMMENT ON COLUMN lojas.clientes.email IS 'Coluna de emails dos clientes.';
COMMENT ON COLUMN lojas.clientes.nome IS 'Coluna de nomes dos clientes.';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'Coluna de número de telefone dos clientes.';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'Coluna para o segundo número de telefone dos clientes.';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'Coluna para o terceiro número de telefone dos clientes.';
```
```
CREATE TABLE lojas.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envio_id PRIMARY KEY (envio_id)
);
COMMENT ON TABLE lojas.envios IS 'Tabela para armazenar os dados enviados das lojas  para os clientes.';
COMMENT ON COLUMN lojas.envios.envio_id IS 'Primary Key(PK) da tabela. Representa os IDs dos envios das lojas.';
COMMENT ON COLUMN lojas.envios.loja_id IS 'Foreign Key(FK) da tabela. Representa os IDs das lojas.';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'Foreign Key(FK) da tabela. Representa os IDs dos clientes.';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'Coluna com endereços de onde os produtos serão entregues.';
COMMENT ON COLUMN lojas.envios.status IS 'Coluna de status dos envios.';
```
```
CREATE TABLE lojas.pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_id_1 PRIMARY KEY (pedido_id)
);
COMMENT ON TABLE lojas.pedidos IS 'Tabela para armazenar os dados dos pedidos dos clientes e das lojas.';
COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'Primary Key(PK) da tabela. Representa os IDs dos pedidos.';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'Coluna com as informalções de data e hora do pedido.';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'Foreign Key(FK) da tabela. Representa os IDs dos clientes.';
COMMENT ON COLUMN lojas.pedidos.status IS 'Coluna com os status dos pedidos.';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'Foreign Key(FK) da tabela. Representa os IDs das lojas.';
```
```
CREATE TABLE lojas.pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT pedido_id PRIMARY KEY (pedido_id, produto_id)
);
COMMENT ON TABLE lojas.pedidos_itens IS 'Tabela com os dados dos itens dos pedidos.';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'Primary Foreign Key(PFK) da tabela. Representa os IDs dos pedidos.';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'Primary Foreign Key(PFK) da tabela. Representa os IDs dos produtos.';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'Coluna de números das linhas dos pedidos.';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'Coluna de preços unitários dos pedidos.';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'Coluna com a informação da quantidade de itens dos pedidos.';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'Foreign Key(FK) da tabela. Representa os IDs dos envios.';
```

13- Após criar as tabelas, fiz as alterações com os ALTER TABLE rodando um script por vez gerados pelo SQL Power Architect após criar o modelo relacional lá:
```
ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE; - OK
```
```
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE; - OK
```
```
ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE; - OK
```
```
ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE; - OK
```
```
ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE; - OK
```
```
ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE; - OK
```
```
ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE; - OK
```
```
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE; - OK
```
```
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE; - OK
```
14- Após finalizar no geral as criações das tabelas, fiz algumas restrições checagens sugeridas:

-- Restrição de valores não negativos na coluna "preco_unitario" da tabela "pedidos_itens"
```
ALTER TABLE lojas.pedidos_itens
    ADD CONSTRAINT pedidos_itens_preco_unitario_check
    CHECK (preco_unitario >= 0);
```

-- Restrição de valores não negativos na coluna "quantidade" da tabela "pedidos_itens"
```
ALTER TABLE lojas.pedidos_itens
    ADD CONSTRAINT pedidos_itens_quantidade_check
    CHECK (quantidade >= 0);
```

15- E depois, as restrições de checagens exigidas no pset:

-- Restrição de valores permitidos na coluna "status" da tabela "pedidos"
```
ALTER TABLE lojas.pedidos
    ADD CONSTRAINT pedidos_status_check
    CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));
```

-- Restrição de valores permitidos na coluna "status" da tabela "envios"
```
ALTER TABLE lojas.envios
    ADD CONSTRAINT envios_status_check
    CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));
```
-- Restrição de preenchimento obrigatório de pelo menos uma coluna de endereço na tabela "lojas"
```
ALTER TABLE lojas.lojas
    ADD CONSTRAINT lojas_endereco_check
    CHECK (endereco_fisico IS NOT NULL OR endereco_web IS NOT NULL);
```

16- Por fim, organizei meu repositório, fazendo as subidas em uma branch que abri para desenvolvimento e quando estava tudo pronto, mesclei para a main.

-- FIM --
