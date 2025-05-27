-- Loja 05
-- Pedido: 3827/1


UPDATE pedido
    SET 
        pedido.fret_ped = 0,
        pedido.tota_ped = 508423.92999993,
        pedido.data_vlr = '12/02/1902',
        pedido.cond_con = 15,
        pedido.esta_ped = 0
WHERE 
    pedido.pedi_ped = 3827
    AND pedido.seri_ped = 1
    AND pedido.codi_emp = 5;


UPDATE ipedido
    SET ipedido.vlor_ipe = CASE
                                WHEN ipedido.codi_psv = '0007200' THEN 2421.066
                            END,
        ipedido.vlom_ipe = CASE
                                WHEN ipedido.codi_psv = '0007200' THEN 439.8500
                            END,
                            
        ipedido.tabe_cta = 10219
                            
WHERE 
    ipedido.pedi_ped = 3827
    AND ipedido.seri_ped = 1
    AND ipedido.codi_emp = 5;
--------------------------------------------------------------------------------

-- Loja 05
-- Pedido: 3879/1


UPDATE pedido
    SET 
        pedido.fret_ped = 0,
        pedido.tota_ped = 298126.650000053,
        pedido.data_vlr = '03/06/1902',
        pedido.cond_con = 15,
        pedido.esta_ped = 0
WHERE 
    pedido.pedi_ped = 3879
    AND pedido.seri_ped = 1
    AND pedido.codi_emp = 5;


UPDATE ipedido
    SET ipedido.vlor_ipe = CASE
                                WHEN ipedido.codi_psv = '0007200' THEN 2505.27
                            END,
        ipedido.vlom_ipe = CASE
                                WHEN ipedido.codi_psv = '0007200' THEN 455.5029
                            END,
                            
        ipedido.tabe_cta = 10219
                            
WHERE 
    ipedido.pedi_ped = 3879
    AND ipedido.seri_ped = 1
    AND ipedido.codi_emp = 5;
--------------------------------------------------------------------------------

-- Loja 05
-- Pedido: 3882/1


UPDATE pedido
    SET 
        pedido.fret_ped = 0,
        pedido.tota_ped = 132690.137323563,
        pedido.data_vlr = '12/02/1902',
        pedido.cond_con = 15,
        pedido.esta_ped = 0
WHERE 
    pedido.pedi_ped = 3882
    AND pedido.seri_ped = 1
    AND pedido.codi_emp = 5;


UPDATE ipedido
    SET ipedido.vlor_ipe = CASE
                                WHEN ipedido.codi_psv = '0007200' THEN 2503.59
                            END,
        ipedido.vlom_ipe = CASE
                                WHEN ipedido.codi_psv = '0007200' THEN 454.8421
                            END,
                            
        ipedido.tabe_cta = 10219
                            
WHERE 
    ipedido.pedi_ped = 3882
    AND ipedido.seri_ped = 1
    AND ipedido.codi_emp = 5;
--------------------------------------------------------------------------------
-- Loja 05
-- Pedido: 3886/1


UPDATE pedido
    SET 
        pedido.fret_ped = 0,
        pedido.tota_ped = 240684.6849624,
        pedido.data_vlr = '02/04/2021',
        pedido.cond_con = 15,
        pedido.esta_ped = 0
WHERE 
    pedido.pedi_ped = 3886
    AND pedido.seri_ped = 1
    AND pedido.codi_emp = 5;


UPDATE ipedido
    SET ipedido.vlor_ipe = CASE
                                WHEN ipedido.codi_psv = '0007200' THEN 2507.13
                            END,
        ipedido.vlom_ipe = CASE
                                WHEN ipedido.codi_psv = '0007200' THEN 443.0501
                            END,
                            
        ipedido.tabe_cta = 10219
                            
WHERE 
    ipedido.pedi_ped = 3886
    AND ipedido.seri_ped = 1
    AND ipedido.codi_emp = 5;
--------------------------------------------------------------------------------
-- Loja 05
-- Pedido: 3899/1


UPDATE pedido
    SET 
        pedido.fret_ped = 0,
        pedido.tota_ped = 393760.382621562,
        pedido.data_vlr = '20/02/1902',
        pedido.cond_con = 15,
        pedido.esta_ped = 0
WHERE 
    pedido.pedi_ped = 3899
    AND pedido.seri_ped = 1
    AND pedido.codi_emp = 5;

UPDATE ipedido
    SET ipedido.vlor_ipe = CASE
                                WHEN ipedido.codi_psv = '0007240' THEN 1988.69
                            END,
        ipedido.vlom_ipe = CASE
                                WHEN ipedido.codi_psv = '0007240' THEN 367.0319
                            END,
                            
        ipedido.tabe_cta = 10223                         
WHERE 
    ipedido.pedi_ped = 3899
    AND ipedido.seri_ped = 1
    AND ipedido.codi_emp = 5;
--------------------------------------------------------------------------------
-- Loja 05
-- Pedido: 3900/1


UPDATE pedido
    SET 
        pedido.fret_ped = 0,
        pedido.tota_ped = 190914.124319712,
        pedido.data_vlr = '20/02/1902',
        pedido.cond_con = 15,
        pedido.esta_ped = 0
WHERE 
    pedido.pedi_ped = 3900
    AND pedido.seri_ped = 1
    AND pedido.codi_emp = 5;


UPDATE ipedido
    SET ipedido.vlor_ipe = CASE
                                WHEN ipedido.codi_psv = '0007240' THEN 1988.69
                            END,
        ipedido.vlom_ipe = CASE
                                WHEN ipedido.codi_psv = '0007240' THEN 367.0319
                            END,
                            
        ipedido.tabe_cta = 10223
                            
WHERE 
    ipedido.pedi_ped = 3900
    AND ipedido.seri_ped = 1
    AND ipedido.codi_emp = 5;
--------------------------------------------------------------------------------
-- Loja 05
-- Pedido: 3932/1


UPDATE pedido
    SET 
        pedido.fret_ped = 0,
        pedido.tota_ped = 1302397.46000004,
        pedido.data_vlr = '03/06/1902',
        pedido.cond_con = 15,
        pedido.esta_ped = 0
WHERE 
    pedido.pedi_ped = 3932
    AND pedido.seri_ped = 1
    AND pedido.codi_emp = 5;


UPDATE ipedido
    SET ipedido.vlor_ipe = CASE
                                WHEN ipedido.codi_psv = '0007240' THEN 1803.87
                            END,
        ipedido.vlom_ipe = CASE
                                WHEN ipedido.codi_psv = '0007240' THEN 327.9772
                            END,
                            
        ipedido.tabe_cta = 10223
                            
WHERE 
    ipedido.pedi_ped = 3932
    AND ipedido.seri_ped = 1
    AND ipedido.codi_emp = 5;
--------------------------------------------------------------------------------

-- Loja 05
-- Pedido: 4078/1


UPDATE pedido
    SET 
        pedido.fret_ped = 0,
        pedido.tota_ped = 223306.2240,
        pedido.data_vlr = '02/04/2021',
        pedido.cond_con = 15,
        pedido.esta_ped = 0
WHERE 
    pedido.pedi_ped = 4078
    AND pedido.seri_ped = 1
    AND pedido.codi_emp = 5;


UPDATE ipedido
    SET ipedido.vlor_ipe = CASE
                                WHEN ipedido.codi_psv = '0007144' THEN 2746.76
                                WHEN ipedido.codi_psv = '0007645' THEN 2865.62
                            END,
        ipedido.vlom_ipe = CASE
                                WHEN ipedido.codi_psv = '0007144' THEN 485.3954
                                WHEN ipedido.codi_psv = '0007645' THEN 506.3998
                            END,
                            
        ipedido.tabe_cta = 10223
                            
WHERE 
    ipedido.pedi_ped = 4078
    AND ipedido.seri_ped = 1
    AND ipedido.codi_emp = 5;
--------------------------------------------------------------------------------
-- Loja 05
-- Pedido: 4098/1


UPDATE pedido
    SET 
        pedido.fret_ped = 0,
        pedido.tota_ped = 405155.20,
        pedido.data_vlr = '02/04/2021',
        pedido.cond_con = 15,
        pedido.esta_ped = 0
WHERE 
    pedido.pedi_ped = 4098
    AND pedido.seri_ped = 1
    AND pedido.codi_emp = 5;


UPDATE ipedido
    SET ipedido.vlor_ipe = CASE
                                WHEN ipedido.codi_psv = '0007144' THEN 2550.37
                                WHEN ipedido.codi_psv = '0008007' THEN 4719.55
                            END,
        ipedido.vlom_ipe = CASE
                                WHEN ipedido.codi_psv = '0007144' THEN 450.6914
                                WHEN ipedido.codi_psv = '0008007' THEN 834.0193
                            END,
                            
        ipedido.tabe_cta = 10219
                            
WHERE 
    ipedido.pedi_ped = 4098
    AND ipedido.seri_ped = 1
    AND ipedido.codi_emp = 5;
--------------------------------------------------------------------------------
-- Loja 05
-- Pedido: 4129/1


UPDATE pedido
    SET 
        pedido.fret_ped = 0,
        pedido.tota_ped = 490520.8,
        pedido.data_vlr = '02/04/2021',
        pedido.cond_con = 15,
        pedido.esta_ped = 0
WHERE 
    pedido.pedi_ped = 4129
    AND pedido.seri_ped = 1
    AND pedido.codi_emp = 5;


UPDATE ipedido
    SET ipedido.vlor_ipe = CASE
                                WHEN ipedido.codi_psv = '0007144' THEN 2787.05
                            END,
        ipedido.vlom_ipe = CASE
                                WHEN ipedido.codi_psv = '0007144' THEN 492.5161
                            END,
                            
        ipedido.tabe_cta = 10223
                            
WHERE 
    ipedido.pedi_ped = 4129
    AND ipedido.seri_ped = 1
    AND ipedido.codi_emp = 5;
--------------------------------------------------------------------------------
-- Loja 05
-- Pedido: 4146/1


UPDATE pedido
    SET 
        pedido.fret_ped = 0,
        pedido.tota_ped = 181579.976625,
        pedido.data_vlr = '02/04/2021',
        pedido.cond_con = 15,
        pedido.esta_ped = 0
WHERE 
    pedido.pedi_ped = 4146
    AND pedido.seri_ped = 1
    AND pedido.codi_emp = 5;


UPDATE ipedido
    SET ipedido.vlor_ipe = CASE
                                WHEN ipedido.codi_psv = '0007200' THEN 2421.07
                            END,
        ipedido.vlom_ipe = CASE
                                WHEN ipedido.codi_psv = '0007200' THEN 427.8909
                            END,
                            
        ipedido.tabe_cta = 10219
                            
WHERE 
    ipedido.pedi_ped = 4146
    AND ipedido.seri_ped = 1
    AND ipedido.codi_emp = 5;
--------------------------------------------------------------------------------
-- Loja 05
-- Pedido: 4147/1


UPDATE pedido
    SET 
        pedido.fret_ped = 0,
        pedido.tota_ped = 299192.07,
        pedido.data_vlr = '02/04/2021',
        pedido.cond_con = 15,
        pedido.esta_ped = 0
WHERE 
    pedido.pedi_ped = 4147
    AND pedido.seri_ped = 1
    AND pedido.codi_emp = 5;


UPDATE ipedido
    SET ipedido.vlor_ipe = CASE
                                WHEN ipedido.codi_psv = '0007240' THEN 1994.61
                            END,
        ipedido.vlom_ipe = CASE
                                WHEN ipedido.codi_psv = '0007240' THEN 352.4800
                            END,
                            
        ipedido.tabe_cta = 10219
                            
WHERE 
    ipedido.pedi_ped = 4147
    AND ipedido.seri_ped = 1
    AND ipedido.codi_emp = 5;
--------------------------------------------------------------------------------
-- Loja 05
-- Pedido: 4152/1


UPDATE pedido
    SET 
        pedido.fret_ped = 0,
        pedido.tota_ped = 518599.60000004,
        pedido.data_vlr = '02/04/2021',
        pedido.cond_con = 15,
        pedido.esta_ped = 0
WHERE 
    pedido.pedi_ped = 4152
    AND pedido.seri_ped = 1
    AND pedido.codi_emp = 5;


UPDATE ipedido
    SET ipedido.vlor_ipe = CASE
                                WHEN ipedido.codi_psv = '0007240' THEN 1994.61
                            END,
        ipedido.vlom_ipe = CASE
                                WHEN ipedido.codi_psv = '0007240' THEN 352.4800
                            END,
                            
        ipedido.tabe_cta = 10219
                            
WHERE 
    ipedido.pedi_ped = 4152
    AND ipedido.seri_ped = 1
    AND ipedido.codi_emp = 5;
--------------------------------------------------------------------------------
-- Loja 05
-- Pedido: 4153/1


UPDATE pedido
    SET 
        pedido.fret_ped = 0,
        pedido.tota_ped = 158436.059999973,
        pedido.data_vlr = '02/04/2021',
        pedido.cond_con = 15,
        pedido.esta_ped = 0
WHERE 
    pedido.pedi_ped = 4153
    AND pedido.seri_ped = 1
    AND pedido.codi_emp = 5;


UPDATE ipedido
    SET ipedido.vlor_ipe = CASE
                                WHEN ipedido.codi_psv = '0007240' THEN 2170.36
                            END,
        ipedido.vlom_ipe = CASE
                                WHEN ipedido.codi_psv = '0007240' THEN 383.5366
                            END,
                            
        ipedido.tabe_cta = 10219
                            
WHERE 
    ipedido.pedi_ped = 4153
    AND ipedido.seri_ped = 1
    AND ipedido.codi_emp = 5;
--------------------------------------------------------------------------------
-- Loja 05
-- Pedido: 4156/1


UPDATE pedido
    SET 
        pedido.fret_ped = 0,
        pedido.tota_ped = 53712.339999988,
        pedido.data_vlr = '02/04/2021',
        pedido.cond_con = 15,
        pedido.esta_ped = 0
WHERE 
    pedido.pedi_ped = 4156
    AND pedido.seri_ped = 1
    AND pedido.codi_emp = 5;


UPDATE ipedido
    SET ipedido.vlor_ipe = CASE
                                WHEN ipedido.codi_psv = '0007240' THEN 1852.15
                            END,
        ipedido.vlom_ipe = CASE
                                WHEN ipedido.codi_psv = '0007240' THEN 327.3043
                            END,
                            
        ipedido.tabe_cta = 10219
                            
WHERE 
    ipedido.pedi_ped = 4156
    AND ipedido.seri_ped = 1
    AND ipedido.codi_emp = 5;
--------------------------------------------------------------------------------
-- Loja 05
-- Pedido: 4157/1


UPDATE pedido
    SET 
        pedido.fret_ped = 0,
        pedido.tota_ped = 175647.219999966,
        pedido.data_vlr = '02/04/2021',
        pedido.cond_con = 15,
        pedido.esta_ped = 0
WHERE 
    pedido.pedi_ped = 4157
    AND pedido.seri_ped = 1
    AND pedido.codi_emp = 5;


UPDATE ipedido
    SET ipedido.vlor_ipe = CASE
                                WHEN ipedido.codi_psv = '0007240' THEN 2018.93
                            END,
        ipedido.vlom_ipe = CASE
                                WHEN ipedido.codi_psv = '0007240' THEN 356.7777
                            END,
                            
        ipedido.tabe_cta = 10219
                            
WHERE 
    ipedido.pedi_ped = 4157
    AND ipedido.seri_ped = 1
    AND ipedido.codi_emp = 5;
--------------------------------------------------------------------------------
-- Loja 05
-- Pedido: 4174/1


UPDATE pedido
    SET 
        pedido.fret_ped = 0,
        pedido.tota_ped = 112012.500000005,
        pedido.data_vlr = '12/02/1902',
        pedido.cond_con = 15,
        pedido.esta_ped = 0
WHERE 
    pedido.pedi_ped = 4174
    AND pedido.seri_ped = 1
    AND pedido.codi_emp = 5;


UPDATE ipedido
    SET ipedido.vlor_ipe = CASE
                                WHEN ipedido.codi_psv = '0007200' THEN 2036.59
                            END,
        ipedido.vlom_ipe = CASE
                                WHEN ipedido.codi_psv = '0007200' THEN 370.0000
                            END,
                            
        ipedido.tabe_cta = 10219
                            
WHERE 
    ipedido.pedi_ped = 4174
    AND ipedido.seri_ped = 1
    AND ipedido.codi_emp = 5;
--------------------------------------------------------------------------------
-- Loja 05
-- Pedido: /1


UPDATE pedido
    SET 
        pedido.fret_ped = 0,
        pedido.tota_ped = 112012.500000005,
        pedido.data_vlr = '12/02/1902',
        pedido.cond_con = 15,
        pedido.esta_ped = 0
WHERE 
    pedido.pedi_ped = 4174
    AND pedido.seri_ped = 1
    AND pedido.codi_emp = 5;


UPDATE ipedido
    SET ipedido.vlor_ipe = CASE
                                WHEN ipedido.codi_psv = '0007200' THEN 2036.59
                            END,
        ipedido.vlom_ipe = CASE
                                WHEN ipedido.codi_psv = '0007200' THEN 370.0000
                            END,
                            
        ipedido.tabe_cta = 10219
                            
WHERE 
    ipedido.pedi_ped = 4174
    AND ipedido.seri_ped = 1
    AND ipedido.codi_emp = 5;
--------------------------------------------------------------------------------
-- Loja 05
-- Pedido: 4211/1


UPDATE pedido
    SET 
        pedido.fret_ped = 0,
        pedido.tota_ped = 254552.16,
        pedido.data_vlr = '20/02/1902',
        pedido.cond_con = 15,
        pedido.esta_ped = 0
WHERE 
    pedido.pedi_ped = 4211
    AND pedido.seri_ped = 1
    AND pedido.codi_emp = 5;


UPDATE ipedido
    SET ipedido.vlor_ipe = CASE
                                WHEN ipedido.codi_psv = '0007240' THEN 1988.69
                            END,
        ipedido.vlom_ipe = CASE
                                WHEN ipedido.codi_psv = '0007240' THEN 367.0319
                            END,
                            
        ipedido.tabe_cta = 10223
                            
WHERE 
    ipedido.pedi_ped = 4211
    AND ipedido.seri_ped = 1
    AND ipedido.codi_emp = 5;
--------------------------------------------------------------------------------