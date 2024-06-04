

import sys
import pandas as pd
import duckdb

data_bin                = pd.read_csv('/Users/conner/Documents/Programming/anduril/files/data/bin.csv')
data_costs              = pd.read_csv('/Users/conner/Documents/Programming/anduril/files/data/costs.csv')
data_inventory_status   = pd.read_csv('/Users/conner/Documents/Programming/anduril/files/data/inventory_status.csv')
data_item               = pd.read_csv('/Users/conner/Documents/Programming/anduril/files/data/item.csv')
data_location           = pd.read_csv('/Users/conner/Documents/Programming/anduril/files/data/location.csv')
data_transaction_line   = pd.read_csv('/Users/conner/Documents/Programming/anduril/files/data/transaction_line.csv')

# print(data_bin)
# print(data_costs)
# print(data_inventory_status)
# print(data_item)
# print(data_location.head())
# print(data_location.shape)

def profiler():

    print('- - -')
    print('info')
    print(data_transaction_line.info())
    print('- - -')
    print('shape')
    print(data_transaction_line.shape)
    print('- - -')
    print('sample')
    print(data_transaction_line.head())
    print('- - -')

# print(data_bin)

print(profiler())


