create database oficina;

use oficina;

create table clientes (
    id int auto_increment primary key,
    nome varchar(100) not null,
    email varchar(100) not null,
    telefone varchar(15),
    endereco varchar(200)
);

create table veiculos (
    id int auto_increment primary key,
    cliente_id INT,
    marca varchar(50) not null,
    modelovarchar(50) not null,
    ano int,
    placa varchar(10) not null,
    foreign key (cliente_id) references clientes(id) on delete cascade
);

create table servicos (
    id int auto_increment primary key,
    veiculo_id int,
    descricao varchar(200) not null,
    data_servico date,
    valor decimal(10, 2),
    foreign key (veiculo_id) references veiculos(id) on delete cascade
);

create table pecas (
    id int auto_increment primary key,
    descricao varchar(200) not null,
    quantidade int,
    preco_unitario decimal(10, 2)
);

-- Inserindo dados

INSERT INTO clientes (nome, email, telefone, endereco)
VALUES ('João da Silva', 'joao@example.com', '(11) 1234-5678', 'Rua A, 123');

INSERT INTO veiculos (cliente_id, marca, modelo, ano, placa)
VALUES (1, 'Chevrolet', 'Onix', 2020, 'ABC1234');

INSERT INTO servicos (veiculo_id, descricao, data_servico, valor)
VALUES (1, 'Troca de óleo', '2023-07-15', 150.00);

INSERT INTO pecas (descricao, quantidade, preco_unitario)
VALUES ('Filtro de óleo', 2, 20.00);

-- queries

-- Atualizar o telefone do cliente João da Silva
UPDATE clientes SET telefone = '(11) 9876-5432' WHERE id = 1;

-- Excluir um serviço específico
DELETE FROM servicos WHERE id = 1;

SELECT c.nome AS cliente, s.descricao AS servico, s.data_servico
FROM clientes c
JOIN veiculos v ON c.id = v.cliente_id
JOIN servicos s ON v.id = s.veiculo_id;

SELECT c.nome AS cliente, s.descricao AS servico, p.descricao AS peca
FROM clientes c
JOIN veiculos v ON c.id = v.cliente_id
JOIN servicos s ON v.id = s.veiculo_id
JOIN servico_pecas sp ON s.id = sp.servico_id
JOIN pecas p ON sp.peca_id = p.id;

SELECT s.id AS servico_id, s.descricao AS servico, SUM(p.preco_unitario * sp.quantidade) AS valor_total_pecas
FROM servicos s
JOIN servico_pecas sp ON s.id = sp.servico_id
JOIN pecas p ON sp.peca_id = p.id
GROUP BY s.id;

SELECT c.nome AS cliente, SUM(s.valor) AS valor_total_servicos
FROM clientes c
JOIN veiculos v ON c.id = v.cliente_id
JOIN servicos s ON v.id = s.veiculo_id
GROUP BY c.id
ORDER BY valor_total_servicos DESC;