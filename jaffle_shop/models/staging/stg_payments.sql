select
    id as payment_id,
    order_id,
    payment_method,
    amount/100 as payment_amount

from {{ source('jaffle_shop','payments')}}