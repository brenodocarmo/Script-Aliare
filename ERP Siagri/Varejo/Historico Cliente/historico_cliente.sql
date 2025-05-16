

CREATE OR REPLACE view vw_painel_compra_varejo as

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
        AND (UPPER(cfo.desc_cfo) LIKE 'VENDA%AGROINDUSTRIA%' OR 
            UPPER(cfo.desc_cfo) LIKE 'SERVIÇO%EMPACOTAMENTO%')  
        --nota.ccfo_cfo IN (510111, 510112, 510113, 510114, 510115, 510120, 510123, 510130, 510131)
    GROUP BY nota.codi_tra, transac.raza_tra
    ),
    
cte_recencia_varejo as (
    
    SELECT 
        compra.codigo_parceiro,
        compra.razao_social,
        compra.data_maior_compra,
        compra.valor_maior_compra,
        compra.data_menor_compra,
        compra.valor_menor_compra,
        compra.data_ultima_compra,
        compra.valor_ultima_compra,
        compra.valor_total,
        compra.qtd_vezes,
        compra.ticket_medio,
        
        TRUNC(SYSDATE - compra.data_ultima_compra) AS recencia,
        CASE
            WHEN TRUNC(SYSDATE - compra.data_ultima_compra) >= 0 AND TRUNC(SYSDATE - compra.data_ultima_compra) <= 15 THEN '0-15'
            WHEN TRUNC(SYSDATE - compra.data_ultima_compra) >= 16 AND TRUNC(SYSDATE - compra.data_ultima_compra) <= 30 THEN '16-30'
            WHEN TRUNC(SYSDATE - compra.data_ultima_compra) >= 31 AND TRUNC(SYSDATE - compra.data_ultima_compra) <= 45 THEN '31-45'
            WHEN TRUNC(SYSDATE - compra.data_ultima_compra) >= 41 AND TRUNC(SYSDATE - compra.data_ultima_compra) <= 60 THEN '41-60'
  					WHEN TRUNC(SYSDATE - compra.data_ultima_compra) >= 61 AND TRUNC(SYSDATE - compra.data_ultima_compra) <= 85 THEN '61-85'
            WHEN TRUNC(SYSDATE - compra.data_ultima_compra) >= 86 THEN '>86'
        END AS segmentacao_recencia,
        
        rank() over (order by valor_total desc) rank
    FROM cte_hitorico_compra compra
    ),

cte_valor_acumulado as (
    SELECT 
        varejo.codigo_parceiro,
        varejo.razao_social,
        varejo.data_maior_compra,
        varejo.valor_maior_compra,
        varejo.data_menor_compra,
        varejo.valor_menor_compra,
        varejo.data_ultima_compra,
        varejo.valor_ultima_compra,
        varejo.valor_total,
        varejo.qtd_vezes,
        varejo.ticket_medio,
        varejo.recencia,
        varejo.segmentacao_recencia,
        varejo.rank,
        
        sum(varejo.valor_total) over(order by varejo.valor_total desc) as acumulado,
        sum(varejo.valor_total) over() AS total_acumulado,
        (varejo.valor_total / sum(varejo.valor_total) over() * 100) AS percentual
        
    FROM cte_recencia_varejo varejo
    ),
    
cte_percentual_acumulado as (
    SELECT 
        acumulado.codigo_parceiro,
        acumulado.razao_social,
        acumulado.data_maior_compra,
        acumulado.valor_maior_compra,
        acumulado.data_menor_compra,
        acumulado.valor_menor_compra,
        acumulado.data_ultima_compra,
        acumulado.valor_ultima_compra,
        acumulado.valor_total,
        acumulado.qtd_vezes,
        acumulado.ticket_medio,
        acumulado.recencia,
        acumulado.segmentacao_recencia,
        acumulado.rank,
        acumulado.acumulado,
        acumulado.total_acumulado,
        acumulado.percentual,
        
        sum(acumulado.percentual) over(order by acumulado.valor_total desc) AS percentual_acumulado
        
    FROM cte_valor_acumulado acumulado
    ),
    
cte_curva_abc as (
    SELECT
        curva.codigo_parceiro,
        curva.razao_social,
        curva.data_maior_compra,
        curva.valor_maior_compra,
        curva.data_menor_compra,
        curva.valor_menor_compra,
        curva.data_ultima_compra,
        curva.valor_ultima_compra,
        curva.valor_total,
        curva.qtd_vezes,
        curva.ticket_medio,
        curva.recencia,
        curva.segmentacao_recencia,
        curva.rank,
        --curva.acumulado,
        --curva.total_acumulado,
        curva.percentual,
        --curva.percentual_acumulado,
       
        CASE
            WHEN curva.percentual_acumulado <= 80 THEN 'A'
            WHEN curva.percentual_acumulado <= 95 THEN 'B'
        ELSE 'C'
        END AS curva_abc
    
    FROM cte_percentual_acumulado curva
    )

SELECT * FROM cte_curva_abc;