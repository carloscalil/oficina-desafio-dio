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

insert into clientes (nome, email, telefone, endereco)
values ('João da Silva', 'joao@example.com', '(11) 1234-5678', 'Rua A, 123');

insert into veiculos (cliente_id, marca, modelo, ano, placa)
values (1, 'Chevrolet', 'Onix', 2020, 'ABC1234');

insert into servicos (veiculo_id, descricao, data_servico, valor)
values (1, 'Troca de óleo', '2023-07-15', 150.00);

insert into pecas (descricao, quantidade, preco_unitario)
values ('Filtro de óleo', 2, 20.00);

-- queries


update clientes set telefone = '(11) 9876-5432' where

delete from servicos where id = 1;

select c.nome as cliente, s.descricao asservico, s.data_servico
from clientes c
join veiculos v on c.id = v.cliente_id
join servicos s on v.id = s.veiculo_id;

select c.nome as cliente, s.descricao as servico, p.descricao as peca
from clientes c
join veiculos v on c.id = v.cliente_id
join servicos s on v.id = s.veiculo_id
join servico_pecas sp on s.id = sp.servico_id
join pecas p ON sp.peca_id = p.id;

select s.id as servico_id, s.descricao as servico, SUM(p.preco_unitario * sp.quantidade) as valor_total_pecas
from servicos s
join servico_pecas sp on s.id = sp.servico_id
join pecas p on sp.peca_id = p.id
group by s.id;

select c.nome as cliente, sum(s.valor) as valor_total_servicos
from clientes c
join veiculos v ON c.id = v.cliente_id
join servicos s ON v.id = s.veiculo_id
group by c.id
order by valor_total_servicos desc;
