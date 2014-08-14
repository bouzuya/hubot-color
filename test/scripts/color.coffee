{Robot, User, TextMessage} = require 'hubot'
assert = require 'power-assert'
path = require 'path'
sinon = require 'sinon'

describe 'hubot-color', ->
  beforeEach (done) ->
    @sinon = sinon.sandbox.create()
    # for warning: possible EventEmitter memory leak detected.
    # process.on 'uncaughtException'
    @sinon.stub process, 'on', -> null
    @robot = new Robot(path.resolve(__dirname, '..'), 'shell', false, 'hubot')
    @robot.adapter.on 'connected', =>
      @robot.load path.resolve(__dirname, '../../src/scripts')
      done()
    @robot.run()

  afterEach (done) ->
    @robot.brain.on 'close', =>
      @sinon.restore()
      done()
    @robot.shutdown()

  describe 'listeners[0].regex', ->
    beforeEach ->
      @sender = new User 'bouzuya', room: 'hitoridokusho'
      @callback = @sinon.spy()
      @robot.listeners[0].callback = @callback

    describe 'receive "@hubot color green"', ->
      beforeEach ->
        message = '@hubot color green'
        @robot.adapter.receive new TextMessage(@sender, message)

      it 'matches', ->
        assert @callback.callCount is 1
        match = @callback.firstCall.args[0].match
        assert match.length is 2
        assert match[0] is '@hubot color green'
        assert match[1] is 'green'

    describe 'receive "@hubot color #4e6a41"', ->
      beforeEach ->
        message = '@hubot color #4e6a41'
        @robot.adapter.receive new TextMessage(@sender, message)

      it 'matches', ->
        assert @callback.callCount is 1
        match = @callback.firstCall.args[0].match
        assert match.length is 2
        assert match[0] is '@hubot color #4e6a41'
        assert match[1] is '#4e6a41'

    describe 'receive "@hubot color rgb(78, 106, 65)"', ->
      beforeEach ->
        message = '@hubot color rgb(78, 106, 65)'
        @robot.adapter.receive new TextMessage(@sender, message)

      it 'matches', ->
        assert @callback.callCount is 1
        match = @callback.firstCall.args[0].match
        assert match.length is 2
        assert match[0] is '@hubot color rgb(78, 106, 65)'
        assert match[1] is 'rgb(78, 106, 65)'

    describe 'receive "@hubot color hsl(101, 24%, 34%)"', ->
      beforeEach ->
        message = '@hubot color hsl(101, 24%, 34%)'
        @robot.adapter.receive new TextMessage(@sender, message)

      it 'matches', ->
        assert @callback.callCount is 1
        match = @callback.firstCall.args[0].match
        assert match.length is 2
        assert match[0] is '@hubot color hsl(101, 24%, 34%)'
        assert match[1] is 'hsl(101, 24%, 34%)'

  describe 'listeners[0].callback', ->
    beforeEach ->
      @hello = @robot.listeners[0].callback
      @send = @sinon.spy()

    describe 'receive "@hubot color #4e6a41"', ->
      beforeEach ->
        @hello
          match: ['@hubot color #4e6a41', '#4e6a41']
          send: @send

      it 'send "color #4e6a41 is ..."', ->
        assert @send.callCount is 1
        assert @send.firstCall.args[0] is 'color #4e6a41 is ' +
          'rgb(78, 106, 65), hsl(101, 24%, 34%), #4e6a41.'

    describe 'receive "@hubot color rgb(78, 106, 65)"', ->
      beforeEach ->
        @hello
          match: ['@hubot color rgb(78, 106, 65)', 'rgb(78, 106, 65)']
          send: @send

      it 'send "color rgb(78, 106, 65) is ..."', ->
        assert @send.callCount is 1
        assert @send.firstCall.args[0] is 'color rgb(78, 106, 65) is ' +
          'rgb(78, 106, 65), hsl(101, 24%, 34%), #4e6a41.'

    describe 'receive "@hubot color #1234"', ->
      beforeEach ->
        @hello
          match: ['@hubot color #1234', '#1234']
          send: @send

      it 'send "color #1234 is invalid."', ->
        assert @send.callCount is 1
        assert @send.firstCall.args[0] is 'color #1234 is invalid.'
