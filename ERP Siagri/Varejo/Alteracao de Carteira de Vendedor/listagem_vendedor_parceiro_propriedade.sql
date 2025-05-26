/*
Este script tem como função exibir a a relação de vendedores com os parceiros em cada loja do ERP Siagri com suas respectivas propriedades
*/


SELECT
    *
FROM
    vendedorpropried
WHERE
    vendedorpropried.prop_pro IN (
        SELECT
            propried.prop_pro
        FROM
            propried
        WHERE
            propried.codi_tra IN (
                SELECT
    --COUNT(*)
                    transac.codi_tra
                FROM
                    transac
                WHERE
                    transac.cgc_tra IN ( '34825786000106', '02339157000171', '35252092000262', '35252092000181', '35252092000424',
                                         '35252092000343', '16980257000278', '16980257000359', '16980257000430', '16980257000197',
                                         '52662722000105', '01716187000197', '32137543000222', '34825786000289', '51109704000138',
                                         '54414798000147', '04267390000111', '55480044000158', '27858913000108', '33228024000909' )
            )
    );