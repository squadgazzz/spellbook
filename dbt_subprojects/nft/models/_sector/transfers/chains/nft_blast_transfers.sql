{{ config(
        
        schema = 'nft_blast',
        alias = 'transfers',
        partition_by=['block_month'],
        materialized='incremental',
        file_format = 'delta',
        incremental_strategy = 'merge',
        incremental_predicates = [incremental_predicate('DBT_INTERNAL_DEST.block_time')],
        unique_key = ['tx_hash', 'evt_index', 'token_id', 'amount']
)
}}

{{nft_transfers(
    blockchain='blast'
    , base_transactions = source('blast','transactions')
    , erc721_transfers = source('erc721_blast','evt_Transfer')
    , erc1155_single = source('erc1155_blast','evt_TransferSingle')
    , erc1155_batch = source('erc1155_blast', 'evt_TransferBatch')
)}}
