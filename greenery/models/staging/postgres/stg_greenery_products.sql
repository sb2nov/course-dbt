{{ config(
    materialized="table"
    ) }}

select 
    product_id
    , name
    , price
    , inventory
from 
    {{source('src_greenery', 'products')}}