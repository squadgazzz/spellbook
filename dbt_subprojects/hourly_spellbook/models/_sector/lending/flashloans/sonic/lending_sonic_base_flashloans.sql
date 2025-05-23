{{
  config(
    schema = 'lending_sonic',
    alias = 'base_flashloans',
    materialized = 'view'
  )
}}

{%
  set models = [
    ref('aave_v3_sonic_base_flashloans')
  ]
%}

{% for model in models %}
select
  blockchain,
  project,
  version,
  recipient,
  amount,
  fee,
  token_address,
  project_contract_address,
  block_month,
  block_time,
  block_number,
  tx_hash,
  evt_index
from {{ model }}
{% if not loop.last %}
union all
{% endif %}
{% endfor %}
