module.exports = (grunt) ->

  # Require all grunt plugins at once
  require('load-grunt-tasks')(grunt)

  ###
  # tasks
  ###
  grunt.registerTask 'lint',    [ 'coffeelint' ]
  grunt.registerTask 'test',    [ 'build', 'mochacov:spec', 'coffeelint' ]
  grunt.registerTask 'cov',     [ 'mochacov:cov' ]
  grunt.registerTask 'default', [ 'test' ]
  grunt.registerTask 'build',   [ 'clean', 'coffee:dist' ]

  ###
  # config
  ###
  grunt.initConfig

    # Tests and coverage tests
    # When running cov you will need to pipe your output
    mochacov :
      travis :
        options : coveralls : serviceName : 'travis-ci'
      spec :
        options : reporter : 'spec'
      cov  :
        options : reporter : 'html-cov'
      options :
        compilers : [ 'coffee:coffee-script/register' ]
        files     : [ 'test/**/*.spec.coffee' ]
        require   : [ 'should', 'src/lib/creditcard' ]
        growl     : true
        ui        : 'tdd'
        bail      : true # Fail fast

    # Lint our coffee files
    # Linting is unobtrusive. If linting errors happen then they wont break the process
    coffeelint:
      options:
        force: true # Display lint errors as warnings. Do not break.
        configFile: 'coffeelint.json'
      files: [ 'src/**/*.coffee', 'test/**/*.coffee' ]


    # Watch for file changes.
    watch:
      lib:
        files : [ '**/*.coffee' ]
        tasks : [ 'test' ]
        options : nospawn : true

    # Clear the contents of a directory
    clean: [ 'dist']

    # Bump the version and build the tags
    bump:
      options:
        files  : [ 'package.json' ]
        commit : false
        push   : false

    # Deal with coffeescript concatenation and compiling
    coffee:
      options: join: false
      dist:
        files:
          'dist/credit-card-processing.js' : 'src/main.coffee',
          'dist/lib/charge.js' : 'src/lib/charge.coffee',
          'dist/lib/credit.js' : 'src/lib/credit.coffee',
          'dist/lib/creditcard.js' : 'src/lib/creditcard.coffee',
          'dist/lib/processor.js' : 'src/lib/processor.coffee',
          'dist/lib/validator.js' : 'src/lib/validator.coffee'


