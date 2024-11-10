-- Entidade: Indústria Farmacêutica 
CREATE TABLE Industria_Farmaceutica (
    id_industria SERIAL PRIMARY KEY,
    nome_empresa VARCHAR(100) NOT NULL,
    ano_fundacao INT,
    faturamento_anual NUMERIC(15, 2)
);

-- Tabela auxiliar para 'Licenças e Certificados' (normalização)
CREATE TABLE Licencas_Certificados (
    id_licenca SERIAL PRIMARY KEY,
    id_industria CHAR(14) REFERENCES Industria_Farmaceutica(id_industria) ON DELETE CASCADE,
    descricao VARCHAR(300) NOT NULL
);

-- Tabela auxiliar para 'Unidade' (normalização)
CREATE TABLE Unidade (
    id_unidade SERIAL PRIMARY KEY,
    id_industria INT REFERENCES Industria_Farmaceutica(id_industria) ON DELETE CASCADE,
    cnpj_unidade CHAR(18) UNIQUE,
    endereco VARCHAR(200) NOT NULL,
    tipo_local VARCHAR(6)  -- 'Sede' ou 'Filial'
);

-- Entidade: Distribuidora
CREATE TABLE Distribuidora (
    id_distribuidora SERIAL PRIMARY KEY,
    nome_empresa VARCHAR(100) NOT NULL,
    contato_telefone VARCHAR(50),
    contato_email VARCHAR(200),
    tempo_medio_entrega INTERVAL,
    capacidade_armazenamento INT
);

-- Entidade: Farmacia/Ponto de Venda
CREATE TABLE Farmacia_Ponto_Venda (
    id_farmacia SERIAL PRIMARY KEY,
    cnpj_farmacia CHAR(14) UNIQUE, 
    sede VARCHAR(150),          
    endereco VARCHAR(200),      
    horario_funcionamento VARCHAR(100) 
);

-- Entidade: Medicamento Testado
CREATE TABLE Medicamento_Testado (
    id_produto SERIAL PRIMARY KEY,
    composicao_medicamento VARCHAR(300),
    nome_produto VARCHAR(100) NOT NULL,
    numero_lote VARCHAR(50),
    data_validade DATE,
    data_fabricacao DATE
);

-- Entidade: Cliente
CREATE TABLE Cliente (
    id_cliente SERIAL PRIMARY KEY, 
    cpf_cliente CHAR(11) NOT NULL UNIQUE,
    nome_cliente VARCHAR(100),
    endereco_cliente VARCHAR(200)
);

-- Entidade: Matéria Prima
CREATE TABLE Materia_Prima (
    id_industria INT PRIMARY KEY REFERENCES Industria_Farmaceutica(id_industria) ON DELETE CASCADE,
    biomateriais VARCHAR(200),
    micro_organismos VARCHAR(200),
    substancias_minerais VARCHAR(200),
    extrato_plantas VARCHAR(200)
);

-- Entidade: Fornecedora de Animais
CREATE TABLE Fornecedora_Animais (
    id_industria INT PRIMARY KEY REFERENCES Industria_Farmaceutica(id_industria) ON DELETE CASCADE,
    id_fornecedor SERIAL PRIMARY KEY,
    nome_fornecedor VARCHAR(100) NOT NULL,
    endereco_fornecedor VARCHAR(200),
    proprietario_fornecedor VARCHAR(100) NOT NULL
);

-- Tabela auxiliar para 'Animal' da Fornecedora (multivalorado)
CREATE TABLE Animais (
    id_animal SERIAL PRIMARY KEY,
    id_fornecedora INT REFERENCES Fornecedora_Animais(id_fornecedora) ON DELETE CASCADE,
    tipo_animal VARCHAR(100) NOT NULL,
    quantidade_populacao INT NOT NULL
);

-- Entidade: Funcionários
CREATE TABLE Funcionarios (
    id_funcionario SERIAL PRIMARY KEY,
    nome_funcionario VARCHAR(100) NOT NULL,
    cpf_funcionario CHAR(11) UNIQUE NOT NULL,
    endereco_funcionario VARCHAR(200),
    contato_telefone VARCHAR(100),
    contato_email VARCHAR (100),
    setor VARCHAR(100),
    cargo VARCHAR(100),
    turno VARCHAR(30),
    salario NUMERIC(10,2)
);

-- Entidade: Zelador (especialização)
CREATE TABLE Zelador (
    id_funcionario INT PRIMARY KEY,
    area_responsabilidade VARCHAR(255),
    FOREIGN KEY (id_funcionario) REFERENCES Funcionarios(id_funcionario) ON DELETE CASCADE
);

-- Entidade: Segurança (especialização)
CREATE TABLE Seguranca (
    id_funcionario INT PRIMARY KEY,
    licenca_seguranca VARCHAR(200),
    FOREIGN KEY (id_funcionario) REFERENCES Funcionarios(id_funcionario) ON DELETE CASCADE
);

-- Entidade: Recepcionista (especialização)
CREATE TABLE Recepcionista (
    id_funcionario INT PRIMARY KEY,
    FOREIGN KEY (id_funcionario) REFERENCES Funcionarios(id_funcionario) ON DELETE CASCADE
);

-- Entidade: Cientista/Pesquisador (especialização)
CREATE TABLE Cientista_Pesquisador (
    id_funcionario INT PRIMARY KEY,
    area_especializacao VARCHAR(100),
    diploma VARCHAR(100),
    tempo_atuacao INT,
    FOREIGN KEY (id_funcionario) REFERENCES Funcionarios(id_funcionario) ON DELETE CASCADE
);
