-- ########## CONSULTA DE DADOS ##########
USE ong_bancalimentos;
-- Consultar todos os Doadores
SELECT * FROM Doadores;

-- Consultar todos os Voluntarios
SELECT * FROM Voluntarios;

-- Consultar o Catálogo de Alimentos
SELECT * FROM Alimentos;

-- Consultar AlimentosDoados com informações do Doador/Voluntário e do Tipo de Alimento
-- CORRIGIDO: Removido 'ad.unidadeMedida' e usando 'a.unidadePadrao' do catálogo de Alimentos
SELECT
    ad.idDoacaoAlimento,
    COALESCE(d.nome, v.nome) AS Doador_ou_Voluntario,
    a.nomeAlimento AS Tipo_Alimento,
    ad.quantidadeDoada,
    a.unidadePadrao AS Unidade_Medida, -- USANDO unidadePadrao da tabela Alimentos
    ad.dataValidade,
    ad.dataDoacao
FROM AlimentosDoados ad
LEFT JOIN Doadores d ON ad.idDoador = d.idDoador
LEFT JOIN Voluntarios v ON ad.idVoluntario = v.idVoluntario
JOIN Alimentos a ON ad.idAlimento = a.idAlimento;

-- Consultar RefeicoesProntas com informações do Doador/Voluntário
SELECT
    rp.idRefeicaoPronta,
    rp.descricaoRefeicao,
    rp.quantidadeTotal,
    rp.unidadeMedida,
    rp.dataPreparo,
    rp.dataValidadeRefeicao,
    COALESCE(d.nome, vp.nome, vd.nome) AS Origem_Doacao_ou_Preparo
FROM RefeicoesProntas rp
LEFT JOIN Doadores d ON rp.idDoador = d.idDoador
LEFT JOIN Voluntarios vp ON rp.idVoluntarioPreparador = vp.idVoluntario
LEFT JOIN Voluntarios vd ON rp.idVoluntarioDoador = vd.idVoluntario;

-- Consultar Ingredientes de Refeições Prontas
SELECT
    ir.idIngredienteRefeicao,
    rp.descricaoRefeicao AS Refeicao,
    a.nomeAlimento AS Ingrediente,
    ir.quantidadeUsada,
    ir.unidadeMedida
FROM IngredientesRefeicao ir
JOIN RefeicoesProntas rp ON ir.idRefeicaoPronta = rp.idRefeicaoPronta
JOIN Alimentos a ON ir.idAlimento = a.idAlimento;

-- Consultar o Estoque de Alimentos e Refeições
SELECT
    ea.idEstoque,
    COALESCE(a.nomeAlimento, rp.descricaoRefeicao) AS Item_Estoque,
    ea.quantidadeAtual,
    ea.unidadeMedida,
    ea.dataUltimaAtualizacao,
    ea.dataValidadeMaisProxima
FROM EstoqueAlimentos ea
LEFT JOIN Alimentos a ON ea.idAlimento = a.idAlimento
LEFT JOIN RefeicoesProntas rp ON ea.idRefeicaoPronta = rp.idRefeicaoPronta;


-- Consultar Entregas com o Voluntário responsável e os Detalhes da Entrega
SELECT
    e.idEntrega,
    v.nome AS Voluntario_Responsavel,
    e.dataEntrega,
    e.enderecoEntrega,
    de.quantidade AS Quantidade_Entregue_Item,
    de.unidadeMedida AS Unidade_Entregue_Item,
    COALESCE(al.nomeAlimento, rpr.descricaoRefeicao) AS Item_Entregue_Detalhado
FROM Entregas e
JOIN Voluntarios v ON e.idVoluntario = v.idVoluntario
JOIN DetalheEntrega de ON e.idEntrega = de.idEntrega
LEFT JOIN Alimentos al ON de.idAlimento = al.idAlimento
LEFT JOIN RefeicoesProntas rpr ON de.idRefeicaoPronta = rpr.idRefeicaoPronta;