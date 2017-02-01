# Credit Card Processing

This program takes input from a file or stdin, adds credit cards, processes charges and credits on those cards, and outputs balances.

### Getting started

To install necessary dependencies and compile the CoffeeScript into JS, run `npm install`

```bash
$ npm install
```

### Starting Program

The program can be started in two ways. The file in the examples below is included in this project, but any file can be used as long as it follows the format of the example file.

##### File Argument

At the root of project:

```bash
$ node ./dist/credit-card-processing.js test-case.txt
```

##### StdIn

At the root of project:

```bash
$ node ./dist/credit-card-processing.js < test-case.txt
```


### Testing

All of the tests for this project can be found in the `test` directory.

This command will watch for file changes and rerun tests each time:
```bash
  $ grunt watch
```

This command will run the spec tests:
```bash
  $ grunt test  
```

### Design Decisions

First of all, I decided to use NodeJS / CoffeeScript since most of the work I have been doing recently has been in JS. Also, CoffeeScript provides an easy to use OO syntax with most of the redundancy of JS removed which allows for much faster development. In many ways, the CoffeeScript syntax reminds me of Ruby quite a bit.

This program contains 5 classes: `Charge`, `Credit`, `CreditCard`, `Processor`, and `Validator`.

The `Charge` and `Credit` classes are used to encapsulate the charging and crediting behavior. I decided to use this sort of pattern so that if we wanted to try out different charging or crediting methods we could just plug and play the behaviors into the `CreditCard` class.

The `CreditCard` class is used to encapsulate credit card information. It contains member variables for the owner of the card, the card number, the balance, and the limit. The `getBalance()` method has two ways of outputting the balance. If the `format` parameter is passed in as `true`, it will output the balance as a string with '$' added to the front.

The `Processor` class is used to process lines from the input and generate a summary once end of input is reached. I use a switch statement in the `processLine()` function to check the command part of the line. This allows the `processLine()` function to be very readable. The `generateSummary()` function has an optional parameter `isOrdered`. This allows flexibility if we don't want the summary to be output in alphabetical order in the future.

The `Validator` class contains the Luhn 10 algorithm for validating cards. I separated this into its own class so that if we ever wanted to use a different validation algorithm we could just plug the new one into the `CreditCard` constructor. For the algorithm, I first generate an array from the passed-in number. I then reverse the array and run the algorithm on the array.


