use curso;
-- ************************************************************
-- LABORATORIO CONSULTAS_AVANZADAS_LABORATORIO
-- Carlos Selman 2018325 IN5BM
-- ************************************************************
-- 01. Cláusula GROUP BY
-- ------------------------------------------------------------
-- Resuelve los siguientes incisos 
-- utilizando la cláusula GROUP BY.
-- ------------------------------------------------------------
-- 1) Agrupar las ventas por día.
select Ventas_Fecha as "FECHA", sum(Ventas_Total) as "TOTAL"
from ventas group by Ventas_Fecha;
-- 2) Agrupar las ventas por día, pero separando la fecha por año, mes, 
-- día.
select 
	year(Ventas_Fecha) as "AÑO",
	month(Ventas_Fecha) as "MES",
	day(Ventas_Fecha) as "DIA",
	sum(Ventas_Total) as "TOTAL"
from ventas group by AÑO,MES,DIA;
-- 3) Agrupar las ventas por mes.
select 
	year(Ventas_Fecha) as "AÑO",
	month(Ventas_Fecha) as "MES",
	sum(Ventas_Total) as "TOTAL"
from ventas group by AÑO,MES;
-- 4) Mostrar la venta máxima por mes.
select 
	year(Ventas_Fecha) as "AÑO",
	month(Ventas_Fecha) as "MES",
	MAX(Ventas_Total) as "VENTA MAXIMA"
from ventas group by AÑO,MES;
-- 5) Mostrar la venta mínima por mes.
select 
	year(Ventas_Fecha) as "AÑO",
	month(Ventas_Fecha) as "MES",
	MIN(Ventas_Total) as "VENTA MINIMA"
from ventas group by AÑO,MES;
-- 6) Mostrar el promedio de ventas por mes.
select 
	year(Ventas_Fecha) as "AÑO",
	month(Ventas_Fecha) as "MES",
	avg(Ventas_Total) as "PROMEDIO"
from ventas group by AÑO,MES;
-- 7) Mostrar el total de ventas al cliente con ClidId = 1 
-- (Este es el cliente consumidor final).
select 
	year(Ventas_Fecha) as "AÑO",
	month(Ventas_Fecha) as "MES",
	sum(Ventas_Total) as "TOTAL"
from ventas where Ventas_CliId = 1 group by AÑO,MES;
-- 8) Mostrar de las ventas, la máxima, la mínima, el promedio,
--  el total y la cantidad por mes.
select 
	year(Ventas_Fecha) as "AÑO",
	month(Ventas_Fecha) as "MES",
	MIN(Ventas_Total) as "VENTA MINIMA",
	MAX(Ventas_Total) as "VENTA MAXIMA",
    avg(Ventas_Total) as "PROMEDIO",
	sum(Ventas_Total) as "TOTAL",
    count(Ventas_Total) as "OPERACIONES"
from ventas group by AÑO,MES;
-- 9) Mostrar de las ventas, la máxima, la mínima, el promedio,
-- el total y la cantidad por mes. Del cliente 1 (Consumidor final).
select 
	year(Ventas_Fecha) as "AÑO",
	month(Ventas_Fecha) as "MES",
	MIN(Ventas_Total) as "VENTA MINIMA",
	MAX(Ventas_Total) as "VENTA MAXIMA",
    avg(Ventas_Total) as "PROMEDIO",
	sum(Ventas_Total) as "TOTAL",
    count(Ventas_Total) as "OPERACIONES"
from ventas where Ventas_CliId = 1 group by AÑO,MES;
-- ************************************************************
-- 02. Subconsultas con Cláusulas IN y NOT IN:
-- ------------------------------------------------------------
-- Utilizando
-- las cláusulas IN y NOT IN según sea el caso, resolver
-- los siguientes incisos.
-- ------------------------------------------------------------
-- 1) Mostrar los clientes con los identificadores: 1,5,6 y 10 y su
-- razón social, utilizando la cláusula IN.
select  Cli_Id,Cli_RazonSocial from clientes where Cli_Id in(1,5,6,10);
-- 2) Mostrar los clientes que no tengan los identificadores:
-- 1,5,6 y 10 y su razón social, utilizando la cláusula NOT IN.
select  Cli_Id,Cli_RazonSocial from clientes where Cli_Id not in(1,5,6,10);
-- 3) Mostrar los identificadores y razón social de los clientes
-- que han hecho alguna compra (deberían ser los clientes de
-- la tabla clientes que estén en la tabla ventas). Ordenar los
-- clientes por ID.
select distinct c.Cli_Id,c.Cli_RazonSocial from clientes c, ventas v where c.Cli_Id in(v.Ventas_CliId);
-- 4) Mostrar los identificadores y razón social de los clientes
-- que no han hecho ninguna compra (deberían ser los
-- clientes de la tabla clientes que no estén en la tabla
-- ventas). Ordenar los clientes por ID.
select distinct c.Cli_Id,c.Cli_RazonSocial from clientes c, ventas v where c.Cli_Id not in(v.Ventas_CliId);
-- 5) Mostrar los identificadores y razón social de los clientes
-- que han comprado en el mes de febrero.
select c.Cli_Id,c.Cli_RazonSocial from clientes c, ventas v where c.Cli_Id in(select v.Ventas_CliId
    from ventas v
    where v.Ventas_Fecha between "2018-02-01" and "2018-02-31");
-- 6) Mostrar los identificadores y razón social de los clientes
-- que no han comprado durante el mes de enero.
select c.Cli_Id,c.Cli_RazonSocial from clientes c, ventas v where c.Cli_Id not in(select v.Ventas_CliId
    from ventas v
    where v.Ventas_Fecha between "2018-01-01" and "2018-01-31");
-- 7) Mostrar los productos (Identificador y descripción) que
-- nunca han sido vendidos.
select distinct p.Prod_Id,p.Prod_Descripcion  from productos p,ventas_detalle vd where p.Prod_Id not in(vd.VD_ProdId);
-- 8) Mostrar la lista de productos (identificador y descripción)
-- que no se han vendido durante el mes de febrero.
select p.Prod_Id,p.Prod_Descripcion from productos p,ventas_detalle vd,ventas v where p.Prod_Id not in(select vd.VD_ProdId
    from ventas_detalle vd
    where vd.VD_VentasId=v.Ventas_Id and 
    v.Ventas_Fecha between "2018-02-01" and "2018-02-29");