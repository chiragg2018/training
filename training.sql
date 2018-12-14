select t1.c_code , t1.c_name as name, 'AH_'||t1.c_code as concate_code, t1.distributor_id,t3.c_code as rack_code, t3.c_name as rack,t2.tot_sale_qty ,t4.stock_qty
from pharmassist.item_mst as t1
left join 
(select n_distributor_id,c_dist_item_code,sum(n_total_qty) as tot_sale_qty
from  level1.sales
where date(dt_time) BETWEEN CURRENT_DATE-180 and CURRENT_DATE-1  
GROUP BY 1,2)t2
on t1.c_code=t2.c_dist_item_code and t1.distributor_id=t2.n_distributor_id
left join pharmassist.rack_mst as t3
on t1.c_rack_code=t3.c_code  and t1.distributor_id=t3.distributor_id
left join
(select n_distributor_id,c_dist_item_code,sum(n_balance_qty) as stock_qty
from  level1.stock_day_end
where d_date=CURRENT_DATE-1  
GROUP BY 1,2
)t4
on t1.c_code=t4.c_dist_item_code and t1.distributor_id=t4.n_distributor_id
where t1.distributor_id=6
--GROUP by 1,2,3,4,5,6
