-- Garante que o banco de dados seja removido (se existir) para um recomeço limpo
DROP DATABASE IF EXISTS ong_bancalimentos;

-- Criação do Banco de Dados
CREATE DATABASE IF NOT EXISTS ong_bancalimentos;
USE ong_bancalimentos;

-- Tabela para Doadores (apenas doadores, sem interesse em ser voluntário)
CREATE TABLE IF NOT EXISTS Doadores (
    idDoador INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100),
    endereco TEXT
);

-- Tabela para Voluntarios (pessoas que SE CANDIDATARAM a ser voluntário)
CREATE TABLE IF NOT EXISTS Voluntarios (
    idVoluntario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100),
    endereco TEXT
);

-- Tabela: Alimentos (catálogo geral de alimentos - ingredientes brutos)
CREATE TABLE IF NOT EXISTS Alimentos (
    idAlimento INT PRIMARY KEY AUTO_INCREMENT,
    nomeAlimento VARCHAR(100) NOT NULL UNIQUE, -- Ex: "Arroz Agulhinha", "Feijão Carioca"
    unidadePadrao VARCHAR(20) NOT NULL -- Ex: 'kg', 'unidades', 'litros'
);

-- Tabela para AlimentosDoados (registra doações de alimentos não preparados / ingredientes)
CREATE TABLE IF NOT EXISTS AlimentosDoados (
    idDoacaoAlimento INT PRIMARY KEY AUTO_INCREMENT,
    idDoador INT,
    idVoluntario INT,
    idAlimento INT NOT NULL, -- Qual tipo de alimento do catálogo foi doado
    quantidadeDoada DECIMAL(10, 2) NOT NULL,
    dataValidade DATE, -- Validade específica deste lote doado
    dataDoacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idDoador) REFERENCES Doadores(idDoador),
    FOREIGN KEY (idVoluntario) REFERENCES Voluntarios(idVoluntario),
    FOREIGN KEY (idAlimento) REFERENCES Alimentos(idAlimento)
);

-- Tabela para RefeicoesProntas (registra as refeições já preparadas)
CREATE TABLE IF NOT EXISTS RefeicoesProntas (
    idRefeicaoPronta INT PRIMARY KEY AUTO_INCREMENT,
    idDoador INT, -- Doador da refeição pronta (se veio pronta de fora e não de um voluntário)
    idVoluntarioPreparador INT, -- Voluntário que preparou a refeição (se aplicável, pode ser diferente do doador)
    idVoluntarioDoador INT, -- Voluntário que doou a refeição pronta (se aplicável, alternativo ao idDoador)
    descricaoRefeicao TEXT NOT NULL, -- Ex: "Marmitas de arroz, feijão e carne moída"
    quantidadeTotal DECIMAL(10, 2) NOT NULL, -- Quantidade de unidades da refeição (ex: 20 marmitas)
    unidadeMedida VARCHAR(20) NOT NULL, -- Ex: 'marmitas', 'litros'
    dataPreparo DATE,
    dataValidadeRefeicao DATE, -- Data de validade da refeição pronta
    dataRegistro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idDoador) REFERENCES Doadores(idDoador),
    FOREIGN KEY (idVoluntarioPreparador) REFERENCES Voluntarios(idVoluntario),
    FOREIGN KEY (idVoluntarioDoador) REFERENCES Voluntarios(idVoluntario)
);

-- Tabela: IngredientesRefeicao (Liga RefeicoesProntas aos Alimentos que a compõem)
CREATE TABLE IF NOT EXISTS IngredientesRefeicao (
    idIngredienteRefeicao INT PRIMARY KEY AUTO_INCREMENT,
    idRefeicaoPronta INT NOT NULL,
    idAlimento INT NOT NULL,-- O tipo de alimento (ingrediente) usado da tabela Alimentos
    quantidadeUsada DECIMAL(10, 2) NOT NULL,
    unidadeMedida VARCHAR(20) NOT NULL,
    FOREIGN KEY (idRefeicaoPronta) REFERENCES RefeicoesProntas(idRefeicaoPronta),
    FOREIGN KEY (idAlimento) REFERENCES Alimentos(idAlimento)
);

-- Tabela para EstoqueAlimentos (controle de todos os alimentos e refeições no estoque)
CREATE TABLE IF NOT EXISTS EstoqueAlimentos (
    idEstoque INT PRIMARY KEY AUTO_INCREMENT,
    idAlimento INT,         -- ID do tipo de alimento bruto (da tabela Alimentos). Pode ser NULL se for Refeição Pronta.
    idRefeicaoPronta INT,   -- ID da refeição pronta específica (da tabela RefeicoesProntas). Pode ser NULL se for Alimento Bruto.
    quantidadeAtual DECIMAL(10, 2) NOT NULL,
    unidadeMedida VARCHAR(20) NOT NULL,
    dataUltimaAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    dataValidadeMaisProxima DATE, -- Validade mais próxima para o item em estoque (seja alimento ou refeição)
    FOREIGN KEY (idAlimento) REFERENCES Alimentos(idAlimento),
    FOREIGN KEY (idRefeicaoPronta) REFERENCES RefeicoesProntas(idRefeicaoPronta)
);

-- Tabela para Entregas (registra os locais e quem fez a entrega)
CREATE TABLE IF NOT EXISTS Entregas (
    idEntrega INT PRIMARY KEY AUTO_INCREMENT,
    idVoluntario INT NOT NULL, -- O voluntário que realizou a entrega
    dataEntrega DATETIME DEFAULT CURRENT_TIMESTAMP,
    enderecoEntrega TEXT NOT NULL,
    FOREIGN KEY (idVoluntario) REFERENCES Voluntarios(idVoluntario)
);

-- Tabela DetalheEntrega (para permitir múltiplos itens por entrega)
CREATE TABLE IF NOT EXISTS DetalheEntrega (
    idDetalheEntrega INT PRIMARY KEY AUTO_INCREMENT,
    idEntrega INT NOT NULL,
    idAlimento INT,         -- ID do tipo de alimento do catálogo Alimentos (se for um alimento avulso)
    idRefeicaoPronta INT,   -- ID da refeição pronta específica (da tabela RefeicoesProntas)
    quantidade DECIMAL(10, 2) NOT NULL,
    unidadeMedida VARCHAR(20) NOT NULL,
    FOREIGN KEY (idEntrega) REFERENCES Entregas(idEntrega),
    FOREIGN KEY (idAlimento) REFERENCES Alimentos(idAlimento),
    FOREIGN KEY (idRefeicaoPronta) REFERENCES RefeicoesProntas(idRefeicaoPronta)
);