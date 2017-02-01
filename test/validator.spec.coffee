Validator = require "#{process.cwd()}/dist/lib/validator"

describe 'validator', ->

  beforeEach ->
    @validator = new Validator()

  it 'should validate correct number', ->
    @validator.validate([5,4,5,4,5,4,5,4,5,4,5,4,5,4,5,4]).should.eql true

  it 'should invalidate incorrect number', ->
    @validator.validate([1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6]).should.eql false

  it 'should generate correct number array', ->
    @validator.setNumber(5454545454545454)
    @validator.getNumArray().should.eql [5,4,5,4,5,4,5,4,5,4,5,4,5,4,5,4]

  it 'should not be a valid length', ->
    @validator.validLength(20).should.eql false

  it 'should be a valid length', ->
    @validator.validLength(19).should.eql true