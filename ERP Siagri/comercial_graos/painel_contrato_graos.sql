
SELECT 
     ctrcompra.codi_emp,
     ctrcompra.codi_cic,
     ctrcompra.nume_ccp,
     CASE 
        WHEN ctrcompra.situ_ccp = 1 THEN 'Pendente'
        WHEN ctrcompra.situ_ccp = 4 THEN 'Liberado' 
        WHEN ctrcompra.situ_ccp = 5 THEN 'Fechado'
        WHEN ctrcompra.situ_ccp = 6 THEN 'Liberado Parcialmente'
        WHEN ctrcompra.situ_ccp = 9 THEN 'Cancelado'
    END AS status_contrato,
    CASE
        WHEN tipoctrc.moda_tic = 2 THEN 'Valor Fixo'
        WHEN tipoctrc.moda_tic = 3 THEN 'Deposito'
        WHEN tipoctrc.moda_tic = 7 THEN 'Compra Direta'
    END AS "Modalidade",
    CASE
        WHEN tipoctrc.tipo_tic = 'E' THEN 'Entrada'
        ELSE 'Saida'
    END as operacao,
    ctrcompra.codi_tic,
    tipoctrc.desc_tic,
    ctrcompra.cono_ccp ccp_original,
    ctrcompra.codi_tra,
    transac.raza_tra,
    COALESCE(ctrcompra.prop_pro, 0) prop_pro,
    COALESCE(propried.desc_pro, 'ñ possui') desc_pro,
    ctrcompra.codi_psv,
    prodserv.desc_psv,
    ctrcompra.data_ccp,
    ctrcompra.fret_ccp,
    CASE
        WHEN ctrcompra.fret_ccp = 0 THEN 'Terceiros - CIF'
        WHEN ctrcompra.fret_ccp = 1 THEN 'Emitente - CIF'
        WHEN ctrcompra.fret_ccp = 2 THEN 'Destinatário - FOB'
        WHEN ctrcompra.fret_ccp = 3 THEN 'Proprio por conta do remetente'
        WHEN ctrcompra.fret_ccp = 4 THEN 'Proprio por conta do destinatario'
        WHEN ctrcompra.fret_ccp = 9 THEN 'Sem cobranca'
    END as frete,
    ctrcompra.qtde_ccp,
    CASE
        WHEN tipoctrc.tipo_tic = 'S'
            THEN (select SALDO from table(QTDE_MOVIMENTADA(ctrcompra.nume_ccp, 0, 0, 'ROS', '01/01/2999'))) --AS "Qtd. Saída"
        ELSE    
            ((select SALDO from table(QTDE_MOVIMENTADA(ctrcompra.nume_ccp, 0, 0, 'ROE', '01/01/2999'))) +
            (select SALDO from table(QTDE_MOVIMENTADA(ctrcompra.nume_ccp, 0, 0, 'TRC', '01/01/2999')))) --AS "Entregue",
    END AS "Entregue",
    
    CASE 
        WHEN ctrcompra.codi_tic = 44 
            THEN (select SALDO from table(QTDE_MOVIMENTADA(ctrcompra.nume_ccp, 0, 0, 'ROS', '01/01/2999'))) + 
                 (select SALDO from table(QTDE_MOVIMENTADA(ctrcompra.nume_ccp, 0, 0, 'TRD', '01/01/2999')))
        ELSE 0
    END AS "Devolvido"
    
    


FROM ctrcompra

JOIN transac ON (ctrcompra.codi_tra = transac.codi_tra)
LEFT JOIN propried ON (ctrcompra.prop_pro = propried.prop_pro)
JOIN prodserv ON (ctrcompra.codi_psv = prodserv.codi_psv)
JOIN tipoctrc ON (ctrcompra.codi_tic = tipoctrc.codi_tic)


WHERE 
    ctrcompra.nume_ccp IN (10790, 12244, 10797, 9363, 10812, 11142, 11493)

order by ctrcompra.codi_tic