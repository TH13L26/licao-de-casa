create database db_cds;
use db_cds;

/*******************--1--*************************/

create table tb_artista(
	pk_id_codArt int primary key not null auto_increment,
    nome_art varchar(100)
);

describe tb_artista;
select * from tb_artista;

insert into tb_artista
(nome_art) value
('Anitta'),
('MC Rodolfinho'),
('Maiara e Maraisa');

/*******************--2--*************************/

create table tb_gravadora(
	pk_id_codGrav int primary key not null auto_increment,
    nome_Grav varchar(50)
);

describe tb_gravadora;
select * from tb_gravadora;

insert into tb_gravadora
(nome_grav) value
('Warner Music Brasil'),
('GR6 Music'),
('Som Livre');

/********************--3--************************/

create table tb_categoria(
	pk_id_codCat int primary key not null auto_increment,
    nome_cat varchar(50)
);

describe tb_categoria;
select * from tb_categoria;

insert into tb_categoria
(nome_cat) value
('POP'),
('Funk'),
('Sertanejo');

/********************--4--************************/

create table tb_Estado(
	pk_id_Sigla_Est char(2) primary key not null,
    Nome_Est char(50) 
);

drop table tb_Estado;

describe tb_Estado;
select * from tb_Estado;

insert into tb_Estado
(pk_id_Sigla_Est, Nome_Est) value
('RJ', 'Rio de Janeiro'),
('SP', 'São Paulo'),
('MG', 'Mato Grosso');

/*******************--5--*************************/

create table tb_cidade(
	pk_id_codCid int primary key not null auto_increment,
    fk_sigla_est varchar(2),
    nome_cid varchar(100)
);

alter table tb_cidade 
add constraint fk_sigla_est 
foreign key (fk_sigla_est)
references tb_Estado(pk_id_Sigla_Est);

drop table tb_cidade;

describe tb_cidade;
select * from tb_cidade;

insert into tb_cidade
(nome_cid) value
('Honório Gurgel'),
('Osasco'),
('São José dos Quatro Marcos');

/*********************--6--***********************/

create table tb_cliente(
	pk_id_codCli int primary key not null auto_increment,
    fk_id_codCid int,
    nome_cli varchar(100),
    end_cli varchar(200),
    renda_cli decimal(10,2) default '0',
    sexo_cli char(1) not null default 'f' check (sexo_cli in ('f', 'm')),
    
    foreign key (fk_id_codCid) references tb_cidade(pk_id_codCid)
);

-- alter table tb_cliente add constraint fk_id_codCid foreign key (fk_id_codCid) references tb_cidade(pk_id_codCid);

drop table tb_cliente;

describe tb_cliente;
select * from tb_cliente;

/*********************--7--***********************/
create table Conjuge(
    cod_cli int primary key not null,
    nome_conj varchar(100) not null,
    renda_conj decimal(10,2) not null default 0 check (renda_conj >= 0),
    sexo_conj char(1) not null default 'M' check (sexo_conj in ('F', 'M')),

    foreign key (cod_cli) references tb_cliente(pk_id_codCli)
);

describe Conjuge;
select * from Conjuge;

/*********************--8--***********************/

create table Funcionario(
    cod_func int primary key not null,
    nome_func varchar(100) not null,
    end_func varchar(200) not null,
    sal_func decimal(10,2) not null default 0 check (sal_func >=0),
    sexo_func char(1) not null default 'M' check (sexo_func in ('F', 'M')),

    foreign key (cod_func) references tb_cliente(pk_id_codCli)
);

/*********************--9--***********************/

create table tb_dependente (
    cod_dep int not null primary key,
    fk_cod_func int not null,
    nome_dep varchar (100) not null,
    sexo_dep char(1) not null default 'M' check (sexo_dep in ('F', 'M')),

    foreign key (fk_cod_func) references Funcionario (cod_func)
);

/*********************--10--***********************/

create table tb_titulo (
    cod_tit int not null primary key,
    fk_cod_cat int not null, -- chave estrangeira
    fk_cod_grav int not null, -- chave estrangeira
    nome_cd varchar(100) not null unique,
    val_cd decimal(10,2) not null DEFAULT 0 CHECK (val_cd > 0),
    qtd_estq int not null DEFAULT 0 CHECK (qtd_estq >= 0),

    foreign key (fk_cod_cat) references tb_categoria(pk_id_codCat),
    foreign key (fk_cod_grav) references tb_gravadora(pk_id_codGrav)
);

desc tb_titulo;
select * from tb_titulo;

/*********************--11--***********************/
-- 11
create table tb_pedido(
    num_Ped int primary key not null, 
    fk_cod_cli int not null, -- chave estrangeira
    fk_cod_func int not null, -- chave estrangeira
    data_ped datetime not null,
    val_ped decimal(10,2) not null default 0 check (val_ped >= 0),

    foreign key (fk_cod_cli) references tb_cliente(pk_id_codCli),
    foreign key (fk_cod_func) references Funcionario(cod_func)
);

desc tb_pedido;
select * from tb_pedido;

/*********************--12--***********************/

create table  Titulo_Pedido (
    num_ped INT NOT NULL,
    cod_Tit INT NOT NULL,
    qtd_CD INT NOT NULL CHECK (qtd_CD >= 1),
    val_CD DECIMAL(10,2) NOT NULL CHECK (val_CD > 0),

    PRIMARY KEY (num_ped, cod_Tit),
    FOREIGN KEY (num_ped) REFERENCES tb_pedido(num_Ped),
    FOREIGN KEY (cod_Tit) REFERENCES tb_titulo(cod_tit)
);

desc Titulo_Pedido;
select * from Titulo_Pedido;

/*********************--13--***********************/

create table Titulo_Artista(
	cod_tit int not null,
    cod_art int not null,
    
	PRIMARY KEY (cod_tit, cod_art),
	FOREIGN KEY (cod_tit) REFERENCES tb_titulo(cod_tit),
    FOREIGN KEY (cod_art) REFERENCES tb_artista(pk_id_codArt)
);

desc Titulo_Artista;
select * from Titulo_Pedido;