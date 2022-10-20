{{
    config(
        materialized='table'
    )
}}

with users as (
    select * from {{ ref('stg_greenery_users')}}
),

addresses as (
    select * from {{ ref('stg_greenery_addresses')}}
),

final as (
    SELECT
          users.USER_ID 
        , users.FIRST_NAME
        , users.LAST_NAME 
        , users.EMAIL 
        , users.PHONE_NUMBER
        , users.CREATED_AT 
        , users.UPDATED_AT
        , addresses.address
        , addresses.country
        , addresses.zipcode
        , addresses.state
    from users
        left join addresses
            on users.address_id=addresses.address_id
)

select * from final