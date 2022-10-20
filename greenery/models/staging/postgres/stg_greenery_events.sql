{{ config(
    materialized="table"
    ) }}

select 
    event_id
    , event_type
    , created_at
    , order_id
    , page_url
    , product_id
    , session_id
    , user_id
from 
    {{source('src_greenery', 'events')}}