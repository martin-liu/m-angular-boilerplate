'use strict'
App.factory 'SampleRemoteService', (Restangular, BaseRemoteService) ->
  new class SampleRemoteService extends BaseRemoteService
    constructor: ->
      super()
      @rest = Restangular.all('sample')

    query: (param)->
      @getWithCache 'test', param, =>
        @rest.one('test').get param
