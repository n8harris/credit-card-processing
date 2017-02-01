CreditCard = require "#{process.cwd()}/dist/lib/CreditCard"
Credit = require "#{process.cwd()}/dist/lib/credit"
Charge = require "#{process.cwd()}/dist/lib/charge"
Validator = require "#{process.cwd()}/dist/lib/validator"

describe 'credit card', ->

  beforeEach ->
    credit = new Credit()
    charge = new Charge()
    validator = new Validator()
    @creditCard = new CreditCard('Nate', 1234567890123456, 1000, credit, charge, validator)

  it 'should be invalid card', ->
    @creditCard.isValid().should.eql false

  it 'should set to valid when number is changed', ->
    @creditCard.setNumber 5454545454545454
    @creditCard.isValid().should.eql true

  it 'should not charge since number is invalid', ->
    @creditCard.charge(800)
    @creditCard.getBalance(false, true).should.eql 0

  it 'should not credit since number is invalid', ->
    @creditCard.credit(800)
    @creditCard.getBalance(false, true).should.eql 0

  it 'should charge when number is valid', ->
    @creditCard.setNumber 5454545454545454
    @creditCard.charge(800)
    @creditCard.getBalance().should.eql 800

  it 'should credit when number is valid', ->
    @creditCard.setNumber 5454545454545454
    @creditCard.credit(800)
    @creditCard.getBalance().should.eql -800

  it 'should return "error" when number is invalid', ->
    @creditCard.getBalance().should.eql "error"

  it 'should return "$" when format is set to true', ->
    @creditCard.setNumber 5454545454545454
    @creditCard.getBalance(true).should.eql "$0"

