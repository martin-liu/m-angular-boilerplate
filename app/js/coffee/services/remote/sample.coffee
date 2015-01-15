'use strict'
App.factory 'SampleRemoteService', (Restangular, BaseRemoteService) ->
  new class SampleRemoteService extends BaseRemoteService
    constructor: ->
      super()
      @rest = Restangular.all('sample')

    query: (param)->
      @doQuery 'query', param, 300

    queryWithCanceler: (param, canceler)->
      @doQuery 'testquery', param, 300, canceler
