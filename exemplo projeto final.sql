CREATE DATABASE Exemplo_Fiscalizacao_Emendas;

USE Exemplo_Fiscalizacao_Emendas;

CREATE TABLE Politico (
    id_politico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    cargo VARCHAR(50) NOT NULL,
    partido VARCHAR(50) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    data_inicial DATE NOT NULL,
    data_final DATE NOT NULL
);

CREATE TABLE Empresa (
    id_empresa INT AUTO_INCREMENT PRIMARY KEY,
    cnpj VARCHAR(18) NOT NULL UNIQUE,
    razao_social VARCHAR(255) NOT NULL,
    nome_fantasia VARCHAR(255) NOT NULL,
    setor VARCHAR(100) NOT NULL,
    localizacao VARCHAR(255) NOT NULL
);

CREATE TABLE Emenda (
    id_emenda INT AUTO_INCREMENT PRIMARY KEY,
    valor DECIMAL(15, 2) NOT NULL,
    motivo VARCHAR(255) NOT NULL,
    setor VARCHAR(100) NOT NULL,
    data DATE NOT NULL,
    id_politico INT,
    id_empresa INT,
    FOREIGN KEY (id_politico) REFERENCES Politico(id_politico),
    FOREIGN KEY (id_empresa) REFERENCES Empresa(id_empresa)
);

CREATE TABLE Obra (
    id_obra INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    local VARCHAR(255) NOT NULL,
    data_inicio DATE NOT NULL,
    data_termino DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    id_emenda INT,
    FOREIGN KEY (id_emenda) REFERENCES Emenda(id_emenda)
);

CREATE TABLE OrgaoControle (
    id_orgao INT AUTO_INCREMENT PRIMARY KEY,
    cnpj VARCHAR(18) NOT NULL UNIQUE,
    razao_social VARCHAR(255) NOT NULL,
    nome_fantasia VARCHAR(255) NOT NULL,
    ramo VARCHAR(100) NOT NULL,
    responsavel VARCHAR(255) NOT NULL
);

CREATE TABLE Fiscalizacao (
    id_fiscalizacao INT AUTO_INCREMENT PRIMARY KEY,
    data DATE NOT NULL,
    motivo VARCHAR(255) NOT NULL,
    resultado VARCHAR(255) NOT NULL,
    id_obra INT,
    id_orgao INT,
    FOREIGN KEY (id_obra) REFERENCES Obra(id_obra),
    FOREIGN KEY (id_orgao) REFERENCES OrgaoControle(id_orgao)
);

CREATE TABLE Denuncia (
    id_denuncia INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255),
    motivo VARCHAR(255) NOT NULL,
    data DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    id_politico INT,
    id_empresa INT,
    id_emenda INT,
    FOREIGN KEY (id_politico) REFERENCES Politico(id_politico),
    FOREIGN KEY (id_empresa) REFERENCES Empresa(id_empresa),
    FOREIGN KEY (id_emenda) REFERENCES Emenda(id_emenda)
);

INSERT INTO Politico (nome, cpf, cargo, partido, estado, cidade, data_inicial, data_final) VALUES
('João Silva', '123.456.789-01', 'Deputado Federal', 'PT', 'SP', 'São Paulo', '2019-01-01', '2023-12-31'),
('Maria Oliveira', '987.654.321-09', 'Senadora', 'PSDB', 'RJ', 'Rio de Janeiro', '2019-02-01', '2023-12-31'),
('Carlos Souza', '456.789.123-45', 'Vereador', 'MDB', 'MG', 'Belo Horizonte', '2021-01-01', '2025-12-31'),
('Ana Costa', '321.654.987-09', 'Deputada Estadual', 'PL', 'RS', 'Porto Alegre', '2019-01-01', '2023-12-31'),
('Pedro Almeida', '111.222.333-44', 'Deputado Estadual', 'PSOL', 'BA', 'Salvador', '2020-01-01', '2024-12-31'),
('Fernanda Lima', '222.333.444-55', 'Senadora', 'REDE', 'CE', 'Fortaleza', '2019-01-01', '2023-12-31'),
('Ricardo Gomes', '333.444.555-66', 'Vereador', 'PDT', 'PR', 'Curitiba', '2021-01-01', '2025-12-31'),
('Juliana Costa', '444.555.666-77', 'Deputada Federal', 'NOVO', 'SC', 'Florianópolis', '2019-01-01', '2023-12-31');

INSERT INTO Empresa (cnpj, razao_social, nome_fantasia, setor, localizacao) VALUES
('12.345.678/0001-01', 'Construtora ABC Ltda', 'Construtora ABC', 'Construção Civil', 'São Paulo, SP'),
('98.765.432/0001-09', 'Engenharia XYZ S.A.', 'Engenharia XYZ', 'Engenharia', 'Rio de Janeiro, RJ'),
('45.678.912/0001-45', 'Infraestrutura 123 Ltda', 'Infraestrutura 123', 'Infraestrutura', 'Belo Horizonte, MG'),
('32.165.498/0001-09', 'Educação e Cia S.A.', 'Educação e Cia', 'Educação', 'Porto Alegre, RS'),
('55.666.777/0001-88', 'Construções Bahia Ltda', 'Construções Bahia', 'Construção Civil', 'Salvador, BA'),
('66.777.888/0001-99', 'Engenharia Nordeste S.A.', 'Engenharia Nordeste', 'Engenharia', 'Fortaleza, CE'),
('77.888.999/0001-00', 'Infra Paraná Ltda', 'Infra Paraná', 'Infraestrutura', 'Curitiba, PR'),
('88.999.000/0001-11', 'Educação Santa Catarina S.A.', 'Educação SC', 'Educação', 'Florianópolis, SC');

INSERT INTO Emenda (valor, motivo, setor, data, id_politico, id_empresa) VALUES
(1000000.00, 'Reforma de escolas', 'Educação', '2022-03-15', 1, 4),
(2500000.00, 'Construção de ponte', 'Infraestrutura', '2022-05-20', 2, 2),
(1500000.00, 'Pavimentação de ruas', 'Infraestrutura', '2022-07-10', 3, 3),
(500000.00, 'Compra de equipamentos', 'Saúde', '2022-09-01', 4, 1),
(800000.00, 'Reforma de hospitais', 'Saúde', '2022-04-10', 5, 5),
(3000000.00, 'Construção de estradas', 'Infraestrutura', '2022-06-15', 6, 6),
(1200000.00, 'Ampliação de escolas', 'Educação', '2022-08-20', 7, 7),
(700000.00, 'Compra de ambulâncias', 'Saúde', '2022-10-25', 8, 8);

INSERT INTO Obra (nome, local, data_inicio, data_termino, status, id_emenda) VALUES
('Reforma da Escola Municipal', 'São Paulo, SP', '2022-04-01', '2022-12-31', 'No prazo', 1),
('Construção da Ponte Rio-Niterói', 'Rio de Janeiro, RJ', '2022-06-01', '2024-06-01', 'Atrasada', 2),
('Pavimentação da Rua Principal', 'Belo Horizonte, MG', '2022-08-01', '2023-02-01', 'Adiantada', 3),
('Ampliação do Hospital Municipal', 'Porto Alegre, RS', '2022-10-01', '2023-10-01', 'No prazo', 4),
('Reforma do Hospital Municipal', 'Salvador, BA', '2022-05-01', '2023-05-01', 'No prazo', 5),
('Construção da Rodovia CE-040', 'Fortaleza, CE', '2022-07-01', '2024-07-01', 'Atrasada', 6),
('Ampliação da Escola Estadual', 'Curitiba, PR', '2022-09-01', '2023-09-01', 'Adiantada', 7),
('Compra de Ambulâncias', 'Florianópolis, SC', '2022-11-01', '2023-01-01', 'No prazo', 8);

INSERT INTO OrgaoControle (cnpj, razao_social, nome_fantasia, ramo, responsavel) VALUES
('11.222.333/0001-44', 'Tribunal de Contas da União', 'TCU', 'Fiscalização', 'José Almeida'),
('99.888.777/0001-66', 'Controladoria Geral da União', 'CGU', 'Fiscalização', 'Fernanda Lima'),
('44.555.666/0001-77', 'Tribunal de Contas do Estado', 'TCE', 'Fiscalização', 'Roberto Santos'),
('33.444.555/0001-88', 'Ministério Público Federal', 'MPF', 'Fiscalização', 'Carla Mendes'),
('22.333.444/0001-55', 'Tribunal de Contas do Estado da Bahia', 'TCE-BA', 'Fiscalização', 'Marcos Rocha'),
('33.444.555/0001-66', 'Controladoria Geral do Estado do Ceará', 'CGE-CE', 'Fiscalização', 'Patrícia Alves'),
('44.575.696/0001-77', 'Tribunal de Contas do Estado do Paraná', 'TCE-PR', 'Fiscalização', 'Roberto Silva'),
('55.666.777/0001-88', 'Ministério Público de Santa Catarina', 'MP-SC', 'Fiscalização', 'Carla Fernandes');

INSERT INTO Fiscalizacao (data, motivo, resultado, id_obra, id_orgao) VALUES
('2022-10-15', 'Verificação de atraso na obra', 'Atraso confirmado', 2, 1),
('2022-11-01', 'Auditoria de custos', 'Custos dentro do previsto', 1, 2),
('2022-12-10', 'Inspeção de qualidade', 'Qualidade aprovada', 3, 3),
('2023-01-20', 'Verificação de desvio de recursos', 'Nenhum desvio encontrado', 4, 4),
('2022-11-10', 'Verificação de atraso na reforma do hospital', 'Atraso justificado', 5, 5),
('2022-12-15', 'Auditoria de custos da rodovia', 'Custos dentro do previsto', 6, 6),
('2023-01-20', 'Inspeção de qualidade na ampliação da escola', 'Qualidade aprovada', 7, 7),
('2023-02-25', 'Verificação de desvio na compra de ambulâncias', 'Nenhum desvio encontrado', 8, 8);

INSERT INTO Denuncia (nome, motivo, data, status, id_politico, id_empresa, id_emenda) VALUES
('Anônimo', 'Desvio de recursos na obra da ponte', '2022-09-15', 'Em investigação', 2, 2, 2),
('José Pereira', 'Superfaturamento na reforma da escola', '2022-08-20', 'Resolvida', 1, 4, 1),
('Maria Santos', 'Atraso na pavimentação', '2022-11-05', 'Pendente', 3, 3, 3),
('Carlos Mendes', 'Falta de transparência na compra de equipamentos', '2022-12-01', 'Em investigação', 4, 1, 4),
('Anônimo', 'Superfaturamento na reforma do hospital', '2022-10-05', 'Em investigação', 5, 5, 5),
('Carlos Mendes', 'Atraso na construção da rodovia', '2022-11-15', 'Pendente', 6, 6, 6),
('Maria Santos', 'Falta de transparência na ampliação da escola', '2022-12-20', 'Resolvida', 7, 7, 7),
('José Pereira', 'Desvio de recursos na compra de ambulâncias', '2023-01-10', 'Em investigação', 8, 8, 8);

SELECT * FROM OrgaoControle;
SELECT * FROM Denuncia;
SELECT * FROM Politico;