{{
    config(
        materialized='table'
    )
}}

with products as (
    select * from {{ ref('stg_greenery_products')}}
)

select * from products