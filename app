#!/usr/bin/env ruby

require "./lib/bank"
require "./lib/account"
require "./lib/transaction"
require "./lib/requester"

@bank = Bank.new
@bank.ifsc_code = "ICIC0000001"

@account = Account.new
@account.number = "11111111"

@transaction = Transaction.new
@transaction.amount = 10000.00
@transaction.merchant_transaction_ref = "txn001"
@transaction.payment_gateway_merchant_reference = "merc001"
@transaction.bank = @bank
@transaction.account = @account
@transaction.prepare_string
p @transaction.hashify
p @transaction.unhashify

@requester = Requester.new
@requester.options = {
  :transaction => @transaction
}
@requester.url = "http://localhost:9292"
@requester.process
