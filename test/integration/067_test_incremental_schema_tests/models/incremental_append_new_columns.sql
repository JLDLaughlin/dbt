{{
    config(
        materialized='incremental',
        on_schema_change='append_new_columns'
    )
}}

WITH source_data AS (SELECT * FROM {{ ref('model_a') }} )

{% if is_incremental()  %}

SELECT id, field1, field2, field3, field4 FROM source_data WHERE id NOT IN (SELECT id from {{ this }} )

{% else %}

SELECT id, field1, field2 FROm source_data LIMIT 3

{% endif %}