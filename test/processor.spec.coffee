Processor = require "#{process.cwd()}/dist/lib/processor"

describe 'processor', ->

  beforeEach ->
    @processor = new Processor()

  it 'should return correct results', ->
    @processor.processLine("Add Tom 4111111111111111 $1000")
    @processor.processLine("Charge Tom $500")
    @processor.processLine("Charge Tom $800")
    results = @processor.generateSummary(true)
    results[0].should.eql 'Tom: $500'

  it 'should process Add correctly', ->
    @processor.processLine("Add Tom 4111111111111111 $1000")
    @processor.getCards()['Tom'].getOwnerName().should.eql 'Tom'
    @processor.getCards()['Tom'].getBalance().should.eql 0
    @processor.getCards()['Tom'].getNumber().should.eql 4111111111111111
    @processor.getCards()['Tom'].getLimit().should.eql 1000

  it 'should remove dollar sign', ->
    @processor.removeDollarSign("$1000").should.eql '1000'

