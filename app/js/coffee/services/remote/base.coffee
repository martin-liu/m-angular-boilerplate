'use strict'
App.factory 'BaseRemoteService', (Config, Restangular, Util, $q, $timeout) ->
  class BaseRemoteService
    constructor: ->
      @rest = Restangular.all('')
    getCacheKey: (method, param)->
      classMatch = /function\s+(\w+)\(.*\).*/.exec @.constructor.toString()
      if classMatch.length == 2
        className = classMatch[1]

      "#{Config.name}_#{className}_#{method}_#{JSON.stringify param}"

    # Session cache
    getWithCache: (method, param, func, timeout=300)->
      Util.getWithCache @getCacheKey(method, param), true, func, timeout

    queryWithCanceler: (method, param, canceler) ->
      @getWithCache method, param, ->
        if canceler && canceler.promise
          config = {timeout: canceler.promise}
          @rest.one(method).withHttpConfig(config).get param
        else
          @rest.one(method).get param

    mockResult: (data, time = 1000)->
      defer = $q.defer()
      $timeout ->
        defer.resolve data
      , time

      defer.promise
