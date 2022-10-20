{{
    config(
        materialized='table'
    )
}}

with sessions as (
    select *
    from {{ ref('int_session_events_agg') }}
)

select 
      user_id
    , min(session_start) first_session
    , max(session_start) last_session
    , count(*) sessions
    , sum(session_duration) total_session_duration
    , sum(page_views) page_views
    , sum(add_to_cart) add_to_cart
    , sum(checkouts) checkouts
    , sum(package_shipped) package_shipped
from sessions
group by user_id