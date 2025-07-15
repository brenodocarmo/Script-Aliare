
WITH tb_romaneio AS (
    SELECT 
        --romaneio.*,
        romaneio.codi_emp,
        romaneio.nume_rom,
        romaneio.demi_rom,
        romaneio.npla_vei,
        romaneio.situ_rom,
        CASE
            WHEN romaneio.situ_rom = 1 THEN 'EMITIDO'
            WHEN romaneio.situ_rom = 5 THEN 'TENHO QUE VALIAR'
            WHEN romaneio.situ_rom = 9 THEN 'CANCELADO'
            
            ELSE romaneio.situ_rom
        END AS situ_romaneio,
        romaneio.tipo_rom,
        CASE
            WHEN romaneio.tipo_rom = 'E' THEN 'ENTRADA'
            ELSE 'SAIDA'
        END AS tipo_romaneio,
        romaneio.liqu_rom,
        romaneio.cmot_rom,
        CASE
            WHEN romaneio.ctra_tra IS NULL THEN 0
            ELSE romaneio.ctra_tra
        END AS codi_transportador,
        CASE
            WHEN romaneio.traz_tra IS NULL THEN 'NÃO INFORMADO'
            ELSE romaneio.traz_tra
        END AS nome_transportadora,
        transac.codi_tra AS codi_parceiro,
        transac.raza_tra AS parceiro,
        deposito.desc_dpt,
        ciclo.codi_cic,
        ciclo.desc_cic,
        prodserv.desc_psv
    FROM romaneio
    
    JOIN transac ON (romaneio.codi_tra = transac.codi_tra)
    JOIN prodserv ON (romaneio.codi_psv = prodserv.codi_psv)
    JOIN ciclo ON (romaneio.codi_cic = ciclo.codi_cic)
    JOIN deposito ON (romaneio.codi_dpt = deposito.codi_dpt)
    
    WHERE (romaneio.demi_rom between '29/01/25' and '29/05/25')
    --WHERE (romaneio.demi_rom between '29/01/25' and '29/05/25') and romaneio.codi_emp = 1 and ciclo.codi_cic = 22 and romaneio.nume_rom = 99282
)

SELECT 
    tb_romaneio.codi_emp AS codi_emp_rom,
    tb_romaneio.desc_cic,
    tb_romaneio.desc_dpt,
    tb_romaneio.nume_rom,
    tb_romaneio.desc_psv,
    tb_romaneio.demi_rom,
    tb_romaneio.npla_vei,
    tb_romaneio.situ_rom AS codi_situ_rom,
    tb_romaneio.situ_romaneio,
    tb_romaneio.tipo_romaneio,
    tb_romaneio.liqu_rom,
    tb_romaneio.cmot_rom,
    tb_romaneio.codi_transportador,
    tb_romaneio.nome_transportadora,
    tb_romaneio.codi_parceiro,
    tb_romaneio.parceiro,
    notaorig.notd_nfr,
    nota.codi_emp AS codi_emp_nf,
    nota.demi_not,
    nota.nota_not,
    nota.seri_not AS seri_not_nf,
    nota.qtde_not
    

FROM tb_romaneio

JOIN notaorig ON (tb_romaneio.codi_emp = notaorig.codi_emp and tb_romaneio.codi_parceiro = notaorig.trao_nfr and tb_romaneio.nume_rom = notaorig.noto_nfr)
JOIN nota ON (notaorig.notd_nfr = nota.npre_not)

ORDER BY tb_romaneio.demi_rom 


