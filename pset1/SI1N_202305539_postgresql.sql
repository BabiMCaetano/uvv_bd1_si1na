/* SCRIPT GLOBAL PARA O PSET1
NELE CONTÉM TODOS OS PASSOS QUE SEGUI
E OS SCRIPTS QUE FIZ */

-- Apagar o banco de dados uvv:
DROP DATABASE IF EXISTS uvv;

-- Apagar usuário:
DROP USER IF EXISTS barbara_caetano;

-- Criar usuário com senha e permissões de criar bancos e roles:
CREATE USER "barbara_caetano" 
	WITH 
		CREATEDB 
		CREATEROLE 
		PASSWORD 'babi123';
	
-- Trocar conexão para usuário criado
\c postgres barbara_caetano;

-- Criar banco de dados UVV
CREATE DATABASE uvv
    WITH OWNER = barbara_caetano
         TEMPLATE = template0
         ENCODING = 'UTF8'
         LC_COLLATE = 'pt_BR.UTF-8'
         LC_CTYPE = 'pt_BR.UTF-8'
         ALLOW_CONNECTIONS = true;

-- Adicionar comentário ao banco de dados:
COMMENT ON DATABASE uvv IS 'Banco de Dados UVV criado para as atividades do PSET1';

-- Conectar ao banco criado
\c uvv;

-- Criar schema lojas
CREATE SCHEMA lojas AUTHORIZATION barbara_caetano;

-- Ajustar search path
SET SEARCH_PATH TO lojas, "$user", public;
ALTER USER barbara_caetano SET SEARCH_PATH TO lojas, "$user", public;
SHOW SEARCH_PATH;

-- Criar tabelas:
-- Criar tabela "produtos" com comentario para a tabela e as colunas:
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

-- Criar tabela "lojas" com comentario para a tabela e as colunas:
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

-- Criar tabela "estoques" com comentario para a tabela e as colunas:
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

-- Criar tabela "clientes" com comentario para a tabela e as colunas:
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

-- Criar tabela "envios" com comentario para a tabela e as colunas:
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

-- Criar tabela "pedidos" com comentario para a tabela e as colunas:
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

-- Criar tabela "pedidos_itens" com comentario para a tabela e as colunas:
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

-- Alterar as tabelas

ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Adicionar restrições de checagem:
-- Coluna "preco_unitario" da tabela "pedidos_itens" não pode ter valores negativos
ALTER TABLE lojas.pedidos_itens
    ADD CONSTRAINT pedidos_itens_preco_unitario_check
    CHECK (preco_unitario >= 0);

-- Coluna "quantidade" da tabela "pedidos_itens" não pode ter valores negativos
ALTER TABLE lojas.pedidos_itens
    ADD CONSTRAINT pedidos_itens_quantidade_check
    CHECK (quantidade >= 0);

-- Determinar valores aceitos na coluna "status" da tabela "pedidos"
ALTER TABLE lojas.pedidos
    ADD CONSTRAINT pedidos_status_check
    CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

-- Determinar valores aceitos na coluna "status" da tabela "envios"
ALTER TABLE lojas.envios
    ADD CONSTRAINT envios_status_check
    CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

-- Preenchimento obrigatório de pelo menos uma coluna de endereço (fisico ou web) na tabela "lojas"
ALTER TABLE lojas.lojas
    ADD CONSTRAINT lojas_endereco_check
    CHECK (endereco_fisico IS NOT NULL OR endereco_web IS NOT NULL);
    
-- Listar tabelas
\d+