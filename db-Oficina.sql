-- DATA BASE OFICINA
drop database if exists oficina;
create database oficina;
use oficina;

-- CLIENTE
-- drop table clientes;
create table clientes(
	idCliente int primary key auto_increment not null,
    nome varchar(50),
    sobrenome varchar(50),
	cpf char(11),
	telefone varchar(50),
    endereco varchar(50),
    constraint unique_cpf_cliente unique(cpf)
  );
alter table orders auto_increment=1;     
   
   -- INSERINDO DADOS EM CLIENTE

insert into clientes (nome,sobrenome,cpf,telefone, endereco) VALUES
						   ('Karina','Rios','23749007896','19981617290','rua joao pesoa 354 - RJ'),
                            ('Andre','Barros','23755007896','21989617270','avenida vergueiro  89 - SP'),
                            ('Roberto','Andrade','37897407896','15999618879','avenida paz  114 - MG'),
                             ('Maria','Domingues','88717485867','15981617790','rua mar  898 - RJ');
                          
select * from clientes;

      
-- VEICULO
create table veiculo(
	idVeiculo int auto_increment primary key,
    marca varchar(45),
    placa varchar(20),
    cor varchar(15),
    ano int,
    modelo varchar(20),
    idClienteVeiculo int,
    constraint unique_placa_veiculo unique(placa),
    constraint fk_veiculo_cliente foreign key (idClienteVeiculo) references clientes(idCliente)
);
 desc veiculo;
 -- INSERINDO DADOS EM VEICULO
		--	
insert into veiculo (idClienteVeiculo,marca,placa,cor,ano, modelo) VALUES
			('1','VOLKSWAGEN','OWC1897','vermelho',2012,'sedan'),
			('2','VOLKSWAGEN','FMZ56','vermelho',2012,'sedan'),
			('2','CHEVROLET','HIK89','azul',2008,'heatch'),
			('3','FIAT','KIA55A','verde',2020,'sedan'),
            ('4','PORSHE','FMH7878','vermelho',2003,''),
            ('1','BMW','HAPOE9','branco',2021,'');
select * from veiculo;

-- AVALIAÇAO
create table avaliacao(
	idAvaliacao int auto_increment primary key,
    tipoServico varchar(45),
    idVeiculoAvaliacao int,
    idEquipeMecAvaliacao int,
    constraint fk_avaliacao_veiculo foreign key (idVeiculoAvaliacao) references veiculo(idVeiculo),
    constraint fk_avaliacao_equipe foreign key (idEquipeMecAvaliacao) references equipeMecanicos(idEquipeMecanicos)
   );
   alter table avaliacao auto_increment=1;     
  -- ('conserto',1,1)
   insert into avaliacao (tipoServico,idVeiculoAvaliacao,idEquipeMecAvaliacao) VALUES
			('revisao',2,2),
            ('revisao',3,3),
              ('conserto',4,4),
                ('revisao',5,5),
                 ('conserto',6,7)
            ;
                        
select * from avaliacao;
select * from equipeMecanicos;

--
-- EQUIPE DE MECÁNICOS

create table equipeMecanicos(
	idEquipeMecanicos int auto_increment primary key,
    nomeEquipe varchar(45) ,
    especialidadeEquipe varchar(45),
    idMecanicosEquipe int,
    constraint fk_equipe_mecanico foreign key (idMecanicosEquipe) references mecanico(idMecanico)
);
 alter table equipeMecanicos auto_increment=1;     
  -- INSERINDO DADOS EM EQUIPE MECANICOS
   -- 1-suspenção, 2-cambio, 3-injecao eletronica, 4-motor
  
  insert into equipeMecanicos(nomeEquipe,especialidadeEquipe,idMecanicosEquipe) VALUES
			('Equipe A','Suspensao e Cambio',1),
            ('Equipe A','Suspensao e Cambio',3),
                ('Equipe A','Suspensao e Cambio',5),
                ('Equipe B','Injeção eletronica',4),
                ('Equipe B','Injeção eletronica',3),
                ('Equipe C','Motor',2),
                ('Equipe C','Motor',6);
	Select * from equipeMecanicos;

-- MECANICOS
create table mecanico(
	idMecanico int auto_increment primary key,
    Nome varchar(45)not null,
    Endereco varchar(45)not null,
    EspecialidadeMecanico varchar(45),
    EquipeMecanico int
  );
   alter table mecanico auto_increment=1;     
   
   -- INSERINDO DADOS EM MECANICO
   -- 1-suspenção, 2-cambio, 3-injecao eletronica, 4-motor
  
  insert into mecanico(nome,Endereco,EspecialidadeMecanico,EquipeMecanico) VALUES
			('Rafael Domingues','rua eulofia 354','suspencao','1'),
             ('Bruno Claro','rua joa pesso 566','motor','4'),
              ('Marcelo Khia','avenida general carneiro 354','cambio','2'),
              ('Rodolfo Martins','avenida treze 566','injecao eletronica','3'),
                ('Mario Rodrigues','rua santa terezinha 898','suspenção','1'),
                ('Marco Eulofio','rua quinzinho 356','cambio','2')           ;
                
select * from mecanico;

  


-- MÃO DE OBRA
create table maoObra(
	idMaoObra int auto_increment primary key,
    ValorMaoObra float not null
    );

-- PEÇAS

create table Pecas(
	idPecas int auto_increment primary key,
    valorPecas float not null
);

-- Ordem de Serviço

create table OS(
	idOS int auto_increment not null,
    dataEmissao varchar(25),
    dataConclusao varchar(25),
    statusOS enum('aberto','encerrado','em andamento'),
    idMaoObraOS int,
    idPecasOS int,
    constraint fk_os_mao foreign key (idMaoObraOS) references maoObra(idMaoObra),
    constraint fk_os_pecas foreign key (idPecasOS) references Pecas(idPecas)
        
   )
   
   
   idmechanical int not null,
    idcustomer int not null,
    idparts int not null,
    idservice int not null,
    datein datetime,
    price decimal(4,1),
    status varchar(15),
    datefin date,
    constraint pk_orders primary key (idorders),
    constraint fk_orders_customer foreign key (idcustomer) references customer(idcustomer),
    constraint fk_orders_mechanical foreign key (idmechanical) references mechanical(idmechanical),
	constraint fk_orders_parts foreign key (idparts) references parts(idparts),
    constraint fk_orders_service foreign key (idservice) references service(idservice)
);


-- QUERIES-
-- Que veiculos pertencem aos clientes?

select concat(c.nome," ",c.sobrenome) as Cliente ,v.marca,v.placa from clientes c, veiculo v
	where idCLienteVeiculo=idCliente;

-- quantos veiculos VOLKSWAGEN temos no nosso banco de dados?

select count(*) from veiculo
	where marca ='VOLKSWAGEN';


-- quantos de nosso clientes tem mais de um carro em nossa oficina
select  concat(c.nome," ",c.sobrenome) as Cliente ,COUNT(*) AS "Num de carros" from clientes c, veiculo v
	where idCLienteVeiculo=idCliente
    group by idCliente;

 -- quantidade de mecanicos por equipe?
    
    select nomeEquipe, count(*) as "Numero de Mecanicos" from equipeMecanicos
		group by nomeEquipe;
 
-- em qual equipe se encontra o mecanico Rafael Domingues?

select  m.nome AS "Mecanico",e.nomeEquipe from mecanico m, equipeMecanicos e
	where idMecanicosEquipe=idMecanico and nome='Rafael Domingues'
    ;


select * from veiculo;
select * from clientes;
