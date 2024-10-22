/*
Autor: Breno do Carmo Sousa

Objetivo: Evidenciar quais itens foram vendidos por cada vendedor do segmento de Varejo

Data: 22/10/2024

*/

SELECT
    nota.cod1_pes codi_vendedor,
    pessoal.nome_pes nome_vendedor,
    inota.codi_psv codi_produto,
    prodserv.desc_psv desc_produto,
    sum(inota.qtde_ino) quantidade,
    round((sum(inota.qtde_ino * inota.vliq_ino) / sum(inota.qtde_ino)),4) valor_unitario,
    round(sum(inota.qtde_ino * inota.vliq_ino),2) valor_total

FROM nota

INNER JOIN inota on (nota.npre_not = inota.npre_not)
INNER JOIN prodserv on (inota.codi_psv = prodserv.codi_psv)
INNER JOIN pessoal ON (nota.cod1_pes = pessoal.codi_pes)

WHERE
    nota.situ_not = 5
    and nota.codi_cic = 29
    and nota.ccfo_cfo in (510114, 510115, 510113, 510112, 510111,
                        510120, 510131, 510123, 510130 )
GROUP BY 
    nota.codi_emp,
    inota.codi_psv,
    prodserv.desc_psv,
    nota.cod1_pes,
    pessoal.nome_pes

ORDER BY pessoal.nome_pes, prodserv.desc_psv
;
