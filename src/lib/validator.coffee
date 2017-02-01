class Validator

  MAX_SIZE: 19

  constructor: (number) ->
    @number = number

  run: (number) ->
    @setNumber(number)
    numArray = @getNumArray()
    @validate(numArray)

  getNumArray: () ->
    # Turn number into array of numbers for easy traversal during Luhn 10
    @number.toString().split('').map Number

  validLength: (arrayLength) ->
    arrayLength <= @MAX_SIZE

  validate: (numArray) ->
    arrayLength = numArray.length

    # Return non valid if length is greater than MAX_SIZE
    return false unless @validLength(arrayLength)
    sum = 0

    # Reverse the array and go through Luhn 10 algorithm
    for num, index in numArray.reverse()
      if index % 2
        num *= 2
        if num > 9
          num -= 9
      sum += num
    (sum * 9) % 10 == 0

  setNumber: (number) ->
    @number = number

module.exports = Validator
