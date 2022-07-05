1-
create trigger order_update
After update on order_details
for each row
begin
update products set quantity_in_stock = quantity_in_stock - ( new.quantity_ordered - old.quantity_ordered ) where id = new.product_id;
end;
create trigger order_insert
After insert on order_details
for each row
begin
update products set quantity_in_stock = quantity_in_stock - quantity_ordered where id = product_id;
end;
create trigger order_delete
After insert on order_details
for each row
begin
update products set quantity_in_stock = quantity_in_stock + old.quantity_ordered where id = old.product_id;
end;


2-
create view view1 As select p.id,p.name,sum(o.quantity_ordered),sum(o.quantity_ordered)*( p.sell_price - p.buy_price ) from products as p,order_details as o where p.id = o.product_id group by p.id;


3-
select * from orders as o , payments as p where o.id = p.order_id and o.order_date < current_date - 10 and p.payment_date = null;


4-
create trigger payment_insert
After insert on payments
for each row
begin
if new.payment_type = 'cash' then
update orders set shipped_date = payment_date where order_id = id and shipped_date = null;
end if;
end;


5-
create trigger payment_insert
After insert on payments
for each row
begin
if new.payment_type = 'cash' then
update orders set shipped_date = payment_date where order_id = id and shipped_date = null;
end if;
end;


6-
create trigger reduce_cost1
After update on products 
for each row
begin
if new.quantity_in_stock = 1 then
set new.sell_price = old.sell_price*(0.8) where old.sell_price*(0.8) > old.buy_price ;
set new.sell_price = old.buy_price where sell_price*(0.8) <= buy_price;
end if;
end;

7-


8-
with pro_sum (prname,prsum) as ( select p.name , sum(od.quantity_ordered) from products as p , order_details as od , orders as o where p.id = od.product_id and od.order_id = o.id and o.order_date > (current_date -30) group by p.category ) select prsum from pro_sum where prsum = ( select max(prsum) from pro_sum);

