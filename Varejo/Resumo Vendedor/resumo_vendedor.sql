/*
Autor: Breno do Carmo Sousa

Objetivo: Evidenciar quais itens foram vendidos por cada vendedor do segmento de Varejo

Data: 22/10/2024

*/

CREATE OR REPLACE VIEW vw_resumo_vendedor_varejo
  
  SELECT
    nota.codi_cic codi_ciclo,
    nota.cod1_pes codi_vendedor,
    pessoal.nome_pes nome_vendedor,
    grupo.desc_gpr grupo_produto,
    subgrupo.desc_sbg,
    inota.codi_psv codi_produto,
    prodserv.desc_psv desc_produto,
    prodserv.unid_psv unidade_medida,
    sum(inota.qtde_ino) quantidade,
    round((sum(inota.qtde_ino * inota.vliq_ino) / sum(inota.qtde_ino)),4) valor_unitario,
    round(sum(inota.qtde_ino * inota.vliq_ino),2) valor_total

    FROM nota

    INNER JOIN inota on (nota.npre_not = inota.npre_not)
    INNER JOIN prodserv on (inota.codi_psv = prodserv.codi_psv)
    INNER JOIN pessoal ON (nota.cod1_pes = pessoal.codi_pes)
    INNER JOIN grupo ON (prodserv.codi_gpr = grupo.codi_gpr)
    INNER JOIN subgrupo ON (prodserv.codi_sbg = subgrupo.codi_sbg)
    INNER JOIN cfo on (nota.ccfo_cfo =  cfo.ccfo_cfo)

    WHERE
        nota.situ_not = 5
        AND (UPPER(cfo.desc_cfo) LIKE 'VENDA%AGROINDUSTRIA%' OR 
            UPPER(cfo.desc_cfo) LIKE 'SERVIÇO%EMPACOTAMENTO%')                 

    GROUP BY 
        nota.codi_cic,
        inota.codi_psv,
        prodserv.desc_psv,
        nota.cod1_pes,
        pessoal.nome_pes,
        grupo.desc_gpr,
        prodserv.unid_psv,
        subgrupo.desc_sbg

    ORDER BY pessoal.nome_pes, prodserv.desc_psv
    ;
