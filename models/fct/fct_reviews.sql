{{
 config(
 materialized = 'incremental',
 unique_key='listing_id',
 on_schema_change='fail',
 incremental_strategy='merge'
 )
}}
WITH src_reviews AS (
 SELECT * FROM {{ ref('src_reviews') }}
)
SELECT * FROM src_reviews
WHERE review_text is not null
{% if is_incremental() %}
 AND review_date > (select max(review_date) from {{ this }})
{% endif %}