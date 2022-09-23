-- Sales
select  w.MetropolitanAreaId,
tr.ProductVariantId,
pv.Name Product,
count(tr.SalePrice) [Sale Quantity],
sum(tr.SalePrice) [Sale Amount]

from ThingRequest tr
join Shipment s on s.id=tr.ShipmentId
join ProductVariant pv on pv.id=tr.ProductVariantId
join Warehouse w on w.id=s.WarehouseId
where s.ReconciledOn is not null
and s.ReconciledOn>= '2022-01-23 00:00 +06:00'
and s.ReconciledOn< '2022-01-26 00:00 +06:00'
and s.ShipmentStatus not in (1,9,10)
and IsCancelled=0
and IsReturned=0
and HasFailedBeforeDispatch=0
and IsMissingAfterDispatch=0
and tr.ProductVariantId in (
select ProductVariantId from ProductVariantCategoryMapping
where CategoryId in (25,1235,1262,61)
or ProductVariantId in (6568)
)
group by tr.ProductVariantId,pv.Name,w.MetropolitanAreaId

-- MP
select w.MetropolitanAreaId,pv.id, pv.Name, count(distinct t.id) MP_Quantity, sum(t.costprice) MP_Cost
from thingtransaction tss
join ThingEvent te on tss.id = te.ThingTransactionid
join Warehouse w on te.warehouseId = w.id
Join Thing t on t.id = te.thingid
JOIN productvariant pv on pv.id = t.productvariantid
where tss.CreatedOn >= '2022-01-23 00:00:01 +6:00'
and tss.CreatedOn < '2022-01-26 00:00:01 +6:00'
and FromState IN (536870912,8388608,262144)
and ToState in (65536, 16777216, 268435456)
and te.ThingId <= 128269853
and te.ThingId >= 127500668
and tss.Id <= 199348155
and tss.Id >= 198689924
group by pv.id,pv.name,w.MetropolitanAreaId

-- Missing
select w.MetropolitanAreaId,pv.id, pv.Name, count(distinct t.id) Missing_Quantity, sum(t.costprice) Missing_Cost
from thingtransaction tss
join ThingEvent te on tss.id = te.ThingTransactionid
join Warehouse w on te.warehouseId = w.id
Join Thing t on t.id = te.thingid
JOIN productvariant pv on pv.id = t.productvariantid
where tss.CreatedOn >= '2022-01-23 00:00:01 +6:00'
and tss.CreatedOn < '2022-01-26 00:00:01 +6:00'
and ToState in (16)
and te.ThingId <= 128269833
and te.ThingId >= 40983022
and tss.Id <= 199359182
and tss.Id >= 198663541
group by pv.id,pv.name,w.MetropolitanAreaId

-- Damage
select w.MetropolitanAreaId,pv.id, pv.Name, count(distinct t.id) Damage_Quantity, sum(t.costprice) Damage_Cost
from thingtransaction tss
join ThingEvent te on tss.id = te.ThingTransactionid
join Warehouse w on te.warehouseId = w.id
Join Thing t on t.id = te.thingid
JOIN productvariant pv on pv.id = t.productvariantid
where tss.CreatedOn >= '2022-01-23 00:00:01 +6:00'
and tss.CreatedOn < '2022-01-26 00:00:01 +6:00'
and ToState in (8,32)
and te.ThingId <= 128269833
and te.ThingId >= 40983022
and tss.Id <= 199359182
and tss.Id >= 198663541
group by pv.id,pv.name,w.MetropolitanAreaId