/*
Este script realiza a atribuição de vendedor no cadastro do parceiro
*/


UPDATE vendedorcli
SET
    vendedorcli.cod1_pes = 'codigo vendedor'
WHERE
    vendedorcli.codi_tra IN (
        SELECT
            vendedorcli.codi_tra
        FROM
            vendedorcli
        WHERE
            vendedorcli.codi_tra IN (
                SELECT
                    transac.codi_tra
                FROM
                    transac
                WHERE
                    transac.cgc_tra IN ( 'colocar o cpf/cnpj' )
            )
    );