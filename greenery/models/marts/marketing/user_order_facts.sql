{{
    config(
        materialized='table'
    )
}}

with users as (
    select *
 from {{ ref('stg_greenery_users') }}
),

orders as (
    select
          user_id
        , count(*) as order_count
        , sum(order_total) as spend_lifetime
        , sum(order_units) as units_lifetime
        , min(created_at) as first_order
        , max(created_at) as latest_order
    from {{ ref('fact_orders') }}
    group by user_id
),

user_sessions as (
    select *
    from {{ ref('int_user_sessions_agg') }}
)

select    
      u.user_id
    , u.first_name
    , u.last_name
    , u.email
    , u.phone_number
    , u.created_at as user_registration_utc
    , u.updated_at as user_updated_utc
    , zeroifnull(o.order_count) order_count
    , zeroifnull(o.spend_lifetime) spend_lifetime
    , zeroifnull(o.units_lifetime) units_lifetime
    , o.first_order
    , o.latest_order
    , us.first_session
    , us.last_session
    , us.sessions
    , us.total_session_duration 
    , us.page_views
    , us.add_to_cart
    , us.checkouts
    , us.package_shipped

from users u
left join orders o
    on u.user_id = o.user_id
left join user_sessions us
    on u.user_id = us.user_id