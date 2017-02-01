Charge = require "#{process.cwd()}/dist/lib/Charge"

describe 'charge', ->

  beforeEach ->
    @charge = new Charge()

  it 'should increase balance', ->
    balance = 1000
    limit = 1500
    amount = 300
    @charge.run(amount, balance, limit).should.eql 1300

  it 'should decline charge', ->
    balance = 1000
    limit = 1500
    amount = 501
    @charge.run(amount, balance, limit).should.eql 1000