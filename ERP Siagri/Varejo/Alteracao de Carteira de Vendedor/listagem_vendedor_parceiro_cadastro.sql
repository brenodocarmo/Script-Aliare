/*
Este script tem como função exibir a a relação de vendedores com os parceiros em cada loja do ERP Siagri
*/

SELECT
    *
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
    );