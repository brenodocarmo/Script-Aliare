WITH tb_painel AS (
SELECT 
     ctrcompra.codi_emp AS empresa,
     ctrcompra.codi_cic AS ciclo,
     ctrcompra.nume_ccp AS contrato,
     CASE 
        WHEN ctrcompra.situ_ccp = 1 THEN 'Pendente'
        WHEN ctrcompra.situ_ccp = 4 THEN 'Liberado' 
        WHEN ctrcompra.situ_ccp = 5 THEN 'Fechado'
        WHEN ctrcompra.situ_ccp = 6 THEN 'Liberado Parcialmente'
        WHEN ctrcompra.situ_ccp = 9 THEN 'Cancelado'
    END AS status_contrato,
    tipoctrc.tipo_tic,
    tipoctrc.moda_tic,
    CASE
        WHEN tipoctrc.moda_tic = 2 THEN 'Valor Fixo'
        WHEN tipoctrc.moda_tic = 3 THEN 'Deposito'
        WHEN tipoctrc.moda_tic = 7 THEN 'Compra Direta'
    END AS modalidade,
    CASE
        WHEN tipoctrc.tipo_tic = 'E' THEN 'Entrada'
        ELSE 'Saida'
    END as operacao,
    ctrcompra.codi_tic,
    tipoctrc.desc_tic AS tipo_contrato,
    ctrcompra.cono_ccp AS contrato_original,
    ctrcompra.codi_tra,
    transac.raza_tra,
    COALESCE(ctrcompra.prop_pro, 0) prop_pro,
    COALESCE(propried.desc_pro, 'Ñ POSSUI') desc_pro,
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
    (SELECT MIN(ctrcompradep.DTIE_CDA) FROM ctrcompradep WHERE ctrcompradep.nume_ccp = ctrcompra.nume_ccp) AS dt_inicio_entregue,
    (SELECT MAX(ctrcompradep.DTFE_CDA) FROM ctrcompradep WHERE ctrcompradep.nume_ccp = ctrcompra.nume_ccp) AS dt_fim_entregue,
    CASE
        WHEN ((tipoctrc.moda_tic IN ('3', '7', '8', '10')) OR (tipoctrc.moda_tic = '1' and ognf_tic = 'C') OR (tipoctrc.tipo_tic = 'S'))
            OR (COALESCE(paramgerarmz.ecmo_pam, 'N') = 'T') OR (COALESCE(paramgerarmz.ecmo_pam, 'N') = 'A') OR (COALESCE(paramgerarmz.ecmo_pam, 'N') = 'A')
            OR ((COALESCE(paramgerarmz.ecmo_pam, 'N') = 'E') AND (tipoctrc.tipo_tic = 'E')) THEN 'R'
        ELSE
            'F'
    END AS tipo_baixa,
    ctrcompra.qtde_ccp,
    CASE
        WHEN tipoctrc.tipo_tic = 'S'
            THEN (select SALDO from table(QTDE_MOVIMENTADA(ctrcompra.nume_ccp, 0, 0, 'ROS', '01/01/2999')))
        ELSE    
            ((select SALDO from table(QTDE_MOVIMENTADA(ctrcompra.nume_ccp, 0, 0, 'ROE', '01/01/2999'))) +
            (select SALDO from table(QTDE_MOVIMENTADA(ctrcompra.nume_ccp, 0, 0, 'TRC', '01/01/2999'))))
    END AS entregue,
    (select SALDO from table(QTDE_MOVIMENTADA(ctrcompra.nume_ccp, 0, 0, 'ROE', '01/01/2999'))) AS qtde_roe,
    (select SALDO from table(QTDE_MOVIMENTADA(ctrcompra.nume_ccp, 0, 0, 'ROS', '01/01/2999'))) AS qtde_ros,
    (select SALDO from table(QTDE_MOVIMENTADA(ctrcompra.nume_ccp, 0, 0, 'TRD', '01/01/2999'))) AS qtde_trd,
    (select SALDO from table(QTDE_MOVIMENTADA(ctrcompra.nume_ccp, 0, 0, 'TRC', '01/01/2999'))) as qtde_trc,
    (select SALDO from table(QTDE_MOVIMENTADA(ctrcompra.nume_ccp, 0, 0, 'NFD', '01/01/2999'))) as qtde_nfd,
    (select SALDO from table(QTDE_MOVIMENTADA(ctrcompra.nume_ccp, 0, 0, 'FIX', '01/01/2999'))) as qtde_fixada,
    (select SALDO from table(QTDE_MOVIMENTADA(ctrcompra.nume_ccp, 0, 0, 'BCO', '01/01/2999'))) as qtde_bco,
    CASE 
        WHEN ctrcompra.codi_tic = 44 
            THEN (select SALDO from table(QTDE_MOVIMENTADA(ctrcompra.nume_ccp, 0, 0, 'ROS', '01/01/2999'))) + 
                 (select SALDO from table(QTDE_MOVIMENTADA(ctrcompra.nume_ccp, 0, 0, 'TRD', '01/01/2999')))
        ELSE 0
    END AS qtde_devolvido,
    ctrcompra.dven_ccp,
    COALESCE(ctrcompra.vlor_ccp, 0) vlor_ccp,
    COALESCE(ctrcompra.tota_ccp, 0) tota_ccp,
    COALESCE(ctrcompra.vbim_ccp, 0) vbim_ccp,
    COALESCE(ctrcompra.vliq_ccp, 0) vliq_ccp,
    COALESCE(ctrcompra.vlip_ccp, 0) vlip_ccp,
    COALESCE(ctrcompra.vftn_ccp, 0) vftn_ccp
FROM ctrcompra
JOIN transac ON (ctrcompra.codi_tra = transac.codi_tra)
LEFT JOIN propried ON (ctrcompra.prop_pro = propried.prop_pro)
JOIN prodserv ON (ctrcompra.codi_psv = prodserv.codi_psv)
JOIN tipoctrc ON (ctrcompra.codi_tic = tipoctrc.codi_tic)
LEFT JOIN paramgerarmz ON (ctrcompra.codi_emp = paramgerarmz.codi_emp)
LEFT JOIN ctrcompradep ON (ctrcompra.nume_ccp = ctrcompradep.nume_ccp)
WHERE 
    ctrcompra.nume_ccp IN (10790, 12244, 10797, 9363, 10812, 11142, 11493, 11363)
ORDER BY ctrcompra.codi_tic
)
SELECT 
    tb_painel.empresa,
    tb_painel.ciclo,
    tb_painel.contrato,
    tb_painel.status_contrato,
    tb_painel.moda_tic,
    tb_painel.modalidade,
    tb_painel.operacao,
    tb_painel.codi_tic,
    tb_painel.tipo_contrato,
    tb_painel.contrato_original,
    tb_painel.codi_tra,
    tb_painel.raza_tra,
    tb_painel.prop_pro,
    tb_painel.desc_pro,
    tb_painel.codi_psv,
    tb_painel.desc_psv,
    tb_painel.data_ccp,
    tb_painel.fret_ccp,
    tb_painel.frete,
    tb_painel.dt_inicio_entregue,
    tb_painel.dt_fim_entregue,    
    tb_painel.tipo_baixa,
    tb_painel.qtde_ccp,
    tb_painel.entregue,
    tb_painel.qtde_devolvido,
    tb_painel.qtde_bco,
    CASE
        WHEN tb_painel.tipo_tic = 'E'
            THEN ((tb_painel.qtde_roe + tb_painel.qtde_trc) - (tb_painel.qtde_ros + tb_painel.qtde_trd + tb_painel.qtde_nfd))
        ELSE
            ((tb_painel.qtde_ros + tb_painel.qtde_trd) - (tb_painel.qtde_roe + tb_painel.qtde_trc + tb_painel.qtde_nfd))
    END AS qdte_deposito,
    CASE
        WHEN tb_painel.moda_tic = '3' THEN
            CASE
                WHEN tb_painel.tipo_tic = 'E' 
                    THEN ((tb_painel.qtde_ccp - (tb_painel.qtde_roe + tb_painel.qtde_trc)) - tb_painel.qtde_bco + tb_painel.qtde_nfd)
                ELSE
                    ((tb_painel.qtde_ccp - (tb_painel.qtde_roe + tb_painel.qtde_trd)) - tb_painel.qtde_bco + tb_painel.qtde_nfd)
            END
        ELSE
            CASE 
                WHEN tb_painel.tipo_tic = 'E'
                    THEN ((tb_painel.qtde_ccp - (tb_painel.qtde_roe + tb_painel.qtde_trc - tb_painel.qtde_ros)) - tb_painel.qtde_bco + tb_painel.qtde_nfd)
                ELSE
                    ((tb_painel.qtde_ccp - (tb_painel.qtde_ros + tb_painel.qtde_trd - tb_painel.qtde_roe)) - tb_painel.qtde_bco + tb_painel.qtde_nfd)
            END                 
    END AS saldo,
    tb_painel.dven_ccp,
    tb_painel.vlor_ccp,
    tb_painel.tota_ccp,
    tb_painel.vbim_ccp,
    tb_painel.vliq_ccp,
    tb_painel.vlip_ccp,
    tb_painel.vftn_ccp
FROM tb_painel;