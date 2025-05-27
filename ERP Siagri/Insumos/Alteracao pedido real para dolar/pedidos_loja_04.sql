
--Alteração deu certo do pedido:


-- Loja 04
-- Pedido: 83/1


UPDATE pedido
    SET 
        pedido.fret_ped = 0,
        pedido.tota_ped = 319186.14,
        pedido.data_vlr = '02/04/2021',
        pedido.cond_con = 15,
        pedido.esta_ped = 0
WHERE 
    pedido.pedi_ped = 83
    AND pedido.seri_ped = 1
    AND pedido.codi_emp = 4;


UPDATE ipedido
    SET ipedido.vlor_ipe = CASE
                                WHEN ipedido.codi_psv = '0007200' THEN 2553.49
                            END,
        ipedido.vlom_ipe = CASE
                                WHEN ipedido.codi_psv = '0007200' THEN 451.2422
                            END,
                            
        ipedido.tabe_cta = 10219
                            
WHERE 
    ipedido.pedi_ped = 83
    AND ipedido.seri_ped = 1
    AND ipedido.codi_emp = 4;
--------------------------------------------------------------------------------

-- Loja 04
-- Pedido: 86/1


UPDATE pedido
    SET 
        pedido.fret_ped = 0,
        pedido.tota_ped = 844571.350000056,
        pedido.data_vlr = '02/04/2021',
        pedido.cond_con = 15,
        pedido.esta_ped = 0
WHERE 
    pedido.pedi_ped = 86
    AND pedido.seri_ped = 1
    AND pedido.codi_emp = 4;


UPDATE ipedido
    SET ipedido.vlor_ipe = CASE
                                WHEN ipedido.codi_psv = '0007240' THEN 1946.02 
                            END,
                            
        ipedido.vlom_ipe = CASE
                                WHEN ipedido.codi_psv = '0007240' THEN  343.8922 
                            END,
                            
        ipedido.tabe_cta = 10219
                            
WHERE 
    ipedido.pedi_ped = 86
    AND ipedido.seri_ped = 1
    AND ipedido.codi_emp = 4;
--------------------------------------------------------------------------------

-- Loja 04
-- Pedido: 119/1


UPDATE pedido
    SET 
        pedido.fret_ped = 0,
        pedido.tota_ped = 467479.48,
        pedido.data_vlr = '20/02/1902',
        pedido.cond_con = 15,
        pedido.esta_ped = 0
WHERE 
    pedido.pedi_ped = 119
    AND pedido.seri_ped = 1
    AND pedido.codi_emp = 4;


UPDATE ipedido
    SET ipedido.vlor_ipe = CASE
                                WHEN ipedido.codi_psv = '0007629' THEN 3596.996 
                            END,
                            
        ipedido.vlom_ipe = CASE
                                WHEN ipedido.codi_psv = '0007629' THEN  663.6761 
                            END,
                            
        ipedido.tabe_cta = 10219
                            
WHERE 
    ipedido.pedi_ped = 119
    AND ipedido.seri_ped = 1
    AND ipedido.codi_emp = 4;

--------------------------------------------------------------------------------

-- Loja 04
-- Pedido: 153/1


UPDATE pedido
    SET 
        pedido.fret_ped = 0,
        pedido.tota_ped = 334792,
        pedido.data_vlr = '01/05/1902',
        pedido.cond_con = 15,
        pedido.esta_ped = 0
WHERE 
    pedido.pedi_ped = 153
    AND pedido.seri_ped = 1
    AND pedido.codi_emp = 4;


UPDATE ipedido
    SET ipedido.vlor_ipe = CASE
                                WHEN ipedido.codi_psv = '0007629' THEN 3347.92 
                            END,
                            
        ipedido.vlom_ipe = CASE
                                WHEN ipedido.codi_psv = '0007629' THEN  617.6974 
                            END,
                            
        ipedido.tabe_cta = 10219
                            
WHERE 
    ipedido.pedi_ped = 153
    AND ipedido.seri_ped = 1
    AND ipedido.codi_emp = 4;
--------------------------------------------------------------------------------

-- Loja 04
-- Pedido: 196/1


UPDATE pedido
    SET 
        pedido.fret_ped = 0,
        pedido.tota_ped = 486008.89,
        pedido.data_vlr = '02/04/2021',
        pedido.cond_con = 15,
        pedido.esta_ped = 0
WHERE 
    pedido.pedi_ped = 196
    AND pedido.seri_ped = 1
    AND pedido.codi_emp = 4;


UPDATE ipedido
    SET ipedido.vlor_ipe = CASE
                                WHEN ipedido.codi_psv = '0007240' THEN 1944.04 
                            END,
                            
        ipedido.vlom_ipe = CASE
                                WHEN ipedido.codi_psv = '0007240' THEN 343.5420 
                            END,
                            
        ipedido.tabe_cta = 10219
                            
WHERE 
    ipedido.pedi_ped = 196
    AND ipedido.seri_ped = 1
    AND ipedido.codi_emp = 4;
--------------------------------------------------------------------------------

-- Loja 04
-- Pedido: 242/1


UPDATE pedido
    SET 
        pedido.fret_ped = 0,
        pedido.tota_ped = 672465.21318518,
        pedido.data_vlr = '20/02/1902',
        pedido.cond_con = 15,
        pedido.esta_ped = 0
WHERE 
    pedido.pedi_ped = 242
    AND pedido.seri_ped = 1
    AND pedido.codi_emp = 4;


UPDATE ipedido
    SET ipedido.vlor_ipe = CASE
                                WHEN ipedido.codi_psv = '0007629' THEN 3413.53 
                            END,
                            
        ipedido.vlom_ipe = CASE
                                WHEN ipedido.codi_psv = '0007629' THEN 630 
                            END,
                            
        ipedido.tabe_cta = 10219
                            
WHERE 
    ipedido.pedi_ped = 242
    AND ipedido.seri_ped = 1
    AND ipedido.codi_emp = 4;
--------------------------------------------------------------------------------

-- Loja 04
-- Pedido: 243/1


UPDATE pedido
    SET 
        pedido.fret_ped = 0,
        pedido.tota_ped = 1097248.54073016,
        pedido.data_vlr = '20/02/1902',
        pedido.cond_con = 15,
        pedido.esta_ped = 0
WHERE 
    pedido.pedi_ped = 243
    AND pedido.seri_ped = 1
    AND pedido.codi_emp = 4;


UPDATE ipedido
    SET ipedido.vlor_ipe = CASE
                                WHEN ipedido.codi_psv = '0007629' THEN 3304.97 
                            END,
                            
        ipedido.vlom_ipe = CASE
                                WHEN ipedido.codi_psv = '0007629' THEN 609.9635 
                            END,
                            
        ipedido.tabe_cta = 10219
                            
WHERE 
    ipedido.pedi_ped = 243
    AND ipedido.seri_ped = 1
    AND ipedido.codi_emp = 4;

--------------------------------------------------------------------------------
