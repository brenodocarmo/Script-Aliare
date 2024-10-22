/*
Autor: Breno do Carmo Sousa

Objetivo: Construir um relatório que seja possivel visualizar o andamento das ordens de produção, seguindo 
          todas as etapas (1 - Baixa de Matéria-Prima, 2 - Baixa de Material de Envase, 3 - Adição do Produto Acabado)necessários 

Data: 22/10/2024

*/

SELECT 
    acompanhaordem.codi_ord ordem_producao,

    -- Definição da situação da Ordem de Produção
    CASE
        WHEN ordemproducao.stat_ord = 'A' THEN 'Aguardando'
        WHEN ordemproducao.stat_ord = 'P' THEN 'Paralizada'
        WHEN ordemproducao.stat_ord = 'E' THEN 'Iniciada'
        WHEN ordemproducao.stat_ord = 'F' THEN 'Finalizada'
        WHEN ordemproducao.stat_ord = 'C' THEN 'Cancelada'
    END situacao_op,
    acompanhaordem.codi_eta codigo_etapa,
    etapa.desc_eta descricao_etapa,
    
    acompanhaordem.dini_aco data_inicio,    
    -- Extração da Hora, Minutos e Segunda de cada inicio de etapa.
    EXTRACT(HOUR FROM (acompanhaordem.hini_aco))||':' ||EXTRACT(minute FROM (acompanhaordem.hini_aco))||':'||EXTRACT(second FROM (acompanhaordem.hini_aco)) hora_inicio,

 
    -- Definição da situação da Etapa de Produção
    CASE
        WHEN acompanhaordem.stat_aco = 'I' THEN 'Iniciada'
        WHEN acompanhaordem.stat_aco = 'C' THEN 'Criada'
        WHEN acompanhaordem.stat_aco = 'F' THEN 'Finalizada'
    END situacao_etapa,
    
    acompanhaordem.dfim_aco data_termino,
    -- Extração da Hora, Minutos e Segunda de cada fim de etapa.
    EXTRACT(HOUR FROM (acompanhaordem.hfim_aco))||':' ||EXTRACT(minute FROM (acompanhaordem.hfim_aco))||':'||EXTRACT(second FROM (acompanhaordem.hfim_aco)) hora_termino,
    
    iordem.codi_aco codigo_acompanhamento,
    iordem.codi_psv codigo,
    prodserv.desc_psv produto,
    prodserv.unid_psv unidade,
    iordem.qsol_pro qtd_solicitada,
    iordem.quti_pro qtd_utilizada,
    -- Diferença entre a quantidade solicitada e a quantidade utilizada na Ordem de Produção
    round((iordem.qsol_pro - iordem.quti_pro),2) diferenca,
    iordem.codi_dpt deposito,
    iordem.pcun_pro preco_unit_acabado

FROM iordem

INNER JOIN prodserv ON (iordem.codi_psv = prodserv.codi_psv)
INNER JOIN acompanhaordem ON (iordem.codi_aco = acompanhaordem.codi_aco)
INNER JOIN etapa ON (acompanhaordem.codi_eta = etapa.codi_eta)
INNER JOIN ordemproducao ON (acompanhaordem.codi_ord = ordemproducao.codi_ord)

ORDER BY acompanhaordem.codi_ord, acompanhaordem.codi_eta;