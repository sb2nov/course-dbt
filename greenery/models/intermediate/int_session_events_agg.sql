{{
    config(
        materialized='table'
    )
}}

with events as (
    select * from {{ ref('stg_greenery_events')}}
),

final as (
    SELECT
          user_id
        , session_id
        , min(created_at) session_start
        , max(case when event_type != 'package_shipped' then created_at else NULL end) session_end
        , timediff(second, min(created_at), max(case when event_type != 'package_shipped' then created_at else NULL end)) session_duration
        , count(*) as total_events
        , count(distinct product_id) as total_products
        , sum(case when event_type = 'add_to_cart' then 1 else 0 end) as add_to_cart
        , sum(case when event_type = 'checkout' then 1 else 0 end) as checkouts
        , sum(case when event_type = 'package_shipped' then 1 else 0 end) as package_shipped
        , sum(case when event_type = 'page_view' then 1 else 0 end) as page_views
    from events
    group by 1,2
)

select * from final