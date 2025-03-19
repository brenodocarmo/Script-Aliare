/*
Autor: Breno do Carmo Sousa

Objetivo: Construir um relatório que seja possivel visualizar o andamento das ordens de produção, seguindo 
          todas as etapas (1 - Baixa de Matéria-Prima, 2 - Baixa de Material de Envase, 3 - Adição do Produto Acabado)necessários 

Data: 22/10/2024

*/

CREATE OR REPLACE VIEW VW_ORDEM_PRODUCAO AS 

    SELECT 
        acompanhaordem.codi_ord ord_prod,
    
        -- Definição da situação da Ordem de Produção
        CASE
            WHEN ordemproducao.stat_ord = 'A' THEN 'Aguardando'
            WHEN ordemproducao.stat_ord = 'P' THEN 'Paralizada'
            WHEN ordemproducao.stat_ord = 'E' THEN 'Iniciada'
            WHEN ordemproducao.stat_ord = 'F' THEN 'Finalizada'
            WHEN ordemproducao.stat_ord = 'C' THEN 'Cancelada'
        END situ_op,
        acompanhaordem.codi_eta cod_eta,
        etapa.desc_eta desc_etapa,
        
        acompanhaordem.dini_aco data_ini,    
        -- Extração da Hora, Minutos e Segunda de cada inicio de etapa.
        EXTRACT(HOUR FROM (acompanhaordem.hini_aco))||':' ||EXTRACT(minute FROM (acompanhaordem.hini_aco))||':'||EXTRACT(second FROM (acompanhaordem.hini_aco)) hora_ini,
    
     
        -- Definição da situação da Etapa de Produção
        CASE
            WHEN acompanhaordem.stat_aco = 'I' THEN 'Iniciada'
            WHEN acompanhaordem.stat_aco = 'C' THEN 'Criada'
            WHEN acompanhaordem.stat_aco = 'F' THEN 'Finalizada'
        END situ_eta,
        
        acompanhaordem.dfim_aco data_fim,
        -- Extração da Hora, Minutos e Segunda de cada fim de etapa.
        EXTRACT(HOUR FROM (acompanhaordem.hfim_aco))||':' ||EXTRACT(minute FROM (acompanhaordem.hfim_aco))||':'||EXTRACT(second FROM (acompanhaordem.hfim_aco)) hora_fim,
        
        iordem.codi_aco cod_acom,
        iordem.codi_psv cod,
        prodserv.desc_psv prod,
        prodserv.unid_psv uni,
        iordem.qsol_pro qtd_sol,
        iordem.quti_pro qtd_uti,
        -- Diferença entre a quantidade solicitada e a quantidade utilizada na Ordem de Produção
        round((iordem.qsol_pro - iordem.quti_pro),2) dif,
        iordem.codi_dpt dep,
        iordem.pcun_pro preco_unit_acabado
    
    FROM iordem
    
    INNER JOIN prodserv ON (iordem.codi_psv = prodserv.codi_psv)
    INNER JOIN acompanhaordem ON (iordem.codi_aco = acompanhaordem.codi_aco)
    INNER JOIN etapa ON (acompanhaordem.codi_eta = etapa.codi_eta)
    INNER JOIN ordemproducao ON (acompanhaordem.codi_ord = ordemproducao.codi_ord)
    
ORDER BY acompanhaordem.codi_ord, acompanhaordem.codi_eta;
