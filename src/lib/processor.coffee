CreditCard = require "#{process.cwd()}/dist/lib/creditcard"

class Processor
  constructor: () ->
    @cards = {}

  createCreditCard: (owner, number, limit) ->
    new CreditCard(owner, number, limit)

  # Generate summary in alphabetical order if returnOrdered param is true
  generateSummary: (returnOrdered) ->
    summary = []
    if returnOrdered
      orderedKeys = Object.keys(@cards).sort()
      for index, card of orderedKeys
        summary.push @generateCardSummary(card)
    else
      for card of @cards
        summary.push @generateCardSummary(card)
    summary

  generateCardSummary: (card) ->
    @cards[card].getOwnerName() + ": " + @cards[card].getBalance(true)

  processLine: (line) ->
    parts = line.split(" ")
    switch parts[0]
      when "Add"
        card = @createCreditCard(parts[1], Number(parts[2]), Number(@removeDollarSign(parts[3])))

        # Add card to @cards object using the person's name as a key. This can be changed later
        # if we need to support multiple people with the same name
        @cards[card.getOwnerName()] = card
      when "Charge"
        @cards[parts[1]].charge(Number(@removeDollarSign(parts[2])))
      when "Credit"
        @cards[parts[1]].credit(Number(@removeDollarSign(parts[2])))
      else break

  removeDollarSign: (amount) ->
    amount.replace('$', '')

  getCards: () ->
    @cards

module.exports = Processor

