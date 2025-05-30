{{
  config(
    schema = 'uwulend_ethereum',
    alias = 'base_supply',
    materialized = 'incremental',
    file_format = 'delta',
    incremental_strategy = 'merge',
    unique_key = ['transaction_type', 'token_address', 'tx_hash', 'evt_index'],
    incremental_predicates = [incremental_predicate('DBT_INTERNAL_DEST.block_time')]
  )
}}

{{
  lending_aave_v2_compatible_supply(
    blockchain = 'ethereum',
    project = 'uwulend',
    version = '1',
    project_decoded_as = 'uwulend',
    wrapped_token_gateway_available = false
  )
}}
