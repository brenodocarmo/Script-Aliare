

CREATE OR REPLACE view vw_painel_cliente_varejo as

WITH cte_hitorico_compra as (
    
    SELECT
        nota.codi_tra AS codigo_parceiro,
        transac.raza_tra AS razao_social,
        MAX(nota.demi_not) KEEP (DENSE_RANK FIRST ORDER BY nota.tota_not DESC) AS data_maior_compra,
        MAX(tota_not) AS valor_maior_compra, 
        MAX(nota.demi_not) KEEP (DENSE_RANK FIRST ORDER BY nota.tota_not ASC) AS data_menor_compra,
        MIN(nota.tota_not) AS valor_menor_compra,
        MAX(nota.demi_not) AS data_ultima_compra,
        MAX(nota.tota_not) KEEP (DENSE_RANK FIRST ORDER BY nota.nota_not DESC) AS valor_ultima_compra,
        SUM(nota.tota_not) AS valor_total,
        COUNT(*) AS qtd_vezes,
        ROUND((SUM(nota.tota_not) / COUNT(*)),2) AS ticket_medio
    FROM nota
    
    INNER JOIN transac ON transac.codi_tra = nota.codi_tra
    INNER JOIN cfo on (nota.ccfo_cfo =  cfo.ccfo_cfo)
    
    WHERE
        nota.situ_not = 5 
        AND (UPPER(cfo.desc_cfo) LIKE 'VENDA%AGROINDUSTRIA%' OR UPPER(cfo.desc_cfo) LIKE 'SERVIÇO%EMPACOTAMENTO%')  
    GROUP BY nota.codi_tra, transac.raza_tra
    ),
    
cte_recencia_varejo as (
    
    SELECT
        rank() over (order by compra.valor_total desc) rank,
        compra.*,
        
        TRUNC(SYSDATE - compra.data_ultima_compra) AS recencia,
        CASE
            WHEN TRUNC(SYSDATE - compra.data_ultima_compra) >= 0 AND TRUNC(SYSDATE - compra.data_ultima_compra) <= 15 THEN '0-15'
            WHEN TRUNC(SYSDATE - compra.data_ultima_compra) >= 16 AND TRUNC(SYSDATE - compra.data_ultima_compra) <= 30 THEN '16-30'
            WHEN TRUNC(SYSDATE - compra.data_ultima_compra) >= 31 AND TRUNC(SYSDATE - compra.data_ultima_compra) <= 45 THEN '31-45'
            WHEN TRUNC(SYSDATE - compra.data_ultima_compra) >= 41 AND TRUNC(SYSDATE - compra.data_ultima_compra) <= 60 THEN '41-60'
  					WHEN TRUNC(SYSDATE - compra.data_ultima_compra) >= 61 AND TRUNC(SYSDATE - compra.data_ultima_compra) <= 85 THEN '61-85'
            WHEN TRUNC(SYSDATE - compra.data_ultima_compra) >= 86 THEN '>86'
        END AS segmentacao_recencia,
        
        (compra.valor_total / sum(compra.valor_total) over() * 100) AS percentual
        
    FROM cte_hitorico_compra compra
    )
    
SELECT * FROM  cte_recencia_varejo;

