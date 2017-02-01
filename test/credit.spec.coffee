Credit = require "#{process.cwd()}/dist/lib/Credit"

describe 'credit', ->

  beforeEach ->
    @credit = new Credit()

  it 'should decrease balance', ->
    balance = 1000
    amount = 1500
    @credit.run(amount, balance).should.eql -500