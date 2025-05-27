WITH docsReceber AS (
    SELECT
        cabrec.ctrl_cbr,
        receber.ctrl_rec,
        cabrec.codi_emp codiEmpresa,
        cabrec.codi_tra codiParceiro,
        cabrec.codi_tdo codiTipoDocumento,
        tipdoc.desc_tdo descDocumento,
        cabrec.nume_cbr numDocumento,
        cabrec.seri_cbr serDocumento,
        receber.npar_rec parcelaDocumento,
        receber.venc_rec vencDocumento,
        cabrec.tota_cbr vlorReceber,
        CASE
            WHEN cabrec.situ_cbr = 'A' THEN 'Aberto'
            WHEN cabrec.situ_cbr = 'C' THEN 'Cancelado'
        END AS situacaoDocumento
    FROM cabrec
    JOIN tipdoc ON (cabrec.codi_tdo = tipdoc.codi_tdo)
    JOIN receber ON (cabrec.ctrl_cbr = receber.ctrl_cbr)
    WHERE 
        codi_tra = 10005563
        AND cabrec.situ_cbr <> 'C' -- Elimina os documentos com status cancelados
),

vlorPagoDocumento AS (
    SELECT
        docsReceber.ctrl_cbr,
        docsReceber.ctrl_rec,
        docsReceber.codiEmpresa,
        docsReceber.codiParceiro,
        docsReceber.codiTipoDocumento,
        docsReceber.descDocumento,
        docsReceber.numDocumento,
        docsReceber.serDocumento,
        docsReceber.parcelaDocumento,
        docsReceber.vencDocumento,
        SYSDATE dataAtual,
        docsReceber.vlorReceber,
        COALESCE(SUM(crcbaixa.vlor_bai), 0) vlorPago,
        (docsReceber.vlorReceber - COALESCE(SUM(crcbaixa.vlor_bai), 0)) inicial_valor_pagar,
        CASE
            WHEN (docsReceber.vlorReceber - COALESCE(SUM(crcbaixa.vlor_bai), 0)) = 0 THEN 'Quitado'
            WHEN (docsReceber.vlorReceber > COALESCE(SUM(crcbaixa.vlor_bai), 0)) THEN 
                CASE 
                    WHEN docsReceber.vencDocumento < SYSDATE THEN 'Vencido'
                    ELSE 'Normal'
                END
        END situacao
    FROM docsReceber 
    LEFT JOIN crcbaixa ON (docsReceber.ctrl_rec = crcbaixa.ctrl_rec)
    GROUP BY     
        docsReceber.ctrl_cbr,
        docsReceber.ctrl_rec,
        docsReceber.codiEmpresa,
        docsReceber.codiParceiro,
        docsReceber.codiTipoDocumento,
        docsReceber.descDocumento,
        docsReceber.numDocumento,
        docsReceber.serDocumento,
        docsReceber.parcelaDocumento,
        docsReceber.vencDocumento,
        docsReceber.vlorReceber,
        docsReceber.situacaoDocumento
),

em_aberto AS (
    SELECT
        vlorPagoDocumento.codiParceiro,
        COALESCE(SUM(inicial_valor_pagar),0) AS faturado_em_aberto,
        COALESCE(SUM(CASE WHEN situacao = 'Vencido' THEN inicial_valor_pagar ELSE 0 END),0) AS contasVencidas
    FROM vlorPagoDocumento
    GROUP BY vlorPagoDocumento.codiParceiro
)

SELECT 
    codiParceiro,
    faturado_em_aberto,
    contasVencidas
FROM em_aberto


--- Certo