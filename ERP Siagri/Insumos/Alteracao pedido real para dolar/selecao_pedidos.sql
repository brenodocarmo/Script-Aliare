WITH tb_pedido AS (
SELECT
    
    pedido.codi_tra,
    transac.raza_tra,
    nota.codi_emp    nota_empresa,
    nota.nota_not,
    nota.seri_not,
    nota.tota_not tota_nota,
    ipedido.codi_emp pedido_empresa,
    ipedido.pedi_ped,
    ipedido.seri_ped,
    ipedido.codi_psv,
    prodserv.desc_psv,
    pedido.cond_con,
    pedido.codi_top,
    pedido.data_vlr,
    pedido.tabe_cta AS pedido_tabe_cta,
    pedido.tota_ped,
    ipedido.vlor_ipe,
    ipedido.vliq_ipe,
    ipedido.vlom_ipe vlor_dolar_pedido,
    inota.vlom_ino   vlor_dolar_nota,
    pedido.fret_ped,
    pedido.vcto_ped,
    CASE
        WHEN pedido.esta_ped = 0  THEN 'Pedido Não liberado Comercial'
        WHEN pedido.esta_ped = 1  THEN 'Pedido liberado Comercial'
        WHEN pedido.esta_ped = 2  THEN 'Pedido Não Liberado Financeiro'
        WHEN pedido.esta_ped = 3  THEN 'Pedido Liberado Financeiro'
        WHEN pedido.esta_ped = 9  THEN 'Pedido Confirmado (Integralmente)'
        WHEN pedido.esta_ped = 10 THEN 'Pedido Confirmado (Parcialmente)'
        WHEN pedido.esta_ped = 11 THEN 'Pedido Cancelado'
    END statu_pedido,
    TO_CHAR(pedido.data_vlr,'DD/MM/YYYY') data_ptx_pedido
FROM
    ipedido
    JOIN inota ON ( ipedido.codi_emp = inota.empr_ped
                    AND ipedido.pedi_ped = inota.pedi_ped
                    AND ipedido.seri_ped = inota.seri_ped
                    AND ipedido.codi_psv = inota.codi_psv )
    JOIN nota ON ( inota.npre_not = nota.npre_not )
    JOIN prodserv ON ( ipedido.codi_psv = prodserv.codi_psv )
    JOIN pedido ON ( ipedido.codi_emp = pedido.codi_emp
                     AND ipedido.pedi_ped = pedido.pedi_ped
                     AND ipedido.seri_ped = pedido.seri_ped )
    JOIN transac ON ( pedido.codi_tra = transac.codi_tra )
WHERE
    ipedido.codi_emp = 4
    --AND ipedido.pedi_ped IN ( 83, 86, 119, 153, 196, 242, 243)
    AND ipedido.pedi_ped IN ( 86, 119, 153, 196, 242, 243)
    AND ipedido.seri_ped = 1
ORDER BY
    ipedido.pedi_ped
)

    SELECT 
    cabrec.codi_tdo,
    tb_pedido.*,
    cabrec.ctrl_cbr,
    receber.ctrl_rec,
    TO_CHAR(receber.data_vlr,'DD/MM/YYYY')  data_ptx_doc_rec
    
    FROM tb_pedido
    
    
    LEFT JOIN cabrec ON (
        tb_pedido.nota_empresa = cabrec.codi_emp AND 
        tb_pedido.nota_not = cabrec.nume_cbr AND 
        tb_pedido.seri_not = cabrec.seri_cbr)
    
    LEFT JOIN receber ON (cabrec.ctrl_cbr = receber.ctrl_cbr)
    
    
    ORDER BY receber.ctrl_rec
