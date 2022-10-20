{{ config(
    materialized="table"
    ) }}

select 
    promo_id
    , discount
    , status
from 
    {{source('src_greenery', 'promos')}}