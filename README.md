Transaction Processor
===

This is a command-line application that takes a BDI file over stdin, processes all the contained transactions, and outputs its results as JSON on stdout.

A BDI file is a text file that looks like this:
```
/*BDI*/
Batch: 99
Description: Payroll for January
==
Transaction: 301
Originator: 111222333 / 9991
Recipient: 444555666 / 123456
Type: Credit
Amount: 10000
==
Transaction: 302
Originator: 111222333 / 9991
Recipient: 123456789 / 55550
Type: Credit
Amount: 380100
==
Transaction: 305
Originator: 111222333 / 9992
Recipient: 444555666 / 8675309
Type: Debit
Amount: 999
==
```


The program is run with a command that looks like this:

$ ./program data.bdi

Example output:

{
batch: 99,
description: "Payroll for January",
accounts: [
{
routing_number: "111222333",
account_number: "9991",
net_transactions: -390100
},
{
routing_number: "444555666",
account_number: "123456",
net_transactions: 10000
},
...
]
}
