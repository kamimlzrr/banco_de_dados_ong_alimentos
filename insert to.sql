-- ########## INSERÇÃO DE DADOS DE TESTE ##########

-- 1. Inserir em Doadores
INSERT INTO Doadores (nome, cpf, telefone, email, endereco) VALUES
('João Silva', '111.111.111-11', '41991234567', 'joao.s@email.com', 'Rua Alfa, 123, Curitiba - PR'),
('Maria Oliveira', '222.222.222-22', '41992345678', 'maria.o@email.com', 'Av. Beta, 456, Curitiba - PR');

-- 2. Inserir em Voluntarios
INSERT INTO Voluntarios (nome, cpf, telefone, email, endereco) VALUES
('Ana Paula Souza', '333.333.333-33', '41993456789', 'ana.s@email.com', 'Rua Gama, 789, Curitiba - PR'),
('Carlos Eduardo Lima', '444.444.444-44', '41994567890', 'carlos.l@email.com', 'Rua Delta, 101, Curitiba - PR');

-- 3. Inserir em Alimentos (catálogo de tipos de alimentos)
INSERT INTO Alimentos (nomeAlimento, unidadePadrao) VALUES
('Arroz Agulhinha', 'kg'),
('Feijão Carioca', 'kg'),
('Macarrão Parafuso', 'pacote'),
('Leite Longa Vida', 'litro'),
('Carne Moída', 'kg'),
('Cenoura', 'kg'),
('Batata', 'kg'),
('Frango Desfiado', 'kg'),
('Óleo de Soja', 'litro');


-- 4. Inserir em AlimentosDoados (doações de ingredientes)
-- Doação de um Doador (João Silva)
INSERT INTO AlimentosDoados (idDoador, idVoluntario, idAlimento, quantidadeDoada, dataValidade, dataDoacao) VALUES
(1, NULL, 1, 10.0, '2025-12-31', NOW()), -- 10kg de Arroz
(1, NULL, 2, 5.0, '2026-06-30', NOW());  -- 5kg de Feijão

-- Doação de um Voluntário (Ana Paula Souza também doando alimento)
INSERT INTO AlimentosDoados (idDoador, idVoluntario, idAlimento, quantidadeDoada, dataValidade, dataDoacao) VALUES
(NULL, 1, 3, 3.0, '2025-10-15', NOW()); -- 3 pacotes de Macarrão

-- 5. Inserir em RefeicoesProntas (Ex: Lotes de marmitas)
-- Refeição preparada por Voluntário (Ana Paula) e doada por ela mesma
INSERT INTO RefeicoesProntas (idDoador, idVoluntarioPreparador, idVoluntarioDoador, descricaoRefeicao, quantidadeTotal, unidadeMedida, dataPreparo, dataValidadeRefeicao, dataRegistro) VALUES
(NULL, 1, 1, 'Marmitas de Strogonoff com Arroz', 20, 'marmitas', '2025-06-19', '2025-06-21', NOW());

-- Refeição doada por um Doador (Maria Oliveira)
INSERT INTO RefeicoesProntas (idDoador, idVoluntarioPreparador, idVoluntarioDoador, descricaoRefeicao, quantidadeTotal, unidadeMedida, dataPreparo, dataValidadeRefeicao, dataRegistro) VALUES
(2, NULL, NULL, 'Sopa de Legumes (5 litros)', 5.0, 'litros', '2025-06-18', '2025-06-20', NOW());

-- 6. Inserir em IngredientesRefeicao (Quais alimentos foram usados nas refeições)
-- Para a "Marmitas de Strogonoff com Arroz" (idRefeicaoPronta = 1, assumindo que foi a primeira inserida)
INSERT INTO IngredientesRefeicao (idRefeicaoPronta, idAlimento, quantidadeUsada, unidadeMedida) VALUES
(1, 1, 2.0, 'kg'), -- 2kg de Arroz (idAlimento=1)
(1, 5, 1.5, 'kg'); -- 1.5kg de Carne Moída (idAlimento=5)

-- Para a "Sopa de Legumes" (idRefeicaoPronta = 2, assumindo a segunda inserida)
INSERT INTO IngredientesRefeicao (idRefeicaoPronta, idAlimento, quantidadeUsada, unidadeMedida) VALUES
(2, 6, 1.0, 'kg'), -- 1kg de Cenoura (idAlimento=6)
(2, 7, 2.0, 'kg'); -- 2kg de Batata (idAlimento=7)

-- 7. Inserir em EstoqueAlimentos (atualizar o estoque)
-- Adicionando os alimentos doados ao estoque
INSERT INTO EstoqueAlimentos (idAlimento, idRefeicaoPronta, quantidadeAtual, unidadeMedida, dataValidadeMaisProxima) VALUES
(1, NULL, 10.0, 'kg', '2025-12-31'), -- Arroz
(2, NULL, 5.0, 'kg', '2026-06-30'),  -- Feijão
(3, NULL, 3.0, 'pacote', '2025-10-15'); -- Macarrão

-- Adicionando as refeições prontas ao estoque (ex: 20 marmitas)
INSERT INTO EstoqueAlimentos (idAlimento, idRefeicaoPronta, quantidadeAtual, unidadeMedida, dataValidadeMaisProxima) VALUES
(NULL, 1, 20, 'marmitas', '2025-06-21'), -- Marmitas de Strogonoff
(NULL, 2, 5.0, 'litros', '2025-06-20'); -- Sopa de Legumes


-- 8. Inserir em Entregas (uma entrega realizada por um voluntário)
INSERT INTO Entregas (idVoluntario, dataEntrega, enderecoEntrega) VALUES
(2, NOW(), 'Rua Z, 50, Abrigo Esperança, Curitiba - PR'); -- Entregue por Carlos Eduardo Lima

-- 9. Inserir em DetalheEntrega (o que foi entregue na entrega acima)
-- Assumindo que idEntrega é 1 (primeira entrega)
INSERT INTO DetalheEntrega (idEntrega, idAlimento, idRefeicaoPronta, quantidade, unidadeMedida) VALUES
(1, NULL, 1, 10, 'marmitas'), -- 10 marmitas (Refeição Pronta ID 1)
(1, 1, NULL, 2.0, 'kg');       -- 2 kg de Arroz (Alimento ID 1)
