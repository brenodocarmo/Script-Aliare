

WITH cte_historico_parceiro AS (
-- 1. Resumos do historico dos parceiros da Agroindustria

SELECT
    nota.codi_tra AS codigo_parceiro,
    transac.raza_tra AS razao_social,

    MAX(nota.demi_not) KEEP (DENSE_RANK FIRST ORDER BY nota.tota_not DESC) AS data_maior_compra,
    MAX(tota_not) AS valor_maior_compra, 

    MAX(nota.demi_not) KEEP (DENSE_RANK FIRST ORDER BY nota.tota_not ASC) AS data_menor_compra,
    MIN(nota.tota_not) AS valor_menor_compra,

    MAX(nota.demi_not) AS ultima_compra,
    MAX(nota.tota_not) KEEP (DENSE_RANK FIRST ORDER BY nota.demi_not DESC) AS valor_ultima_compra,

    SUM(nota.tota_not) AS valor_total,
    COUNT(*) AS qtd_vezes,

    ROUND((SUM(nota.tota_not) / COUNT(*)),2) AS ticket_medio, 

    TRUNC(SYSDATE - MAX(demi_not)) AS recencia,
    CASE
        WHEN TRUNC(SYSDATE - compra.data_ultima_compra) >= 0 AND TRUNC(SYSDATE - compra.data_ultima_compra) <= 10 THEN '0 - 10'
        WHEN TRUNC(SYSDATE - compra.data_ultima_compra) >= 11 AND TRUNC(SYSDATE - compra.data_ultima_compra) <= 20 THEN '11 - 20'
        WHEN TRUNC(SYSDATE - compra.data_ultima_compra) >= 21 AND TRUNC(SYSDATE - compra.data_ultima_compra) <= 30 THEN '21 - 30'
        WHEN TRUNC(SYSDATE - compra.data_ultima_compra) >= 31 AND TRUNC(SYSDATE - compra.data_ultima_compra) <= 40 THEN '31 - 40'
        WHEN TRUNC(SYSDATE - compra.data_ultima_compra) >= 41 AND TRUNC(SYSDATE - compra.data_ultima_compra) <= 50 THEN '41 - 50'
        WHEN TRUNC(SYSDATE - compra.data_ultima_compra) >= 51 AND TRUNC(SYSDATE - compra.data_ultima_compra) <= 60 THEN '51 - 60'
        WHEN TRUNC(SYSDATE - compra.data_ultima_compra) >= 61 THEN 'Maior que 61'
    END AS segmentacao_recencia,,

    RANK() OVER(ORDER BY SUM(nota.tota_not) DESC) AS rank

FROM nota 

INNER JOIN transac ON transac.codi_tra = nota.codi_tra

WHERE 
    nota.situ_not = 5 
    AND nota.ccfo_cfo IN (****)

GROUP BY nota.codi_tra, transac.raza_tra
ORDER BY rank

),

cte_percentual AS (
-- 2 Percentual de faturamento por parceiro
  
    SELECT 
        chp.codigo_parceiro,
        chp.razao_social,
        chp.data_maior_compra,
        chp.valor_maior_compra,
        chp.data_menor_compra,
        chp.valor_menor_compra,
        chp.ultima_compra,
        chp.valor_ultima_compra,
        chp.qtd_vezes,
        chp.ticket_medio,
        chp.recencia,
        chp.valor_total,
        chp.rank,
  		sum(chp.valor_total) over(order by chp.valor_total desc) as acumulado,
        sum(chp.valor_total) over(order by chp.valor_total desc) AS total_acumulado,
        (chp.valor_total / sum(chp.valor_total) over() * 100) AS percentual

    FROM cte_historico_parceiro chp

),

cte_curva_abc AS (
-- 3. Percentual acumulado do parceiro
  
    SELECT 
        codigo_parceiro,
        razao_social,
        data_maior_compra,
        valor_maior_compra,
        data_menor_compra,
        valor_menor_compra,
        ultima_compra,
        valor_ultima_compra,
        qtd_vezes,
        ticket_medio,
        recencia,
        valor_total,
  		acumulado,
        total_acumulado,
        percentual,
        sum(percentual) over(order by valor_total desc) AS percentual_acumulado,
        rank
    FROM cte_percentual

    order by valor_total desc
    )

SELECT
    codigo_parceiro,
    razao_social,
    data_maior_compra,
    valor_maior_compra,
    data_menor_compra,
    valor_menor_compra,
    ultima_compra,
    valor_ultima_compra,
    valor_total,
    acumulado,
    total_acumulado,
    percentual,
    percentual_acumulado,
    
    CASE
        WHEN percentual_acumulado <= 80 THEN 'A'
        WHEN percentual_acumulado <= 95 THEN 'B'
        ELSE 'C'
    END AS curva,
    rank
    
FROM cte_curva_abc