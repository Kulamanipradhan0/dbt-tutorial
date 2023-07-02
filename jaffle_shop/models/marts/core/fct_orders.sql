with payments as 
(select 
    order_id, 
    payment_amount 
from {{ref('stg_payments')}}
),
orders as (
    select 
        order_id,
        customer_id,
        order_date,
        status 
    from {{ref('stg_orders')}}
),
order_payments as (
    select
        order_id,
        sum(case when status = 'completed' then payment_amount end) as amount
    from payments join orders using (order_id)
    group by 1
)
select
orders.order_id,
orders.customer_id,
coalesce(order_payments.amount,0) as payment_amount,
orders.order_date,
orders.status as order_status
from orders left join order_payments using (order_id)