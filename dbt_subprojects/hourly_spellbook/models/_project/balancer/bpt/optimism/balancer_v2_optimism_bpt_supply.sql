{% set blockchain = 'optimism' %}

{{
    config(
        schema = 'balancer_v2_optimism',
        alias = 'bpt_supply',
        materialized = 'table',
        file_format = 'delta'
    )
}}

{{ 
    balancer_v2_compatible_bpt_supply_macro(
        blockchain = blockchain,
        version = '2',        
        project_decoded_as = 'balancer_v2',
        pool_labels_model = 'balancer_v2_pools_optimism',
        transfers_spell = ref('balancer_v2_optimism_transfers_bpt')
    )
}}