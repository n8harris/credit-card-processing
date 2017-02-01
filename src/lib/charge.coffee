class Charge

  run: (amount, balance, limit) ->
    newBalance = balance + amount
    
    # Only adjust balance if the amount doesn't tip it over the limit
    if newBalance > limit
      newBalance = balance
    newBalance

module.exports = Charge

