'use strict'
App.factory 'DSSOneRemoteService', (Restangular, BaseRemoteService) ->
  new class SampleRemoteService extends BaseRemoteService
    constructor: ->
      super()
      @rest = Restangular.all('sample')

    query: (param)->
      @doQuery 'test1', param

    queryWithCanceler: (param, canceler)->
      @doQuery 'test2', param, canceler

    queryWithCache: (param)->
      @doQueryWithCache 'test3', param, null, 300

    queryWithCancelerAndCache: (param, canceler)->
      @doQueryWithCache 'test4', param, canceler, 300
