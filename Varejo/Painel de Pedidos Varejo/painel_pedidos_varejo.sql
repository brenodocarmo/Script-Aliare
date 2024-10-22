WITH
    cte_pedidos_listados as (
        SELECT
            pedido.codi_emp empresa,
            pedido.codi_cic ciclo,
            pedido.demi_ped data_emissao,
            pedido.pedi_ped num_pedido,
            pedido.seri_ped serie_pedido,
            pedido.codi_top codi_operacao,
            pedido.cond_con codi_condicao_pag,
            pedido.codi_tra codigo_parceiro,
            transac.cgc_tra cnpj_cpf,
            transac.raza_tra razao_social,
            sum(ipedido.qtde_ipe) qtde_pedida,
            pedido.tota_ped valor_total_pedido,
            pedido.pliq_ped peso_liquido,
            pedido.pbru_ped peso_bruto,
            sum(ipedido.QPER_IPE) qtde_perdida,
            pedido.esta_ped codi_statu_pedido,
            CASE
                WHEN pedido.esta_ped = 0 THEN 'Pedido Não liberado Comercial'
                WHEN pedido.esta_ped = 1 THEN 'Pedido liberado Comercial'
                WHEN pedido.esta_ped = 2 THEN 'Pedido Não Liberado Finaceiro'
                WHEN pedido.esta_ped = 3 THEN 'Pedido Liberado Financeiro'
                WHEN pedido.esta_ped = 9 THEN 'Pedido Confirmado (Integralmente)'
                WHEN pedido.esta_ped = 10 THEN 'Pedido Confirmado (Parcialmente)'
                WHEN pedido.esta_ped = 11 THEN 'Pedido Cancelado'
            END statu_pedido
        FROM
            pedido
            INNER JOIN condicao ON (pedido.cond_con = condicao.cond_con)
            INNER JOIN transac ON (pedido.codi_tra = transac.codi_tra)
            INNER JOIN ipedido ON (
                pedido.pedi_ped = ipedido.pedi_ped
                AND pedido.codi_emp = ipedido.codi_emp
                AND pedido.seri_ped = ipedido.seri_ped
            )
        WHERE
            pedido.codi_emp = 7
        GROUP BY
            pedido.codi_emp,
            pedido.codi_cic,
            pedido.demi_ped,
            pedido.pedi_ped,
            pedido.seri_ped,
            pedido.codi_top,
            pedido.cond_con,
            transac.cgc_tra,
            pedido.codi_tra,
            transac.raza_tra,
            pedido.tota_ped,
            pedido.pliq_ped,
            pedido.pbru_ped,
            pedido.tpro_ped,
            pedido.esta_ped
    ),
    dados_pedidos as (
        SELECT
            p.empresa,
            p.ciclo,
            p.data_emissao,
            p.num_pedido,
            p.serie_pedido,
            p.codi_operacao,
            p.codi_condicao_pag,
            p.cnpj_cpf,
            p.codigo_parceiro,
            p.razao_social,
            p.valor_total_pedido,
            p.peso_liquido,
            p.peso_bruto,
            COALESCE(sum(inota.qtde_ino * produto.pbru_pro), 0) peso_faturado,
            p.qtde_pedida,
            COALESCE(SUM(inota.qtde_ino), 0) qtde_faturada,
            p.qtde_perdida,
            COALESCE(SUM(inota.qdev_ino), 0) qtde_devolvida,
            CASE
                WHEN p.qtde_perdida > 0 THEN (p.qtde_pedida - COALESCE(SUM(inota.qtde_ino), 0)) - p.qtde_perdida
                ELSE p.qtde_pedida - COALESCE(SUM(inota.qtde_ino), 0)
            END saldo,
            p.codi_statu_pedido,
            p.statu_pedido
        FROM
            cte_pedidos_listados p
            LEFT JOIN inota ON (
                p.num_pedido = inota.pedi_ped
                AND p.serie_pedido = inota.seri_ped
                AND p.empresa = inota.empr_ped
            )
            LEFT JOIN produto ON (produto.codi_psv = inota.codi_psv)
        GROUP BY
            p.empresa,
            p.ciclo,
            p.data_emissao,
            p.num_pedido,
            p.serie_pedido,
            p.codi_operacao,
            p.codi_condicao_pag,
            p.cnpj_cpf,
            p.codigo_parceiro,
            p.razao_social,
            p.valor_total_pedido,
            p.qtde_pedida,
            p.peso_liquido,
            p.peso_bruto,
            p.valor_total_pedido,
            p.codi_statu_pedido,
            p.statu_pedido,
            p.qtde_perdida
    ),
    dados_pedido as (
        SELECT
            dados.empresa,
            dados.ciclo,
            dados.data_emissao,
            dados.num_pedido,
            dados.serie_pedido,
            dados.codi_operacao,
            dados.codi_condicao_pag,
            dados.codigo_parceiro,
            dados.cnpj_cpf || '-' || dados.razao_social razao_social, --CONCATENANDO CPF E RAZAO SOCIAL
            dados.valor_total_pedido,
            dados.peso_bruto,
            dados.peso_faturado,
            dados.qtde_pedida,
            dados.qtde_faturada,
            dados.qtde_perdida,
            dados.qtde_devolvida,
            dados.saldo,
            dados.codi_statu_pedido,
            dados.statu_pedido
        FROM
            dados_pedidos dados
    ),
    central_pedidos as (
        select
            dados_pedidos.empresa,
            dados_pedidos.ciclo,
            ciclo.desc_cic desc_ciclo,
            dados_pedidos.data_emissao,
            dados_pedidos.num_pedido,
            dados_pedidos.serie_pedido,
            dados_pedidos.codi_operacao,
            tipooper.desc_top desc_operacao,
            dados_pedidos.codi_condicao_pag,
            condicao.desc_con desc_pagamento,
            dados_pedidos.codigo_parceiro,
            dados_pedidos.razao_social,
            dados_pedidos.valor_total_pedido,
            dados_pedidos.peso_bruto,
            dados_pedidos.peso_faturado,
            dados_pedidos.qtde_pedida,
            dados_pedidos.qtde_faturada,
            CASE
                WHEN dados_pedidos.qtde_pedida > 0 THEN (
                    dados_pedidos.qtde_faturada / dados_pedidos.qtde_pedida
                ) * 100
            END percent_fat,
            dados_pedidos.qtde_perdida,
            CASE
                WHEN dados_pedidos.qtde_perdida > 0 THEN (
                    dados_pedidos.qtde_perdida / dados_pedidos.qtde_pedida
                ) * 100
                ELSE 0.00
            END percent_perdida,
            dados_pedidos.qtde_devolvida,
            CASE
                WHEN dados_pedidos.qtde_devolvida > 0 THEN (
                    dados_pedidos.qtde_devolvida / dados_pedidos.qtde_pedida
                ) * 100
                ELSE 0.00
            END percent_devolvida,
            dados_pedidos.saldo,
            CASE
                WHEN dados_pedidos.saldo > 0 THEN (dados_pedidos.saldo / dados_pedidos.qtde_pedida) * 100
                ELSE 0.00
            END percent_saldo,
            dados_pedidos.codi_statu_pedido,
            dados_pedidos.statu_pedido
        from
            dados_pedidos
            INNER JOIN ciclo ON (dados_pedidos.ciclo = ciclo.codi_cic)
            INNER JOIN condicao ON (
                dados_pedidos.codi_condicao_pag = condicao.cond_con
            )
            INNER JOIN tipooper ON (dados_pedidos.codi_operacao = tipooper.codi_top)
    )
SELECT
    central_pedidos.empresa,
    central_pedidos.ciclo,
    central_pedidos.desc_ciclo,
    central_pedidos.data_emissao,
    central_pedidos.num_pedido,
    central_pedidos.serie_pedido,
    central_pedidos.codi_operacao,
    central_pedidos.desc_operacao,
    central_pedidos.codi_condicao_pag,
    central_pedidos.desc_pagamento,
    central_pedidos.codigo_parceiro,
    central_pedidos.razao_social,
    central_pedidos.valor_total_pedido,
    central_pedidos.peso_bruto,
    central_pedidos.peso_faturado,
    (
        central_pedidos.peso_bruto - central_pedidos.peso_faturado
    ) peso_a_ser_faturado,
    central_pedidos.qtde_pedida,
    central_pedidos.qtde_faturada,
    ROUND(central_pedidos.percent_fat, 2) percent_fat,
    central_pedidos.qtde_perdida,
    ROUND(central_pedidos.percent_perdida, 2) percent_perdida,
    central_pedidos.qtde_devolvida,
    ROUND(central_pedidos.percent_devolvida, 2) percent_devolvida,
    central_pedidos.saldo,
    ROUND(central_pedidos.percent_saldo, 2) percent_saldo,
    central_pedidos.codi_statu_pedido,
    central_pedidos.statu_pedido
FROM
    central_pedidos