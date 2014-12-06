#!/usr/bin/env ruby

require "./lib/bank"
require "./lib/account"
require "./lib/transaction"
require "./lib/requester"

# Create a new bank
@bank = Bank.new
@bank.ifsc_code = "ICIC0000001"

# Create a new account
@account = Account.new
@account.number = "11111111"

# Create a new transaction
@transaction = Transaction.new
@transaction.amount = 10000.00
@transaction.merchant_transaction_ref = "txn001"
@transaction.payment_gateway_merchant_reference = "merc001"
@transaction.bank = @bank
@transaction.account = @account

# Send a payment request to the server
@requester = Requester.new
@requester.transaction = @transaction

@requester.url = "http://localhost:9292"
response = @requester.process

print response.body
