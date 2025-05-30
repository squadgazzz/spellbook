{{config(
    alias = 'token_standards_optimism',
        post_hook='{{ expose_spells(\'["optimism"]\',
                                    "sector",
                                    "labels",
                                    \'["hildobby"]\') }}')}}

SELECT distinct 'optimism' AS blockchain
, erc20.contract_address AS address
, 'erc20' AS name
, 'infrastructure' AS category
, 'hildobby' AS contributor
, 'query' AS source
, TIMESTAMP '2023-03-02' AS created_at
, NOW() AS updated_at
, 'token_standard' AS model_name
, 'persona' as label_type
FROM {{ source('erc20_optimism', 'evt_Transfer') }} erc20
{% if is_incremental() %}
LEFT JOIN this t
    ON t.address = erc20.contract_address
WHERE t.address IS NULL
    AND erc20.evt_block_time >= date_trunc('day', now() - interval '7' day)
{% endif %}

UNION ALL

SELECT distinct 'optimism' AS blockchain
, nft.contract_address AS address
, token_standard AS name
, 'infrastructure' AS category
, 'hildobby' AS contributor
, 'query' AS source
, TIMESTAMP '2023-03-02' AS created_at
, NOW() AS updated_at
, 'token_standard' AS model_name
, 'persona' as label_type
FROM {{ source('nft_optimism', 'transfers') }} nft
{% if is_incremental() %}
LEFT JOIN this t
    ON t.address = nft.contract_address
WHERE t.address IS NULL
    AND nft.block_time >= date_trunc('day', now() - interval '7' day)
{% endif %}
