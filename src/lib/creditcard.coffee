Credit = require "#{process.cwd()}/dist/lib/credit"
Charge = require "#{process.cwd()}/dist/lib/charge"
Validator = require "#{process.cwd()}/dist/lib/validator"

class CreditCard

  constructor: (owner, number, limit, credit = null, charge = null, validator = null) ->
    @balance = 0
    @owner = owner
    @number = number
    @limit = limit

    # These can be changed on the fly. So, if we wanted different behaviors for
    # credit and charge or a different type of validation, we just have to pass the
    # new type in the constructor.
    @creditBehavior = if credit then credit else new Credit()
    @chargeBehavior = if charge then charge else new Charge()
    @validator = if validator then validator else new Validator()
    @valid = @checkValidity()

  charge: (amount) ->
    if @isValid()
      @balance = @chargeBehavior.run(amount, @balance, @limit)

  credit: (amount) ->
    if @isValid()
      @balance = @creditBehavior.run(amount, @balance)

  checkValidity: () ->
    @validator.run(@number)

  isValid: () ->
    @valid

  getOwnerName: () ->
    @owner

  getBalance: (format, ignoreValidity = false) ->
    if @isValid() or ignoreValidity
      if format
        # Return balance as string with dollar sign
        "$" + @balance
      else
        @balance
    else
      "error"

  getNumber: () ->
    @number

  getLimit: () ->
    @limit

  setNumber: (number) ->
    @number = number
    @valid = @checkValidity()

  setOwner: (owner) ->
    @owner = owner

  setLimit: (limit) ->
    @limit = limit

  setBalance: (balance) ->
    @balance = balance

module.exports = CreditCard